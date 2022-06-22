import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/usecases/create_current_user_usecase.dart';
import 'package:chat_app/domain/usecases/get_current_user_info_usecase.dart';
import 'package:equatable/equatable.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final CreateCurrentUserUseCase createCurrentUserUseCase;
  final GetCurrentUserInfoUseCase getCurrentUserInfoUseCase;

  CurrentUserBloc(
      {required this.createCurrentUserUseCase,
      required this.getCurrentUserInfoUseCase})
      : super(CurrentUserInitial()) {
    on<CreateUser>(createUser);
    on<LoadCurrentUserInfo>(onCurrentUserInfo);
  }

  Future<void> createUser(
      CreateUser event, Emitter<CurrentUserState> emit) async {
    try {
      await createCurrentUserUseCase.call(UserEntity(
        userId: '',
        userPhone: '', //event.userPhone,
        userName: event.userName,
        userImage: event.userImage,
        userAddress: event.userAddress,
        userGender: event.userGender,
        userMartialStatus: event.userMartialStatus,
        userPreferLanguage: event.userPreferLanguage,
      ));
    } on SocketException catch (e) {
      emit(CurrentUserError(e.toString()));
    }
  }

  Future<void> onCurrentUserInfo(
      LoadCurrentUserInfo event, Emitter<CurrentUserState> emit) async {
    try {
      final userInfo = await getCurrentUserInfoUseCase.call(NoParams());
      emit(CurrentUserLoaded(userInfo));
    } on SocketException catch (e) {
      emit(CurrentUserError(e.toString()));
    }
  }
}
