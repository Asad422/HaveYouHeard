

import 'package:dio/dio.dart';
import 'package:have_you_heard/features/home/data/dto/spotify_user_dto.dart';

abstract class UserDataSoruce {
  Future<SpotifyUserDto> getUser();
}


class UserDataSoruceImpl implements UserDataSoruce{
  final Dio _dio;

  UserDataSoruceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<SpotifyUserDto> getUser() async{
    final response = await _dio.get('/me');
    return SpotifyUserDto.fromJson(response.data);
  }

}