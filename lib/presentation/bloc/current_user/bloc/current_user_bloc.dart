// ignore_for_file: avoid-unused-parameters
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/usecases/create_current_user_usecase.dart';
import 'package:chat_app/domain/usecases/get_current_user_info_usecase.dart';
import 'package:chat_app/domain/usecases/get_device_token_usecase.dart';
import 'package:chat_app/domain/usecases/get_reference_usecase.dart';
import 'package:chat_app/domain/usecases/upload_image_usecase.dart';
import 'package:equatable/equatable.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final CreateCurrentUserUseCase createCurrentUserUseCase;
  final GetCurrentUserInfoUseCase getCurrentUserInfoUseCase;
  final GetReferenceUseCase getReferenceUseCase;
  final UploadImageUsecase uploadImageUsecase;
  final GetDeviceTokenUseCase getDeviceTokenUseCase;

  CurrentUserBloc({
    required this.createCurrentUserUseCase,
    required this.getCurrentUserInfoUseCase,
    required this.getReferenceUseCase,
    required this.uploadImageUsecase,
    required this.getDeviceTokenUseCase,
  }) : super(CurrentUserInitial()) {
    on<CreateUser>(createUser);
    on<LoadCurrentUserInfo>(onCurrentUserInfo);
  }

  Future<void> createUser(
    CreateUser event,
    Emitter<CurrentUserState> emit,
  ) async {
    try {
      final ref = await getReferenceUseCase
          .call(GetReferenceParams(event.userImage, event.userName, 'users'));

      final task = await uploadImageUsecase
          .call(UploadImageParams(event.userImage, ref));
      final imageUrl =
          await (await task.whenComplete(() => {print('link ready')}))
              .ref
              .getDownloadURL();
      final pushToken = await getDeviceTokenUseCase.call(NoParams());
      await createCurrentUserUseCase.call(UserEntity(
        userId: '',
        userPhone: '',
        userName: event.userName,
        userImage: imageUrl,
        userAddress: event.userAddress,
        userGender: event.userGender,
        userMartialStatus: event.userMartialStatus,
        userPreferLanguage: event.userPreferLanguage,
        pushToken: pushToken,
      ));
    } on SocketException catch (e) {
      emit(CurrentUserError(e.toString()));
    }
  }

  Future<void> onCurrentUserInfo(
    LoadCurrentUserInfo event,
    Emitter<CurrentUserState> emit,
  ) async {
    try {
      final userInfo = await getCurrentUserInfoUseCase.call(NoParams());
      emit(CurrentUserLoaded(userInfo));
    } on SocketException catch (e) {
      emit(CurrentUserError(e.toString()));
    }
  }
}
