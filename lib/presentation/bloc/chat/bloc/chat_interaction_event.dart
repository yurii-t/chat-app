part of 'chat_interaction_bloc.dart';

abstract class ChatInteractionEvent extends Equatable {
  const ChatInteractionEvent();

  @override
  List<Object> get props => [];
}

class ChatInteractionsSendMessage extends ChatInteractionEvent {
  final String senderId;
  final String senderName;
  final String senderPhoneNumber;
  final String recipientId;
  final String recipientName;
  final String recipientPhoneNumber;
  final String message;
  final String messageType;

  const ChatInteractionsSendMessage({
    required this.senderId,
    required this.senderName,
    required this.senderPhoneNumber,
    required this.recipientId,
    required this.recipientName,
    required this.recipientPhoneNumber,
    required this.message,
    required this.messageType,
  });

  @override
  List<Object> get props => [
        senderId,
        senderName,
        senderPhoneNumber,
        recipientId,
        recipientName,
        recipientPhoneNumber,
        message,
        messageType,
      ];
}

class ChatInteractionsLoad extends ChatInteractionEvent {
  final String uid;
  final String otherUid;

  const ChatInteractionsLoad(this.uid, this.otherUid);

  @override
  List<Object> get props => [uid, otherUid];
}

class ChatInteractionsCreateChat extends ChatInteractionEvent {
  final String uid;
  final String otherUid;

  const ChatInteractionsCreateChat(this.uid, this.otherUid);

  @override
  List<Object> get props => [uid, otherUid];
}

class ChatInteractionsUploadImage extends ChatInteractionEvent {
  final String senderId;
  final String senderName;
  final String senderPhoneNumber;
  final String recipientId;
  final String recipientName;
  final String recipientPhoneNumber;
  final String message;
  final String messageType;
  final File image;
  final String docSize;
  final String docName;

  const ChatInteractionsUploadImage(
    this.image,
    this.senderId,
    this.senderName,
    this.senderPhoneNumber,
    this.recipientId,
    this.recipientName,
    this.recipientPhoneNumber,
    this.message,
    this.messageType,
    this.docSize,
    this.docName,
  );

  @override
  List<Object> get props => [
        image,
        senderId,
        senderName,
        senderPhoneNumber,
        recipientId,
        recipientName,
        recipientPhoneNumber,
        message,
        messageType,
        docSize,
        docName,
      ];
}

class ChatInteractionsSeenMessages extends ChatInteractionEvent {
  final String senderId;
  final String recipientId;

  const ChatInteractionsSeenMessages(this.senderId, this.recipientId);
  @override
  List<Object> get props => [senderId, recipientId];
}

class ChatInteractionsupdateChattingWithId extends ChatInteractionEvent {
  final String recipientId;

  const ChatInteractionsupdateChattingWithId(this.recipientId);
  @override
  List<Object> get props => [recipientId];
}
