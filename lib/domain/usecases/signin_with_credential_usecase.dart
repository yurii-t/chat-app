import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninWithCredentialUseCase
    implements UseCase<UserCredential, AuthCredential> {
  final FirebaseRepository firebaseRepository;

  SigninWithCredentialUseCase(this.firebaseRepository);

  @override
  Future<UserCredential> call(AuthCredential credential) async {
    return firebaseRepository.signInWithCredential(credential);
  }
}
