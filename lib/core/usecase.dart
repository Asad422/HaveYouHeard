import 'package:dartz/dartz.dart';
import 'package:have_you_heard/core/errors/failures.dart';

// С параметрами
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// Без параметров
abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}