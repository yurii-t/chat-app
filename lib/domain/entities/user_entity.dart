import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String userPhone;
  final String userName;
  final String userImage;
  final String userAddress;
  final String userGender;
  final String userMartialStatus;
  final String userPreferLanguage;

  const UserEntity({
    required this.userId,
    required this.userPhone,
    required this.userName,
    required this.userImage,
    required this.userAddress,
    required this.userGender,
    required this.userMartialStatus,
    required this.userPreferLanguage,
  });
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
