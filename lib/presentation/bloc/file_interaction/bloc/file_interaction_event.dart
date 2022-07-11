part of 'file_interaction_bloc.dart';

abstract class FileInteractionEvent extends Equatable {
  const FileInteractionEvent();

  @override
  List<Object> get props => [];
}

class FileInteractionUploadFile extends FileInteractionEvent {
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
  final String docId;

  const FileInteractionUploadFile(
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
    this.docId,
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
        docId,
      ];
}

class FileInteractionDownloading extends FileInteractionEvent {
  final String url;
  final String messageId;

  const FileInteractionDownloading(
    this.messageId,
    this.url,
  );
  @override
  List<Object> get props => [
        url,
        messageId,
      ];
}
