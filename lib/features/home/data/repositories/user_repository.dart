


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:have_you_heard/core/errors/failures.dart';
import 'package:have_you_heard/features/home/data/ds/user_data_soruce.dart';
import 'package:have_you_heard/features/home/domain/entities/artist.dart';
import 'package:have_you_heard/features/home/domain/entities/user.dart';
import 'package:have_you_heard/features/home/domain/repositories/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final UserDataSoruce _dataSource;

  UserRepositoryImp({required UserDataSoruce dataSource}) : _dataSource = dataSource;
  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final dto = await _dataSource.getUser();
      return Right(dto.toEntity());
    } on DioException catch (e) {
      return Left(switch (e.response?.statusCode) {
        401 => const UnauthorizedFailure(),
        _ => ServerFailure(e.message ?? 'Ошибка сервера'),
      });
    }
  }

  @override
  Future<Either<Failure, List<Artist>>> getUserArtists()async {
     try {
      final dto = await _dataSource.getUserArtists();
      return Right(dto.map((e)=> e.toEntity()).toList());
    } on DioException catch (e) {
      return Left(switch (e.response?.statusCode) {
        401 => const UnauthorizedFailure(),
        _ => ServerFailure(e.message ?? 'Ошибка сервера'),
      });
    }

  }
  
}