import 'package:bloc/bloc.dart';
import 'package:chat_app/core/usecases/use_case_stream.dart';
import 'package:chat_app/domain/entities/chat_entity.dart';
import 'package:chat_app/domain/usecases/get_active_chats_usecase.dart';
import 'package:equatable/equatable.dart';

part 'active_chats_event.dart';
part 'active_chats_state.dart';

class ActiveChatsBloc extends Bloc<ActiveChatsEvent, ActiveChatsState> {
  final GetActiveChatsUseCase getActiveChatsUseCase;
  ActiveChatsBloc({required this.getActiveChatsUseCase})
      : super(ActiveChatsInitial()) {
    on<LoadActiveChats>(getUserActiveChats);
  }

  void getUserActiveChats(
      LoadActiveChats event, Emitter<ActiveChatsState> emit) async {
    await emit.forEach(
      getActiveChatsUseCase.call(NoParamsStream()),
      onData: (List<ChatEntity> chats) => ActiveChatsLoaded(chats: chats),
    );
  }
}
