import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseRepository {
  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  });

  Future<UserCredential> signInWithCredential(AuthCredential credential);

  Future<void> createCurrentUser(UserEntity user);
  Stream<List<UserEntity>> getAllUsers();
  Future<UserEntity> getCurrentUserInfo();
}
