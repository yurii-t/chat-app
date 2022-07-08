import 'package:chat_app/core/usecases/use_case.dart';

import 'package:chat_app/domain/repositories/firebase_repository.dart';

class GetNewMessagesUseCase implements UseCase<void, GetNewMessagesParams> {
  final FirebaseRepository firebaseRepository;

  GetNewMessagesUseCase(this.firebaseRepository);

  @override
  Future<void> call(GetNewMessagesParams params) async {
    await firebaseRepository.getNewMessages(params.chatId, params.recepientUid);
  }
}

class GetNewMessagesParams {
  final String chatId;
  final String recepientUid;

  GetNewMessagesParams(this.chatId, this.recepientUid);
}
