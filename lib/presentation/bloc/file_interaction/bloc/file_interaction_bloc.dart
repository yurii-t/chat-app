import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/domain/entities/chat_entity.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/usecases/add_active_chat_details_usecase.dart';
import 'package:chat_app/domain/usecases/download_file_usecase.dart';
import 'package:chat_app/domain/usecases/download_progress_usecase.dart';
import 'package:chat_app/domain/usecases/get_chat_id_usecase.dart';
import 'package:chat_app/domain/usecases/get_reference_usecase.dart';
import 'package:chat_app/domain/usecases/send_message_usecase.dart';
import 'package:chat_app/domain/usecases/set_messageid_usecase.dart';
import 'package:chat_app/domain/usecases/upload_image_usecase.dart';
import 'package:chat_app/domain/usecases/upload_progress_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

part 'file_interaction_event.dart';
part 'file_interaction_state.dart';

class FileInteractionBloc
    extends Bloc<FileInteractionEvent, FileInteractionState> {
  final SendMessageUseCase sendMessageUseCase;
  final AddActiveChatDetailsUseCase activeChatDetailsUseCase;
  final UploadImageUsecase uploadImageUsecase;
  final GetChatIdUseCase getChatIdUseCase;
  final UploadProgressUsecase uploadProgressUsecase;
  final GetReferenceUseCase getReferenceUseCase;
  final DownloadFileUseCase downloadFileUseCase;
  final DownloadProgressUseCase downloadProgressUseCase;
  final SetMessageIdUsecase setMessageIdUsecase;
  FileInteractionBloc(
    this.sendMessageUseCase,
    this.activeChatDetailsUseCase,
    this.uploadImageUsecase,
    this.getChatIdUseCase,
    this.uploadProgressUsecase,
    this.getReferenceUseCase,
    this.downloadFileUseCase,
    this.downloadProgressUseCase,
    this.setMessageIdUsecase,
  ) : super(FileInteractionInitial()) {
    on<FileInteractionUploadFile>(uploadFile);

    on<FileInteractionDownloading>(downloadFile);
  }

  // ignore: long-method
  Future<void> uploadFile(
    FileInteractionUploadFile event,
    Emitter<FileInteractionState> emit,
  ) async {
    try {
      final chatId = await getChatIdUseCase.call(
        GetChatIdParams(uid: event.senderId, otherUid: event.recipientId),
      );

      final ref = await getReferenceUseCase
          .call(GetReferenceParams(event.image, chatId, 'chats'));

      final task =
          await uploadImageUsecase.call(UploadImageParams(event.image, ref));

      final messageId = await setMessageIdUsecase.call(chatId);
      await sendMessageUseCase.call(SendMessageParams(
        messageEntity: MessageEntity(
          senderName: event.senderName,
          sederUid: event.senderId,
          recipientName: event.recipientName,
          recipientUid: event.recipientId,
          messageType: event.messageType,
          message: '',
          messageId: messageId,
          time: Timestamp.now(),
          docName: event.docName,
          docSize: event.docSize,
          isRead: false,
          docId: event.docId,
        ),
        chatId: chatId,
      ));

      unawaited(task.then(
        (taskSnapshot) async {
          final imageUrl = await taskSnapshot.ref.getDownloadURL();
          await sendMessageUseCase.call(SendMessageParams(
            messageEntity: MessageEntity(
              senderName: event.senderName,
              sederUid: event.senderId,
              recipientName: event.recipientName,
              recipientUid: event.recipientId,
              messageType: event.messageType,
              message: imageUrl,
              messageId: messageId,
              time: Timestamp.now(),
              docName: event.docName,
              docSize: event.docSize,
              isRead: false,
              docId: event.docId,
            ),
            chatId: chatId,
          ));
          await activeChatDetailsUseCase.call(ChatEntity(
            chatId: chatId,
            senderName: event.senderName,
            senderUid: event.senderId,
            senderPhoneNumber: event.senderPhoneNumber,
            recepientName: event.recipientName,
            recepientUid: event.recipientId,
            recepientPhoneNumber: event.recipientPhoneNumber,
            recentTextMessage: imageUrl,
            isRead: false,
            time: Timestamp.now(),
            newMessages: 0,
          ));
        },
      ));

      await emit.forEach(
        uploadProgressUsecase.call(task),
        onData: (progress) {
          final state = this.state;

          final uploadProgressList = state is FileInteractionProgressUploading
              ? List<UploadingProgress>.from(state.uploadProgressList)
              : <UploadingProgress>[];

          final uploadProgressIndex = uploadProgressList.indexWhere(
            (uploadProgress) => uploadProgress.docId == event.docId,
          );

          if (uploadProgressIndex == -1) {
            uploadProgressList.add(UploadingProgress(
              event.docId,
              progress as double,
            ));
          } else {
            uploadProgressList[uploadProgressIndex] = UploadingProgress(
              event.docId,
              progress as double,
            );
          }

          return FileInteractionProgressUploading(uploadProgressList);
        },
      );
    } on FirebaseException catch (_) {
      final state = this.state;

      final errorList = state is FileInteractinonError
          ? List<MessageModel>.from(state.errorList)
          : <MessageModel>[];

      final errorIndex = errorList.indexWhere(
        (error) => error.docId == event.docId,
      );

      final filepath = event.image.path;
      if (errorIndex == -1) {
        errorList.add(MessageModel(
          senderName: event.senderName,
          sederUid: event.senderId,
          recipientName: event.recipientName,
          recipientUid: event.recipientId,
          messageType: event.messageType,
          message: filepath,
          messageId: 'error',
          time: Timestamp.now(),
          docName: event.docName,
          docSize: event.docSize,
          isRead: false,
          docId: event.docId,
        ));
      } else {
        errorList[errorIndex] = MessageModel(
          senderName: event.senderName,
          sederUid: event.senderId,
          recipientName: event.recipientName,
          recipientUid: event.recipientId,
          messageType: event.messageType,
          message: filepath,
          messageId: 'error',
          time: Timestamp.now(),
          docName: event.docName,
          docSize: event.docSize,
          isRead: false,
          docId: event.docId,
        );
      }

      emit(FileInteractinonError(errorList));
    }
  }

  // ignore: long-method
  Future<void> downloadFile(
    FileInteractionDownloading event,
    Emitter<FileInteractionState> emit,
  ) async {
    try {
      final tempDir = await getApplicationDocumentsDirectory();
      final path = '${tempDir.path}/${event.url}';
      final file = File(path);
      if (file.existsSync()) {
        await OpenFile.open(path);
      } else {
        final downloadProgress =
            await downloadFileUseCase.call(DownloadFileParams(
          event.url,
          file,
        ));

        await emit.forEach(
          downloadProgressUseCase.call(downloadProgress),
          onData: (dowProgress) {
            final state = this.state;

            final progressList = state is FileInteractionProgressDownloading
                ? List<DownloadingProgress>.from(state.progressList)
                : <DownloadingProgress>[];

            final progressIndex = progressList.indexWhere(
              (downloadProgress) => downloadProgress.id == event.messageId,
            );
            if (progressIndex == -1) {
              progressList.add(DownloadingProgress(
                event.messageId,
                dowProgress as double,
              ));
            } else {
              progressList[progressIndex] = DownloadingProgress(
                event.messageId,
                dowProgress as double,
              );
            }

            return FileInteractionProgressDownloading(progressList);
          },
        );
      }
    } on SocketException catch (e) {
      print(e);
    }
  }
}
