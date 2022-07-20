part of 'active_chats_bloc.dart';

abstract class ActiveChatsEvent extends Equatable {
  const ActiveChatsEvent();

  @override
  List<Object> get props => [];
}

class LoadActiveChats extends ActiveChatsEvent {}

class ActiveChatsNewMessagesCount extends ActiveChatsEvent {
  final String chatId;

  final String recipientId;

  const ActiveChatsNewMessagesCount(
    this.chatId,
    this.recipientId,
  );
  @override
  List<Object> get props => [
        chatId,
        recipientId,
      ];
}
