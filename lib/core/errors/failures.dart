import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  
  @override
  List<Object?> get props => [message];
}

// Сетевая ошибка — для всех фич
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// Нет интернета — для всех фич
class NetworkFailure extends Failure {
  const NetworkFailure() : super('Нет подключения к интернету');
}

// Не авторизован — для всех фич
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super('Необходима авторизация');
}

// Не найдено — для всех фич
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}