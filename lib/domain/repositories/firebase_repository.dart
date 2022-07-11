import 'package:chat_app/domain/entities/chat_entity.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
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

  Future<void> createChat(String uid, String otherUid);
  Future<void> sendMessage(MessageEntity messageEntity, String chatId);

  Future<String> setMessageId(String chatId);

  Future<void> addActiveChatDetails(ChatEntity chatEntity);
  Stream<List<MessageEntity>> getMessages(String chatId);
  Stream<List<ChatEntity>> getActiveChats();
  Future<String> getCurrentUserUid();
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<String> getChatId(String uid, String otherUid);
  Future<void> readMessages(String chatId, String sederUID);
  Future<void> getNewMessages(String chatId, String recepientUid);
  Future<void> updateChattingWithId(String recepientUid);
}
