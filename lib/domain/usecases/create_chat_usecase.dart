import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';

class CreateChatUseCase implements UseCase<void, CreateChatParams> {
  final FirebaseRepository firebaseRepository;

  CreateChatUseCase(this.firebaseRepository);

  @override
  Future<void> call(CreateChatParams params) async {
    await firebaseRepository.createChat(params.uid, params.otherUid);
  }
}

class CreateChatParams {
  final String uid;
  final String otherUid;

  CreateChatParams({required this.uid, required this.otherUid});
}
