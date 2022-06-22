import 'package:chat_app/data/datasource/firebase/firebase_remote_datasource.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
        userPhone: phoneNumber ?? '', //user.userPhone,
        userName: user.userName,
        userImage: user.userImage,
        userAddress: user.userAddress,
        userGender: user.userGender,
        userMartialStatus: user.userMartialStatus,
        userPreferLanguage: user.userPreferLanguage,
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
    final String? currentUid = auth.currentUser?.uid;

    return _firebaseFirestore
        .collection('users')
        .where('userId', isNotEqualTo: currentUid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map(UserModel.fromSnapShot).toList();
    });
  }

  @override
  Future<UserEntity> getCurrentUserInfo() async {
    final userCollection = _firebaseFirestore.collection('users');
    final String? uid = await auth.currentUser?.uid;

    return userCollection.doc(uid).get().then(UserModel.fromSnapShot);
  }
}
