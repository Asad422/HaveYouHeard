part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginWithSpotifyEvent extends AuthEvent {
  const LoginWithSpotifyEvent();

  @override
  List<Object> get props => [];
}



