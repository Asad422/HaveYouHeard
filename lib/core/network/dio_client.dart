import 'package:dio/dio.dart';
import '../../features/auth/data/spotify_auth_service.dart';
import '../../features/auth/data/spotify_token_store.dart';

class DioClient {
  static Dio createSpotifyDio(
    SpotifyTokenStore tokenStore,
    SpotifyAuthService authService,
  ) {
    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
    dio.interceptors.add(SpotifyInterceptor(tokenStore, authService, dio));
    return dio;
  }
}

class SpotifyInterceptor extends Interceptor {
  static const String _retriedFlag = 'retried_after_refresh';

  final SpotifyTokenStore _tokenStore;
  final SpotifyAuthService _authService;
  final Dio _dio;

  SpotifyInterceptor(this._tokenStore, this._authService, this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokenStore.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final alreadyRetried = err.requestOptions.extra[_retriedFlag] == true;
    if (err.response?.statusCode == 401 && !alreadyRetried) {
      final newToken = await _authService.refreshAccessToken();
      if (newToken != null) {
        err.requestOptions.extra[_retriedFlag] = true;
        try {
          final response = await _dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } on DioException catch (retryErr) {
          return handler.next(retryErr);
        }
      }
    }
    handler.next(err);
  }
}
