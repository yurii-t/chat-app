import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String userPhone;
  final String userName;
  final String userImage;
  final String userAddress;
  final String userGender;
  final String userMartialStatus;
  final String userPreferLanguage;

  const User({
    required this.userId,
    required this.userPhone,
    required this.userName,
    required this.userImage,
    required this.userAddress,
    required this.userGender,
    required this.userMartialStatus,
    required this.userPreferLanguage,
  });
  factory User.fromSnapShot(DocumentSnapshot snap) {
    final User user = User(
      userId: snap['userId'] as String,
      userPhone: snap['userPhone'] as String,
      userName: snap['userName'] as String,
      userImage: snap['userImage'] as String,
      userAddress: snap['userAddress'] as String,
      userGender: snap['userGender'] as String,
      userMartialStatus: snap['isFeatured'] as String,
      userPreferLanguage: snap['inStock'] as String,
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

  @override
  List<Object?> get props => [
        userId,
        userPhone,
        userName,
        userImage,
        userAddress,
        userGender,
        userMartialStatus,
        userPreferLanguage,
      ];
}
