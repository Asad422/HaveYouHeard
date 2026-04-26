part of 'home_bloc.dart';

class HomeState extends Equatable {
  final User? user;
  final bool isLoading;
  final Failure? failure;

  const HomeState({
    this.user,
    this.isLoading = false,
    this.failure,
  });

  HomeState copyWith({
    User? user,
    bool? isLoading,
    Failure? failure,
  }) => HomeState(
    user: user ?? this.user,
    isLoading: isLoading ?? this.isLoading,
    failure: failure,
  );

  @override
  List<Object?> get props => [user, isLoading, failure];
}




