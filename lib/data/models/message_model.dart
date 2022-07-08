import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.senderName,
    required super.sederUid,
    required super.recipientName,
    required super.recipientUid,
    required super.messageType,
    required super.message,
    required super.messageId,
    required super.time,
    required super.docSize,
    required super.docName,
    required super.isRead,
    required super.docId,
  });

  factory MessageModel.fromSnapShot(DocumentSnapshot snap) {
    return MessageModel(
      senderName: snap['senderName'] as String,
      sederUid: snap['sederUID'] as String,
      recipientName: snap['recipientName'] as String,
      recipientUid: snap['recipientUID'] as String,
      messageType: snap['messageType'] as String,
      message: snap['message'] as String,
      messageId: snap['messageId'] as String,
      time: snap['time'] as Timestamp,
      docSize: snap['docSize'] as String,
      docName: snap['docName'] as String,
      isRead: snap['isRead'] as bool,
      docId: snap['docId'] as String,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'senderName': senderName,
      'sederUID': sederUid,
      'recipientName': recipientName,
      'recipientUID': recipientUid,
      'messageType': messageType,
      'message': message,
      'messageId': messageId,
      'time': time,
      'docSize': docSize,
      'docName': docName,
      'isRead': isRead,
      'docId': docId,
    };
  }
}
