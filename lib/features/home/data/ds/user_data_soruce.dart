

import 'package:dio/dio.dart';
import 'package:have_you_heard/features/home/data/dto/spotify_artist_dto.dart';
import 'package:have_you_heard/features/home/data/dto/spotify_user_dto.dart';

abstract class UserDataSoruce {
  Future<SpotifyUserDto> getUser();
  Future<List<SpotifyArtistDto>> getUserArtists();
}


class UserDataSoruceImpl implements UserDataSoruce{
  final Dio _dio;

  UserDataSoruceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<SpotifyUserDto> getUser() async{
    final response = await _dio.get('/me');
    return SpotifyUserDto.fromJson(response.data);
  }
  
  @override
  Future<List<SpotifyArtistDto>> getUserArtists() async {
    final response = await _dio.get('/me/following', queryParameters: {'type': 'artist'});
    final data = response.data as Map<String, dynamic>;
    final items = data['artists']['items'] as List;
    return items.map((e) => SpotifyArtistDto.fromJson(e)).toList();
  }
}