import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:have_you_heard/features/game/data/ds/deezer_data_source.dart';
import 'package:have_you_heard/features/game/data/ds/spotify_data_source.dart';
import 'package:have_you_heard/features/game/domain/usecases/get_preview_url.dart';
import 'package:have_you_heard/features/home/data/ds/user_data_soruce.dart';
import 'package:have_you_heard/features/home/data/repositories/user_repository.dart';
import 'package:have_you_heard/features/home/domain/repositories/user_repository.dart';
import 'package:have_you_heard/features/home/domain/usecases/get_user.dart';
import '../../features/auth/data/spotify_auth_service.dart';
import '../../features/auth/data/spotify_auth_storage.dart';
import '../../features/auth/data/spotify_token_store.dart';
import '../../features/game/data/repositories/track_repository_impl.dart';
import '../../features/game/domain/repositories/track_repository.dart';
import '../../features/game/domain/usecases/get_top_tracks.dart';
import '../network/dio_client.dart';


final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Auth state
  sl.registerLazySingleton(() => SpotifyTokenStore());
  sl.registerLazySingleton(() => SpotifyAuthStorage());

  // Auth
  sl.registerLazySingleton(
    () => SpotifyAuthService(storage: sl(), tokenStore: sl()),
  );

  // Network
  sl.registerLazySingleton<Dio>(
    () => DioClient.createSpotifyDio(sl(), sl()),
  );

  // Data sources
  sl.registerLazySingleton(() => SpotifyDataSource(sl()));
  sl.registerLazySingleton(() => DeezerDataSource());

  // Repository
  sl.registerLazySingleton<TrackRepository>(
    () => TrackRepositoryImpl(
      spotifyDataSource: sl(),
      deezerDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTopTracks(sl()));
  sl.registerLazySingleton(() => GetPreviewUrl(sl()));

  // Home
  sl.registerLazySingleton<UserDataSoruce>(
    () => UserDataSoruceImpl(dio: sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImp(dataSource: sl()),
  );
  sl.registerLazySingleton(() => GetUser(repository: sl()));
}