import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  final FirebaseRepository firebaseRepository;

  SignOutUseCase(this.firebaseRepository);

  @override
  Future<void> call(NoParams params) async {
    await firebaseRepository.signOut();
  }
}
