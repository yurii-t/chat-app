import 'dart:async';

import 'package:chat_app/data/datasource/firebase/firebase_remote_datasource.dart';
import 'package:chat_app/data/models/chat_model.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/entities/chat_entity.dart';

import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<String> getCurrentUserUid() async => await auth.currentUser?.uid ?? '';
  @override
  Future<bool> isSignIn() async => await auth.currentUser?.uid != null;
  @override
  Future<void> signOut() async => auth.signOut();
  @override
  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  Future<UserCredential> signInWithCredential(AuthCredential credential) async {
    return auth.signInWithCredential(credential);
  }

  @override
  Future<void> createCurrentUser(UserEntity user) async {
    final userCollection = _firebaseFirestore.collection('users');
    final String? uid = await auth.currentUser?.uid;
    final String? phoneNumber = await auth.currentUser?.phoneNumber;

    await userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        userId: uid ?? '',
        userPhone: phoneNumber ?? '',
        userName: user.userName,
        userImage: user.userImage,
        userAddress: user.userAddress,
        userGender: user.userGender,
        userMartialStatus: user.userMartialStatus,
        userPreferLanguage: user.userPreferLanguage,
        pushToken: user.pushToken,
      ).toDocument();
      if (!userDoc.exists) {
        //create new user
        userCollection.doc(uid).set(newUser);
      } else {
        //update user doc
        userCollection.doc(uid).update(newUser);
      }
    });
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    return _firebaseFirestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map(UserModel.fromSnapShot).toList();
    });
  }

  @override
  Future<UserEntity> getCurrentUserInfo() async {
    final userCollection = _firebaseFirestore.collection('users');
    final String? uid = await auth.currentUser?.uid;

    return userCollection.doc(uid).get().then(UserModel.fromSnapShot);
  }

  @override
  Future<void> createChat(String uid, String otherUid) async {
    final userCollectionRef = _firebaseFirestore.collection('users');
    final chatCollectionRef = _firebaseFirestore.collection('chats');

    await userCollectionRef
        .doc(uid)
        .collection('activeChats')
        .doc(otherUid)
        .get()
        .then((chatDoc) {
      if (chatDoc.exists) {
        return;
      }
      final String _chatId = chatCollectionRef.doc().id;
      final Map<String, Object> _chatIdMap = {'chatId': _chatId};
      chatCollectionRef.doc(_chatId).set(_chatIdMap);

      userCollectionRef
          .doc(uid)
          .collection('activeChats')
          .doc(otherUid)
          .set(_chatIdMap);

      userCollectionRef
          .doc(otherUid)
          .collection('activeChats')
          .doc(uid)
          .set(_chatIdMap);

      return;
    });
  }

  @override
  Future<void> sendMessage(MessageEntity messageEntity, String chatId) async {
    final messageCollectionRef = _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .collection('messages');

    await messageCollectionRef
        .doc(messageEntity.messageId)
        .get()
        .then((messgeDoc) {
      final newMessage = MessageModel(
        senderName: messageEntity.senderName,
        sederUid: messageEntity.sederUid,
        recipientName: messageEntity.recipientName,
        recipientUid: messageEntity.recipientUid,
        messageType: messageEntity.messageType,
        message: messageEntity.message,
        messageId: messageEntity.messageId,
        time: messageEntity.time,
        docSize: messageEntity.docSize,
        docName: messageEntity.docName,
        isRead: messageEntity.isRead,
        docId: messageEntity.docId,
      ).toDocument();
      if (!messgeDoc.exists) {
        messageCollectionRef.doc(messageEntity.messageId).set(newMessage);
      } else {
        messageCollectionRef.doc(messageEntity.messageId).update(newMessage);
      }
    });
  }

  @override
  Future<String> setMessageId(String chatId) async {
    final messageCollectionRef = _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .collection('messages');

    final String _messageId = messageCollectionRef.doc().id;

    return _messageId;
  }

  @override
  Future<void> readMessages(String chatId, String sederUID) async {
    final messageCollectionRef = _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('sederUID', isEqualTo: sederUID)
        .where('isRead', isEqualTo: false);

    await messageCollectionRef.get()
      ..docs.forEach((element) {
        element.reference.update({'isRead': true});
      });
  }

  @override
  // ignore: long-method
  Future<void> addActiveChatDetails(ChatEntity chatEntity) async {
    final myChatDetailsCollectionRef = _firebaseFirestore
        .collection('users')
        .doc(chatEntity.senderUid)
        .collection('myChat');

    final otherChatDetailsCollectionRef = _firebaseFirestore
        .collection('users')
        .doc(chatEntity.recepientUid)
        .collection('myChat');

    final myNewChat = ChatModel(
      chatId: chatEntity.chatId,
      senderName: chatEntity.senderName,
      senderUid: chatEntity.senderUid,
      senderPhoneNumber: chatEntity.senderPhoneNumber,
      recepientName: chatEntity.recepientName,
      recepientUid: chatEntity.recepientUid,
      recepientPhoneNumber: chatEntity.recepientPhoneNumber,
      recentTextMessage: chatEntity.recentTextMessage,
      isRead: chatEntity.isRead,
      time: chatEntity.time,
      newMessages: chatEntity.newMessages,
    ).toDocument();

    final otherNewChat = ChatModel(
      chatId: chatEntity.chatId,
      senderName: chatEntity.recepientName,
      senderUid: chatEntity.recepientUid,
      senderPhoneNumber: chatEntity.recepientPhoneNumber,
      recepientName: chatEntity.senderName,
      recepientUid: chatEntity.senderUid,
      recepientPhoneNumber: chatEntity.senderPhoneNumber,
      recentTextMessage: chatEntity.recentTextMessage,
      isRead: chatEntity.isRead,
      time: chatEntity.time,
      newMessages: chatEntity.newMessages,
    ).toDocument();

    await myChatDetailsCollectionRef
        .doc(chatEntity.recepientUid)
        .get()
        .then((myChatDoc) {
      if (!myChatDoc.exists) {
        myChatDetailsCollectionRef.doc(chatEntity.recepientUid).set(myNewChat);
        otherChatDetailsCollectionRef
            .doc(chatEntity.senderUid)
            .set(otherNewChat);

        return;
      } else {
        myChatDetailsCollectionRef
            .doc(chatEntity.recepientUid)
            .update(myNewChat);
        otherChatDetailsCollectionRef
            .doc(chatEntity.senderUid)
            .update(otherNewChat);

        return;
      }
    });
  }

  @override
  Stream<List<MessageEntity>> getMessages(String chatId) {
    final messageCollectionRef = _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .collection('messages');

    return messageCollectionRef.orderBy('time').snapshots().map((snapshot) {
      return snapshot.docs.map(MessageModel.fromSnapShot).toList();
    });
  }

  @override
  Stream<List<ChatEntity>> getActiveChats() {
    final String? uid = auth.currentUser?.uid;
    final chatCollectionRef =
        _firebaseFirestore.collection('users').doc(uid).collection('myChat');

    return chatCollectionRef
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map(ChatModel.fromSnapShot).toList();
    });
  }

  @override
  Future<void> getNewMessages(String chatId, String recepientUid) async {
    final String? uid = auth.currentUser?.uid;
    final chatCollectionRef = _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .collection('messages');

    final snap = await chatCollectionRef
        .where('sederUID', isNotEqualTo: uid)
        .where('isRead', isEqualTo: false)
        .get()
      ..docs;
    final size = snap.size;

    final otherChatDetailsCollectionRef = await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('myChat')
        .doc(recepientUid);
    final messageDoc = await otherChatDetailsCollectionRef.get();

    if (messageDoc.exists) {
      // await messageDoc.reference.update({'newMessages': length});
      await otherChatDetailsCollectionRef.update({'newMessages': size});
    } else {
      return;
    }
  }

  @override
  Future<String> getChatId(String uid, String otherUid) async {
    final userCollectionRef = _firebaseFirestore.collection('users');

    return userCollectionRef
        .doc(uid)
        .collection('activeChats')
        .doc(otherUid)
        .get()
        .then((chatId) {
      if (chatId.exists) {
        return chatId.data()!['chatId'] as String;
      }

      return Future.value('');
    });
  }

  @override
  Future<void> updateChattingWithId(String recepientUid) async {
    final String? uid = auth.currentUser?.uid;

    return _firebaseFirestore
        .collection('users')
        .doc(uid)
        .update({'chattingWith': recepientUid});
  }
}
