part of 'home_bloc.dart';

class HomeState extends Equatable {
  final User? user;
  final List<Artist>? artists;
  final bool isLoading;
  final Failure? failure;

  const HomeState({
    this.user,
    this.artists,
    this.isLoading = false,
    this.failure,
  });

  HomeState copyWith({                                                                                 
    User? user,                                                                                          
    bool? isLoading,                                                                                     
    List<Artist>? artists,
    Failure? failure,                                                                                    
  }) => HomeState(
    user: user ?? this.user,                                                                             
    isLoading: isLoading ?? this.isLoading,                                                            
    artists: artists ?? this.artists,
    failure: failure,
  );                                                                                                     
   

  @override
  List<Object?> get props => [user, isLoading, failure,artists];
}




