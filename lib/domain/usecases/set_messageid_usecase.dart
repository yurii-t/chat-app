import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';

class SetMessageIdUsecase implements UseCase<String, String> {
  final FirebaseRepository firebaseRepository;

  SetMessageIdUsecase(this.firebaseRepository);

  @override
  Future<String> call(String chatId) => firebaseRepository.setMessageId(chatId);
}
