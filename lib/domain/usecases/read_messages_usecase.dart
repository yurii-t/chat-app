import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';

class ReadMesagesUseCase implements UseCase<void, ReadMesagesParams> {
  final FirebaseRepository firebaseRepository;

  ReadMesagesUseCase(this.firebaseRepository);

  @override
  Future<void> call(ReadMesagesParams params) async {
    await firebaseRepository.readMessages(params.chatId, params.senderUid);
  }
}

class ReadMesagesParams {
  final String chatId;
  final String senderUid;

  ReadMesagesParams(this.chatId, this.senderUid);
}
