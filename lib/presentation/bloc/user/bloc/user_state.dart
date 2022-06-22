part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserEntity> allUsers;

  const UserLoaded({this.allUsers = const <UserEntity>[]});

  @override
  List<Object> get props => [allUsers];
}

class UserError extends UserState {
  final String error;

  const UserError(this.error);

  @override
  List<Object> get props => [error];
}
