import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';

class GetChatIdUseCase implements UseCase<String, GetChatIdParams> {
  final FirebaseRepository firebaseRepository;

  GetChatIdUseCase(this.firebaseRepository);

  @override
  Future<String> call(GetChatIdParams params) async {
    return firebaseRepository.getChatId(params.uid, params.otherUid);
  }
}

class GetChatIdParams {
  final String uid;
  final String otherUid;

  GetChatIdParams({required this.uid, required this.otherUid});
}
