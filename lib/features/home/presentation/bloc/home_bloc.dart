import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:have_you_heard/core/errors/failures.dart';
import 'package:have_you_heard/features/auth/data/spotify_auth_service.dart';
import 'package:have_you_heard/features/home/domain/entities/artist.dart';
import 'package:have_you_heard/features/home/domain/entities/user.dart';
import 'package:have_you_heard/features/home/domain/usecases/get_user.dart';
import 'package:have_you_heard/features/home/domain/usecases/get_user_artist.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
    final GetUser getUser;                                                                               
    final GetUserArtist getUserArtists;                                                                 
    final SpotifyAuthService _authService;
                                                                                                         
    HomeBloc(this.getUser, this._authService, this.getUserArtists) : super(const HomeState()) {          
      on<GetUserEvent>(_withLoading(_onGetUser));                                                        
      on<LogoutEvent>(_withLoading(_onLogout));                                                          
      on<GetUserArtistsEvent>(_withLoading(_onGetUserArtists));                                          
    }
                                                                                                         
    EventHandler<E, HomeState> _withLoading<E extends HomeEvent>(                                      
      EventHandler<E, HomeState> handler,
    ) {                                                                                                  
      return (event, emit) {
        emit(state.copyWith(isLoading: true, failure: null));                                            
        return handler(event, emit);                                                                   
      };
    }

    Future<void> _onGetUser(GetUserEvent event, Emitter<HomeState> emit) async {                         
      final result = await getUser();
      result.fold(                                                                                       
        (f) => emit(state.copyWith(isLoading: false, failure: f)),                                     
        (r) => emit(state.copyWith(isLoading: false, user: r)),
      );                                                                                                 
    }
                                                                                                         
    Future<void> _onLogout(LogoutEvent event, Emitter<HomeState> emit) async {                         
      await _authService.logout();
      emit(const HomeState());
    }                                                                                                    
   
    Future<void> _onGetUserArtists(GetUserArtistsEvent event, Emitter<HomeState> emit) async {           
      final result = await getUserArtists();                                                           
      result.fold(
        (f) => emit(state.copyWith(isLoading: false, failure: f)),
        (r) => emit(state.copyWith(isLoading: false, artists: r)),                                       
      );
    }                                                                                                    
  }         