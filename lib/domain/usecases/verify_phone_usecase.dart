import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyPhoneUseCase implements UseCase<void, verifyPhoneParams> {
  final FirebaseRepository firebaseRepository;

  VerifyPhoneUseCase(this.firebaseRepository);
  @override
  Future<void> call(verifyPhoneParams params) {
    return firebaseRepository.verifyPhone(
      phoneNumber: params.phoneNumber,
      verificationCompleted: params.verificationCompleted,
      verificationFailed: params.verificationFailed,
      codeSent: params.codeSent,
      codeAutoRetrievalTimeout: params.codeAutoRetrievalTimeout,
    );
  }
}

class verifyPhoneParams {
  final String phoneNumber;
  final Function(PhoneAuthCredential) verificationCompleted;
  final Function(FirebaseAuthException) verificationFailed;
  final Function(String, int?) codeSent;
  final Function(String) codeAutoRetrievalTimeout;

  verifyPhoneParams({
    required this.phoneNumber,
    required this.verificationCompleted,
    required this.verificationFailed,
    required this.codeSent,
    required this.codeAutoRetrievalTimeout,
  });
}
