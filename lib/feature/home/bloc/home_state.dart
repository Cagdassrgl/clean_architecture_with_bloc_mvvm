part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<Todos> todos;

  const HomeSuccess(this.todos);

  @override
  List<Object> get props => [todos];
}

final class HomeFailure extends HomeState {
  final String error;

  const HomeFailure(this.error);

  @override
  List<Object> get props => [error];
}
