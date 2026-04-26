import 'package:dio/dio.dart';
import 'package:have_you_heard/core/constants/app_contstants.dart';
import '../models/spotify_track_model.dart';

class SpotifyDataSource {
  final Dio _dio;

  SpotifyDataSource(this._dio);

  Future<List<SpotifyTrackModel>> getTopTracks() async {
    final response = await _dio.get(
      '${ApiConstants.spotifyBaseUrl}/playlists/37i9dQZEVXbMDoHDwVN2tF/tracks',
    );

    final items = response.data['items'] as List;
    return items
        .map((item) => SpotifyTrackModel.fromJson(item['track']))
        .toList();
  }

  Future<List<SpotifyTrackModel>> searchTracks(String query) async {
    final response = await _dio.get(
      '${ApiConstants.spotifyBaseUrl}/search',
      queryParameters: {
        'q': query,
        'type': 'track',
        'limit': 50,
      },
    );

    final items = response.data['tracks']['items'] as List;
    return items
        .map((item) => SpotifyTrackModel.fromJson(item))
        .toList();
  }
}