// ignore_for_file: avoid-unused-parameters
import 'package:bloc/bloc.dart';
import 'package:chat_app/core/usecases/use_case_stream.dart';
import 'package:chat_app/domain/entities/chat_entity.dart';
import 'package:chat_app/domain/usecases/get_active_chats_usecase.dart';
import 'package:chat_app/domain/usecases/get_chat_id_usecase.dart';
import 'package:chat_app/domain/usecases/get_new_messages_usecase.dart';
import 'package:equatable/equatable.dart';

part 'active_chats_event.dart';
part 'active_chats_state.dart';

class ActiveChatsBloc extends Bloc<ActiveChatsEvent, ActiveChatsState> {
  final GetActiveChatsUseCase getActiveChatsUseCase;
  final GetNewMessagesUseCase getNewMessagesUseCase;
  final GetChatIdUseCase getChatIdUseCase;
  ActiveChatsBloc({
    required this.getActiveChatsUseCase,
    required this.getNewMessagesUseCase,
    required this.getChatIdUseCase,
  }) : super(ActiveChatsInitial()) {
    on<LoadActiveChats>(getUserActiveChats);
    on<ActiveChatsNewMessagesCount>(getNewMeesagesCount);
  }

  Future<void> getUserActiveChats(
    LoadActiveChats event,
    Emitter<ActiveChatsState> emit,
  ) async {
    await emit.forEach(
      getActiveChatsUseCase.call(NoParamsStream()),
      onData: (chats) => ActiveChatsLoaded(chats: chats as List<ChatEntity>),
    );
  }

  Future<void> getNewMeesagesCount(
    ActiveChatsNewMessagesCount event,
    Emitter<ActiveChatsState> emit,
  ) async {
    await getNewMessagesUseCase
        .call(GetNewMessagesParams(event.chatId, event.recipientId));
  }
}
