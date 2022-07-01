import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';

class SendMessageUseCase implements UseCase<void, SendMessageParams> {
  final FirebaseRepository firebaseRepository;

  SendMessageUseCase(this.firebaseRepository);

  @override
  Future<void> call(SendMessageParams params) async {
    await firebaseRepository.sendMessage(params.messageEntity, params.chatId);
  }
}

class SendMessageParams {
  final MessageEntity messageEntity;
  final String chatId;

  SendMessageParams({required this.messageEntity, required this.chatId});
}
