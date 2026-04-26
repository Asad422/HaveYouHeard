

import 'package:dartz/dartz.dart';
import 'package:have_you_heard/core/errors/failures.dart';
import 'package:have_you_heard/core/usecase.dart';
import 'package:have_you_heard/features/home/domain/entities/user.dart';
import 'package:have_you_heard/features/home/domain/repositories/user_repository.dart';

class GetUser extends UseCaseNoParams<User> {
    final UserRepository repository;
    GetUser({required this.repository});
    @override
    Future<Either<Failure, User>> call() async {
      return await repository.getUser();
    }
  }