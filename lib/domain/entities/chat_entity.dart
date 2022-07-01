import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String chatId;
  final String senderName;
  final String senderUid;
  final String senderPhoneNumber;
  final String recepientName;
  final String recepientUid;
  final String recepientPhoneNumber;
  final String recentTextMessage;
  final bool isRead;
  final Timestamp time;

  const ChatEntity({
    required this.chatId,
    required this.senderName,
    required this.senderUid,
    required this.senderPhoneNumber,
    required this.recepientName,
    required this.recepientUid,
    required this.recepientPhoneNumber,
    required this.recentTextMessage,
    required this.isRead,
    required this.time,
  });

  @override
  List<Object?> get props => [
        senderName,
        senderUid,
        senderPhoneNumber,
        recepientName,
        recepientUid,
        recepientPhoneNumber,
        recentTextMessage,
        isRead,
        time,
      ];
}
