part of 'current_user_bloc.dart';

abstract class CurrentUserState extends Equatable {
  const CurrentUserState();

  @override
  List<Object> get props => [];
}

class CurrentUserInitial extends CurrentUserState {}

class CurrentUserLoading extends CurrentUserState {}

class CurrentUserError extends CurrentUserState {
  final String error;

  const CurrentUserError(this.error);

  @override
  List<Object> get props => [error];
}

class CurrentUserLoaded extends CurrentUserState {
  final UserEntity usersInfo;

  const CurrentUserLoaded(this.usersInfo);

  @override
  List<Object> get props => [usersInfo];
}
