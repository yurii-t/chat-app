import 'package:chat_app/core/usecases/use_case_stream.dart';
import 'package:chat_app/domain/entities/chat_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';

class GetActiveChatsUseCase
    implements UseCaseStream<List<ChatEntity>, NoParamsStream> {
  final FirebaseRepository firebaseRepository;

  GetActiveChatsUseCase(this.firebaseRepository);

  @override
  Stream<List<ChatEntity>> call(NoParamsStream paramsStream) {
    return firebaseRepository.getActiveChats();
  }
}
