


import 'package:dartz/dartz.dart';
import 'package:have_you_heard/core/errors/failures.dart';
import 'package:have_you_heard/features/home/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure,User>> getUser();
}