import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:have_you_heard/core/errors/failures.dart';
import 'package:have_you_heard/features/auth/data/spotify_auth_service.dart';
import 'package:have_you_heard/features/home/domain/entities/user.dart';
import 'package:have_you_heard/features/home/domain/usecases/get_user.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUser getUser;
  final SpotifyAuthService _authService;

  HomeBloc(this.getUser, this._authService) : super(const HomeState()) {
    on<GetUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await getUser();
      result.fold(
        (f) => emit(state.copyWith(isLoading: false, failure: f)),
        (r) => emit(state.copyWith(isLoading: false, user: r)),
      );
    });

    on<LogoutEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, failure: null));
      await _authService.logout();
      emit(const HomeState());
    });
  }
}
