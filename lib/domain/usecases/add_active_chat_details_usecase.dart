import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/entities/chat_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';

class AddActiveChatDetailsUseCase implements UseCase<void, ChatEntity> {
  final FirebaseRepository firebaseRepository;

  AddActiveChatDetailsUseCase(this.firebaseRepository);

  @override
  Future<void> call(ChatEntity chatEntity) async {
    await firebaseRepository.addActiveChatDetails(chatEntity);
  }
}
