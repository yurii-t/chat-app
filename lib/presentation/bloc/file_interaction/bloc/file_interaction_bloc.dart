import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/entities/chat_entity.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/usecases/add_active_chat_details_usecase.dart';
import 'package:chat_app/domain/usecases/download_file_usecase.dart';
import 'package:chat_app/domain/usecases/download_progress_usecase.dart';
import 'package:chat_app/domain/usecases/get_chat_id_usecase.dart';
import 'package:chat_app/domain/usecases/get_reference_usecase.dart';
import 'package:chat_app/domain/usecases/send_message_usecase.dart';
import 'package:chat_app/domain/usecases/upload_image_usecase.dart';
import 'package:chat_app/domain/usecases/upload_progress_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  FileInteractionBloc(
    this.sendMessageUseCase,
    this.activeChatDetailsUseCase,
    this.uploadImageUsecase,
    this.getChatIdUseCase,
    this.uploadProgressUsecase,
    this.getReferenceUseCase,
    this.downloadFileUseCase,
    this.downloadProgressUseCase,
  ) : super(FileInteractionInitial()) {
    on<FileInteractionUploadFile>(uploadFile);
    // on<FileInteractionUploading>(uploadingProgress);
    on<FileInteractionDownloading>(downloadFile);
  }

  Future<void> uploadFile(FileInteractionUploadFile event,
      Emitter<FileInteractionState> emit) async {
    try {
      final chatId = await getChatIdUseCase.call(
        GetChatIdParams(uid: event.senderId, otherUid: event.recipientId),
      );
      // final String imageUrl =
      //     await uploadImageUsecase.call(UploadImageParams(event.image, chatId));
      final ref = await getReferenceUseCase
          .call(GetReferenceParams(event.image, chatId));
      // final String imageUrl =
      //     await uploadImageUsecase.call(UploadImageParams(event.image, chatId));
      final task =
          await uploadImageUsecase.call(UploadImageParams(event.image, ref));

      // emit.forEach(
      //   uploadProgressUsecase.call(task),
      //   onData: (double progress) {
      //     return FileInteractionProgressUploading(progress);
      //   },
      // );

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
              messageId: '',
              time: Timestamp.now(),
              docName: event.docName,
              docSize: event.docSize,
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
            isRead: true,
            time: Timestamp.now(),
          ));
        },
      ));

      await emit.forEach(
        uploadProgressUsecase.call(task),
        onData: (double progress) {
          return FileInteractionProgressUploading(progress);
        },
      );

      // final imageUrl =
      //     await (await task.whenComplete(() => {print('link compleate')}))
      //         .ref
      //         .getDownloadURL();
      // await sendMessageUseCase.call(SendMessageParams(
      //   messageEntity: MessageEntity(
      //     senderName: event.senderName,
      //     sederUid: event.senderId,
      //     recipientName: event.recipientName,
      //     recipientUid: event.recipientId,
      //     messageType: event.messageType,
      //     message: imageUrl,
      //     messageId: '',
      //     time: Timestamp.now(),
      //     docName: event.docName,
      //     docSize: event.docSize,
      //   ),
      //   chatId: chatId,
      // ));
      // await activeChatDetailsUseCase.call(ChatEntity(
      //   chatId: chatId,
      //   senderName: event.senderName,
      //   senderUid: event.senderId,
      //   senderPhoneNumber: event.senderPhoneNumber,
      //   recepientName: event.recipientName,
      //   recepientUid: event.recipientId,
      //   recepientPhoneNumber: event.recipientPhoneNumber,
      //   recentTextMessage: imageUrl,
      //   isRead: true,
      //   time: Timestamp.now(),
      // ));
    } on SocketException catch (e) {
      emit(FileInteractinonError(e.toString()));
    }
  }

  Future<void> downloadFile(FileInteractionDownloading event,
      Emitter<FileInteractionState> emit) async {
    try {
      // final testurl =
      //     'gs://chat-app-d43b4.appspot.com/chats/tqyPM6a0UXJHoZiq1xII/16566755005026049008.pdf';
      // final testurl =
      //     'gs://chat-app-d43b4.appspot.com/chats/tqyPM6a0UXJHoZiq1xII/16566737392836129472.pdf';
      // final tempDir = await getTemporaryDirectory();
      final tempDir = await getApplicationDocumentsDirectory();
      final path = '${tempDir.path}/${event.url}';
      final file = File(path);
      if (file.existsSync()) {
        await OpenFile.open(path);
      } else {
        final downloadProgress =
            await downloadFileUseCase.call(DownloadFileParams(
          // testurl,
          event.url,
          file,
        ));

        await emit.forEach(
          downloadProgressUseCase.call(downloadProgress),
          onData: (double dowProgress) {
            return FileInteractionProgressDownloading(dowProgress);
          },
        );
      }
    } on SocketException catch (e) {
      emit(FileInteractinonError(e.toString()));
    }
  }

  // void uploadingProgress(FileInteractionUploading event,
  //     Emitter<FileInteractionState> emit) async {
  //   final chatId = await getChatIdUseCase.call(
  //     GetChatIdParams(uid: event.senderId, otherUid: event.recipientId),
  //   );
  //   final ref =
  //       await getReferenceUseCase.call(GetReferenceParams(event.image, chatId));
  //   // final String imageUrl =
  //   //     await uploadImageUsecase.call(UploadImageParams(event.image, chatId));
  //   final task =
  //       await uploadImageUsecase.call(UploadImageParams(event.image, ref));
  //   var tmp = 0.0;

  //   await emit.forEach(
  //     uploadProgressUsecase.call(task),
  //     onData: (double progress) {
  //       return FileInteractionProgressUploading(progress);
  //     },
  //   );
  // }
}
