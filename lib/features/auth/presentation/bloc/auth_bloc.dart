import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:have_you_heard/features/auth/data/spotify_auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SpotifyAuthService spotifyAuthService;
  AuthBloc(this.spotifyAuthService) : super(AuthInitial()) {
    on<LoginWithSpotifyEvent>((event, emit) async{
      emit(AuthLoading());
      final result = await spotifyAuthService.loginWithSpotify();

      if(result != null){
        emit(AuthSuccess());
      }
      emit(AuthFailure(error: "Something went wrong"));
      Future.delayed(Duration(seconds: 2),()=> emit(AuthInitial()));
    });
  }
}
