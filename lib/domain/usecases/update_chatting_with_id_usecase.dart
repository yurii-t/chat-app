import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';

class UpdateChattingWithIdUseCase implements UseCase<void, String> {
  final FirebaseRepository firebaseRepository;

  UpdateChattingWithIdUseCase(this.firebaseRepository);

  @override
  Future<void> call(String recepientUid) =>
      firebaseRepository.updateChattingWithId(recepientUid);
}
