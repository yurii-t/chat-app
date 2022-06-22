part of 'current_user_bloc.dart';

abstract class CurrentUserEvent extends Equatable {
  const CurrentUserEvent();

  @override
  List<Object> get props => [];
}

class CreateUser extends CurrentUserEvent {
  // userId;
  // final String userPhone;
  final String userName;
  final String userImage;
  final String userAddress;
  final String userGender;
  final String userMartialStatus;
  final String userPreferLanguage;

  const CreateUser(
      // this.userPhone,
      this.userName,
      this.userImage,
      this.userAddress,
      this.userGender,
      this.userMartialStatus,
      this.userPreferLanguage);

  @override
  List<Object> get props => [
        // userPhone,
        userName,
        userImage,
        userAddress,
        userGender,
        userMartialStatus,
        userGender,
      ];
}

class LoadCurrentUserInfo extends CurrentUserEvent {}
