import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

import 'package:have_you_heard/core/constants/app_contstants.dart';
import 'spotify_auth_storage.dart';
import 'spotify_token_store.dart';

class SpotifyAuthService {
  final Dio _dio;
  final SpotifyAuthStorage _storage;
  final SpotifyTokenStore _tokenStore;
  Future<String?>? _refreshing;

  SpotifyAuthService({
    required SpotifyAuthStorage storage,
    required SpotifyTokenStore tokenStore,
    Dio? dio,
  })  : _storage = storage,
        _tokenStore = tokenStore,
        _dio = dio ?? Dio();

  Future<String?> loginWithSpotify() async {
    final url = Uri.https('accounts.spotify.com', '/authorize', {
      'client_id': ApiConstants.spotifyClientId,
      'response_type': 'code',
      'redirect_uri': ApiConstants.spotifyRedirectUri,
      'scope': 'user-read-private user-read-email user-top-read',
    });
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: url.toString(),
        callbackUrlScheme: 'haveyouheard',
      );
      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) return null;
      return await _requestToken({
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': ApiConstants.spotifyRedirectUri,
      });
    } catch (e, st) {
      log('Spotify login failed', error: e, stackTrace: st);
      return null;
    }
  }

  Future<String?> refreshAccessToken() {
    return _refreshing ??=
        _doRefresh().whenComplete(() => _refreshing = null);
  }

  /// Returns true if a refresh token exists (user has logged in before).
  Future<bool> isLoggedIn() async {
    final token = await _storage.getRefreshToken();
    return token != null;
  }

  Future<void> logout() async {
    await _storage.clearRefreshToken();
    _tokenStore.accessToken = null;
  }

  Future<String?> _doRefresh() async {
    final refreshToken = await _storage.getRefreshToken();
    if (refreshToken == null) return null;

    try {
      return await _requestToken({
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
      });
    } catch (e, st) {
      log('Spotify token refresh failed', error: e, stackTrace: st);
      return null;
    }
  }

  Future<String?> _requestToken(Map<String, String> data) async {
    final response = await _dio.post(
      ApiConstants.spotifyAuthUrl,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Basic ${_basicCredentials()}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    );

    final refreshToken = response.data['refresh_token'] as String?;
    if (refreshToken != null) {
      await _storage.saveRefreshToken(refreshToken);
    }
    final accessToken = response.data['access_token'] as String?;
    if (accessToken != null) {
      _tokenStore.accessToken = accessToken;
    }
    return accessToken;
  }

  String _basicCredentials() => base64Encode(
        utf8.encode(
          '${ApiConstants.spotifyClientId}:${ApiConstants.spotifyClientSecret}',
        ),
      );
}
