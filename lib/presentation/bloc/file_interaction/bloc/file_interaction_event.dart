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

class FileInteractionUploading extends FileInteractionEvent {
  final String senderId;

  final String recipientId;

  final File image;

  FileInteractionUploading(this.senderId, this.recipientId, this.image);
  @override
  List<Object> get props => [senderId, recipientId, image];
}

class FileInteractionDownloading extends FileInteractionEvent {
  // final String senderId;

  // final String recipientId;
  final String url;

  const FileInteractionDownloading(
      // this.senderId,this.recipientId,
      this.url);
  @override
  List<Object> get props => [
        // senderId,recipientId,
        url
      ];
}
