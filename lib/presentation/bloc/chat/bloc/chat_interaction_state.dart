part of 'chat_interaction_bloc.dart';

abstract class ChatInteractionState extends Equatable {
  const ChatInteractionState();

  @override
  List<Object> get props => [];
}

class ChatInteractionInitial extends ChatInteractionState {}

class ChatInteractionLoading extends ChatInteractionState {}

class ChatInteractionLoaded extends ChatInteractionState {
  final List<MessageEntity> messages;

  const ChatInteractionLoaded({this.messages = const <MessageEntity>[]});

  @override
  List<Object> get props => [messages];
}

class ChatInteractionError extends ChatInteractionState {
  final String error;

  const ChatInteractionError(this.error);

  @override
  List<Object> get props => [error];
}
