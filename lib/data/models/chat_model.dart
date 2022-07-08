import 'package:chat_app/domain/entities/chat_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    required super.chatId,
    required super.senderName,
    required super.senderUid,
    required super.senderPhoneNumber,
    required super.recepientName,
    required super.recepientUid,
    required super.recepientPhoneNumber,
    required super.recentTextMessage,
    required super.isRead,
    required super.time,
    required super.newMessages,
  });

  factory ChatModel.fromSnapShot(DocumentSnapshot snap) {
    return ChatModel(
      chatId: snap['chatid'] as String,
      senderName: snap['senderName'] as String,
      senderUid: snap['senderUid'] as String,
      senderPhoneNumber: snap['senderPhoneNumber'] as String,
      recepientName: snap['recepientName'] as String,
      recepientUid: snap['recepientUid'] as String,
      recepientPhoneNumber: snap['recepientPhoneNumber'] as String,
      recentTextMessage: snap['recentTextMessage'] as String,
      isRead: snap['isRead'] as bool,
      time: snap['time'] as Timestamp,
      newMessages: snap['newMessages'] as int,
    );
  }
  Map<String, Object> toDocument() {
    return {
      'chatid': chatId,
      'senderName': senderName,
      'senderUid': senderUid,
      'senderPhoneNumber': senderPhoneNumber,
      'recepientName': recepientName,
      'recepientUid': recepientUid,
      'recepientPhoneNumber': recepientPhoneNumber,
      'recentTextMessage': recentTextMessage,
      'isRead': isRead,
      'time': time,
      'newMessages': newMessages,
    };
  }
}
