import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';

class GetCurrentUserUidUseCase implements UseCase<String, NoParams> {
  final FirebaseRepository firebaseRepository;

  GetCurrentUserUidUseCase(this.firebaseRepository);

  @override
  Future<String> call(NoParams params) async {
    return firebaseRepository.getCurrentUserUid();
  }
}
