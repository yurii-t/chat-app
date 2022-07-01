import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String senderName;
  final String sederUid;
  final String recipientName;
  final String recipientUid;
  final String messageType;
  final String message;
  final String messageId;
  final Timestamp time;
  final String docSize;
  final String docName;

  const MessageEntity({
    required this.senderName,
    required this.sederUid,
    required this.recipientName,
    required this.recipientUid,
    required this.messageType,
    required this.message,
    required this.messageId,
    required this.time,
    required this.docSize,
    required this.docName,
  });

  @override
  List<Object?> get props => [
        this.senderName,
        sederUid,
        recipientName,
        recipientUid,
        messageType,
        message,
        messageId,
        time,
        docSize,
        docName,
      ];
}
