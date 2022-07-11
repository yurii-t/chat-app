import 'package:chat_app/data/datasource/firebase/firebase_remote_datasource.dart';
import 'package:chat_app/domain/entities/chat_entity.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
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

  @override
  Future<void> addActiveChatDetails(ChatEntity chatEntity) =>
      firebaseRemoteDataSource.addActiveChatDetails(chatEntity);

  @override
  Future<void> createChat(String uid, String otherUid) =>
      firebaseRemoteDataSource.createChat(uid, otherUid);

  @override
  Stream<List<ChatEntity>> getActiveChats() =>
      firebaseRemoteDataSource.getActiveChats();

  @override
  Stream<List<MessageEntity>> getMessages(String chatId) =>
      firebaseRemoteDataSource.getMessages(chatId);

  @override
  Future<void> sendMessage(MessageEntity messageEntity, String chatId) =>
      firebaseRemoteDataSource.sendMessage(messageEntity, chatId);
  @override
  Future<String> setMessageId(String chatId) =>
      firebaseRemoteDataSource.setMessageId(chatId);

  @override
  Future<String> getCurrentUserUid() =>
      firebaseRemoteDataSource.getCurrentUserUid();
  @override
  Future<bool> isSignIn() => firebaseRemoteDataSource.isSignIn();
  @override
  Future<void> signOut() => firebaseRemoteDataSource.signOut();
  @override
  Future<String> getChatId(String uid, String otherUid) =>
      firebaseRemoteDataSource.getChatId(uid, otherUid);

  @override
  Future<void> readMessages(String chatId, String sederUID) =>
      firebaseRemoteDataSource.readMessages(chatId, sederUID);

  @override
  Future<void> getNewMessages(String chatId, String recepientUid) =>
      firebaseRemoteDataSource.getNewMessages(chatId, recepientUid);

  @override
  Future<void> updateChattingWithId(String recepientUid) =>
      firebaseRemoteDataSource.updateChattingWithId(recepientUid);
}
