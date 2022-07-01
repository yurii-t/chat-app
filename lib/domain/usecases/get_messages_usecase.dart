import 'package:chat_app/core/usecases/use_case_stream.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';

class GetMessagesUseCase implements UseCaseStream<List<MessageEntity>, String> {
  final FirebaseRepository firebaseRepository;

  GetMessagesUseCase(this.firebaseRepository);

  @override
  Stream<List<MessageEntity>> call(String chatId) {
    return firebaseRepository.getMessages(chatId);
  }
}
