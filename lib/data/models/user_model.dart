import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends UserEntity {
  // final String userId;
  // final String userPhone;
  // final String userName;
  // final String userImage;
  // final String userAddress;
  // final String userGender;
  // final String userMartialStatus;
  // final String userPreferLanguage;

  const UserModel({
    required String userId,
    required String userPhone,
    required String userName,
    required String userImage,
    required String userAddress,
    required String userGender,
    required String userMartialStatus,
    required String userPreferLanguage,
  }) : super(
          userId: userId,
          userPhone: userPhone,
          userName: userName,
          userImage: userImage,
          userAddress: userAddress,
          userGender: userGender,
          userMartialStatus: userMartialStatus,
          userPreferLanguage: userPreferLanguage,
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
    };
  }

  // @override
  // List<Object?> get props => [
  //       userId,
  //       userPhone,
  //       userName,
  //       userImage,
  //       userAddress,
  //       userGender,
  //       userMartialStatus,
  //       userPreferLanguage,
  //     ];
}
