import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';

class IsSignInUseCase implements UseCase<bool, NoParams> {
  final FirebaseRepository firebaseRepository;

  IsSignInUseCase(this.firebaseRepository);

  @override
  Future<bool> call(NoParams params) async {
    return firebaseRepository.isSignIn();
  }
}
