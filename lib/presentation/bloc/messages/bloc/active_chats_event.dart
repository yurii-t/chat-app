part of 'active_chats_bloc.dart';

abstract class ActiveChatsEvent extends Equatable {
  const ActiveChatsEvent();

  @override
  List<Object> get props => [];
}

class LoadActiveChats extends ActiveChatsEvent {}
