import 'package:chat_app/data/datasource/firebase/firebase_remote_datasource.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource firebaseRemoteDataSource;

  FirebaseRepositoryImpl({required this.firebaseRemoteDataSource});

  @override
  Future<void> createCurrentUser(UserEntity user) async {
    await firebaseRemoteDataSource.createCurrentUser(user);
  }

  @override
  Future<UserCredential> signInWithCredential(AuthCredential credential) async {
    return firebaseRemoteDataSource.signInWithCredential(credential);
  }

  // @override
  // Future<void> verifyPhone({
  //   required String phoneNumber,
  //   required Function(PhoneAuthCredential p1) verificationCompleted,
  //   required Function(FirebaseAuthException p1) verificationFailed,
  //   required Function(String p1, int? p2) codeSent,
  //   required Function(String p1) codeAutoRetrievalTimeout,
  // }) async {
  //   await firebaseRemoteDataSource.verifyPhone(
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: verificationCompleted,
  //     verificationFailed: verificationFailed,
  //     codeSent: codeSent,
  //     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  //   );
  // }
  @override
  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await firebaseRemoteDataSource.verifyPhone(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  Stream<List<UserEntity>> getAllUsers() =>
      firebaseRemoteDataSource.getAllUsers();

  @override
  Future<UserEntity> getCurrentUserInfo() =>
      firebaseRemoteDataSource.getCurrentUserInfo();
}
