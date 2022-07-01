part of 'active_chats_bloc.dart';

abstract class ActiveChatsState extends Equatable {
  const ActiveChatsState();

  @override
  List<Object> get props => [];
}

class ActiveChatsInitial extends ActiveChatsState {}

class ActiveChatsLoading extends ActiveChatsState {}

class ActiveChatsLoaded extends ActiveChatsState {
  final List<ChatEntity> chats;

  const ActiveChatsLoaded({this.chats = const <ChatEntity>[]});

  @override
  List<Object> get props => [chats];
}

class ActiveChatsError extends ActiveChatsState {
  final String error;

  const ActiveChatsError(this.error);

  @override
  List<Object> get props => [error];
}
