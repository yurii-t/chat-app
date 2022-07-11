import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String userId,
    required String userPhone,
    required String userName,
    required String userImage,
    required String userAddress,
    required String userGender,
    required String userMartialStatus,
    required String userPreferLanguage,
    required String pushToken,
  }) : super(
          userId: userId,
          userPhone: userPhone,
          userName: userName,
          userImage: userImage,
          userAddress: userAddress,
          userGender: userGender,
          userMartialStatus: userMartialStatus,
          userPreferLanguage: userPreferLanguage,
          pushToken: pushToken,
        );
  factory UserModel.fromSnapShot(DocumentSnapshot snap) {
    final UserModel user = UserModel(
      userId: snap['userId'] as String,
      userPhone: snap['userPhone'] as String,
      userName: snap['userName'] as String,
      userImage: snap['userImage'] as String,
      userAddress: snap['userAddress'] as String,
      userGender: snap['userGender'] as String,
      userMartialStatus: snap['userMartialStatus'] as String,
      userPreferLanguage: snap['userPreferLanguage'] as String,
      pushToken: snap['pushToken'] as String,
    );

    return user;
  }
  Map<String, Object> toDocument() {
    return {
      'userId': userId,
      'userPhone': userPhone,
      'userName': userName,
      'userImage': userImage,
      'userAddress': userAddress,
      'userGender': userGender,
      'userMartialStatus': userMartialStatus,
      'userPreferLanguage': userPreferLanguage,
      'pushToken': pushToken,
    };
  }
}
