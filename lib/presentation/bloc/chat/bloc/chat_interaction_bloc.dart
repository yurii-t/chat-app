import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/entities/chat_entity.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/usecases/add_active_chat_details_usecase.dart';
import 'package:chat_app/domain/usecases/create_chat_usecase.dart';
import 'package:chat_app/domain/usecases/get_chat_id_usecase.dart';
import 'package:chat_app/domain/usecases/get_messages_usecase.dart';
import 'package:chat_app/domain/usecases/get_reference_usecase.dart';
import 'package:chat_app/domain/usecases/send_message_usecase.dart';
import 'package:chat_app/domain/usecases/upload_image_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'chat_interaction_event.dart';
part 'chat_interaction_state.dart';

class ChatInteractionBloc
    extends Bloc<ChatInteractionEvent, ChatInteractionState> {
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final AddActiveChatDetailsUseCase activeChatDetailsUseCase;
  final GetChatIdUseCase getChatIdUseCase;
  final CreateChatUseCase createChatUseCase;
  final UploadImageUsecase uploadImageUsecase;
  final GetReferenceUseCase getReferenceUseCase;
  ChatInteractionBloc(
    this.getMessagesUseCase,
    this.sendMessageUseCase,
    this.activeChatDetailsUseCase,
    this.getChatIdUseCase,
    this.createChatUseCase,
    this.uploadImageUsecase,
    this.getReferenceUseCase,
  ) : super(ChatInteractionInitial()) {
    on<ChatInteractionsCreateChat>(onCreateChat);
    on<ChatInteractionsLoad>(getAllMessages);
    on<ChatInteractionsSendMessage>(sendMessage);
    on<ChatInteractionsUploadImage>(uploadImage);
  }

  Future<void> onCreateChat(
    ChatInteractionsCreateChat event,
    Emitter<ChatInteractionState> emit,
  ) async {
    try {
      await createChatUseCase
          .call(CreateChatParams(uid: event.uid, otherUid: event.otherUid));
    } on SocketException catch (e) {
      emit(ChatInteractionError(e.toString()));
    }
  }

  void getAllMessages(
      ChatInteractionsLoad event, Emitter<ChatInteractionState> emit) async {
    final chatId = await getChatIdUseCase
        .call(GetChatIdParams(uid: event.uid, otherUid: event.otherUid));

    await emit.forEach(
      getMessagesUseCase.call(chatId),
      onData: (List<MessageEntity> messages) =>
          ChatInteractionLoaded(messages: messages),
    );
  }

  Future<void> sendMessage(
    ChatInteractionsSendMessage event,
    Emitter<ChatInteractionState> emit,
  ) async {
    try {
      final chatId = await getChatIdUseCase.call(
        GetChatIdParams(uid: event.senderId, otherUid: event.recipientId),
      );

      await sendMessageUseCase.call(SendMessageParams(
        messageEntity: MessageEntity(
          senderName: event.senderName,
          sederUid: event.senderId,
          recipientName: event.recipientName,
          recipientUid: event.recipientId,
          messageType: event.messageType,
          message: event.message,
          messageId: '',
          time: Timestamp.now(),
          docName: '',
          docSize: '',
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
        recentTextMessage: event.message,
        isRead: true,
        time: Timestamp.now(),
      ));
    } on SocketException catch (e) {
      emit(ChatInteractionError(e.toString()));
    }
  }

  Future<void> uploadImage(ChatInteractionsUploadImage event,
      Emitter<ChatInteractionState> emit) async {
    try {
      final chatId = await getChatIdUseCase.call(
        GetChatIdParams(uid: event.senderId, otherUid: event.recipientId),
      );
      final ref = await getReferenceUseCase
          .call(GetReferenceParams(event.image, chatId));
      // final String imageUrl =
      //     await uploadImageUsecase.call(UploadImageParams(event.image, chatId));
      final task =
          await uploadImageUsecase.call(UploadImageParams(event.image, ref));
      final imageUrl =
          await (await task.whenComplete(() => {print('link compleate')}))
              .ref
              .getDownloadURL();

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
    } on SocketException catch (e) {
      emit(ChatInteractionError(e.toString()));
    }
  }
}
