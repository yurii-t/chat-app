import 'package:chat_app/data/datasource/firebase/firebase_cloud_messaging.dart';
import 'package:chat_app/data/datasource/firebase/firebase_cloud_messaging_impl.dart';
import 'package:chat_app/data/datasource/firebase/firebase_remote_datasource.dart';
import 'package:chat_app/data/datasource/firebase/firebase_remote_datasource_impl.dart';
import 'package:chat_app/data/datasource/firebase/firebase_storage_remote_datasource.dart';
import 'package:chat_app/data/datasource/firebase/firebase_storage_remote_datasource_impl.dart';
import 'package:chat_app/data/repositories/firebase_cloud_messaging_repository_impl.dart';
import 'package:chat_app/data/repositories/firebase_repository_impl.dart';
import 'package:chat_app/data/repositories/firebase_storage_repository_impl.dart';
import 'package:chat_app/domain/repositories/firebase_cloud_messaging_repository.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';
import 'package:chat_app/domain/repositories/firebase_storage_repository.dart';
import 'package:chat_app/domain/usecases/add_active_chat_details_usecase.dart';
import 'package:chat_app/domain/usecases/create_chat_usecase.dart';
import 'package:chat_app/domain/usecases/create_current_user_usecase.dart';
import 'package:chat_app/domain/usecases/download_file_usecase.dart';
import 'package:chat_app/domain/usecases/download_progress_usecase.dart';
import 'package:chat_app/domain/usecases/get_active_chats_usecase.dart';
import 'package:chat_app/domain/usecases/get_all_users_usecase.dart';
import 'package:chat_app/domain/usecases/get_chat_id_usecase.dart';
import 'package:chat_app/domain/usecases/get_current_user_info_usecase.dart';
import 'package:chat_app/domain/usecases/get_current_user_uid_usecase.dart';
import 'package:chat_app/domain/usecases/get_device_token_usecase.dart';
import 'package:chat_app/domain/usecases/get_messages_usecase.dart';
import 'package:chat_app/domain/usecases/get_new_messages_usecase.dart';
import 'package:chat_app/domain/usecases/get_reference_usecase.dart';
import 'package:chat_app/domain/usecases/is_signin_usecase.dart';
import 'package:chat_app/domain/usecases/read_messages_usecase.dart';
import 'package:chat_app/domain/usecases/receive_notification_usecase.dart';
import 'package:chat_app/domain/usecases/send_message_usecase.dart';
import 'package:chat_app/domain/usecases/set_messageid_usecase.dart';
import 'package:chat_app/domain/usecases/signin_with_credential_usecase.dart';
import 'package:chat_app/domain/usecases/signout_usecase.dart';
import 'package:chat_app/domain/usecases/update_chatting_with_id_usecase.dart';
import 'package:chat_app/domain/usecases/upload_image_usecase.dart';
import 'package:chat_app/domain/usecases/upload_progress_usecase.dart';
import 'package:chat_app/domain/usecases/verify_phone_usecase.dart';
import 'package:chat_app/presentation/bloc/audio_play/bloc/audio_play_bloc.dart';
import 'package:chat_app/presentation/bloc/audio_record/bloc/audio_record_bloc.dart';
import 'package:chat_app/presentation/bloc/audio_wave_loader/bloc/audio_wave_loader_bloc.dart';
import 'package:chat_app/presentation/bloc/auth/bloc/phone_auth_bloc.dart';
import 'package:chat_app/presentation/bloc/auth_status/bloc/auth_status_bloc.dart';
import 'package:chat_app/presentation/bloc/chat/bloc/chat_interaction_bloc.dart';
import 'package:chat_app/presentation/bloc/current_user/bloc/current_user_bloc.dart';
import 'package:chat_app/presentation/bloc/file_interaction/bloc/file_interaction_bloc.dart';
import 'package:chat_app/presentation/bloc/messages/bloc/active_chats_bloc.dart';
import 'package:chat_app/presentation/bloc/notification/bloc/notification_bloc.dart';
import 'package:chat_app/presentation/bloc/user/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;
// ignore: long-method
Future<void> init() async {
  //Bloc
  sl
    ..registerLazySingleton<AuthStatusBloc>(() => AuthStatusBloc(
          getCurrentUserUidUseCase: sl.call(),
          isSignInUseCase: sl.call(),
          signOutUseCase: sl.call(),
        )..add(AuthStatusStarted()))
    ..registerFactory<PhoneAuthBloc>(() => PhoneAuthBloc(
          signinWithCredentialUseCase: sl.call(),
          verifyPhoneUseCase: sl.call(),
        ))
    ..registerLazySingleton<UserBloc>(
      () => UserBloc(
        getAllUsersUseCase: sl.call(),
      )..add(LoadAllUsers()),
    )
    ..registerLazySingleton<CurrentUserBloc>(
      () => CurrentUserBloc(
        createCurrentUserUseCase: sl.call(),
        getCurrentUserInfoUseCase: sl.call(),
        getReferenceUseCase: sl.call(),
        uploadImageUsecase: sl.call(),
        getDeviceTokenUseCase: sl.call(),
      )..add(LoadCurrentUserInfo()),
    )
    ..registerLazySingleton<ActiveChatsBloc>(
      () => ActiveChatsBloc(
        getActiveChatsUseCase: sl.call(),
        getNewMessagesUseCase: sl.call(),
        getChatIdUseCase: sl.call(),
      )..add(LoadActiveChats()),
    )
    ..registerLazySingleton(
      () => ChatInteractionBloc(
        sl.call(),
        sl.call(),
        sl.call(),
        sl.call(),
        sl.call(),
        sl.call(),
        sl.call(),
        sl.call(),
        sl.call(),
        sl.call(),
      ),
    )
    ..registerLazySingleton<FileInteractionBloc>(() => FileInteractionBloc(
          sl.call(),
          sl.call(),
          sl.call(),
          sl.call(),
          sl.call(),
          sl.call(),
          sl.call(),
          sl.call(),
          sl.call(),
        ))
    ..registerLazySingleton<NotificationBloc>(
      () => NotificationBloc(
        sl.call(),
        sl.call(),
      )..add(NotificationReceive()),
    )
    ..registerLazySingleton<AudioRecordBloc>(AudioRecordBloc.new)
    ..registerLazySingleton<AudioPlayBloc>(AudioPlayBloc.new)
    ..registerLazySingleton<AudioWaveLoaderBloc>(
      () => AudioWaveLoaderBloc(sl.call()),
    )
    //UseCase
    ..registerLazySingleton<VerifyPhoneUseCase>(
      () => VerifyPhoneUseCase(sl.call()),
    )
    ..registerLazySingleton<SigninWithCredentialUseCase>(
      () => SigninWithCredentialUseCase(sl.call()),
    )
    ..registerLazySingleton<CreateCurrentUserUseCase>(
      () => CreateCurrentUserUseCase(sl.call()),
    )
    ..registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(sl.call()),
    )
    ..registerLazySingleton<GetCurrentUserInfoUseCase>(
      () => GetCurrentUserInfoUseCase(sl.call()),
    )
    ..registerLazySingleton<AddActiveChatDetailsUseCase>(
      () => AddActiveChatDetailsUseCase(sl.call()),
    )
    ..registerLazySingleton<CreateChatUseCase>(
      () => CreateChatUseCase(sl.call()),
    )
    ..registerLazySingleton<GetActiveChatsUseCase>(
      () => GetActiveChatsUseCase(sl.call()),
    )
    ..registerLazySingleton<GetMessagesUseCase>(
      () => GetMessagesUseCase(sl.call()),
    )
    ..registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(sl.call()),
    )
    ..registerLazySingleton<GetCurrentUserUidUseCase>(
      () => GetCurrentUserUidUseCase(sl.call()),
    )
    ..registerLazySingleton<IsSignInUseCase>(() => IsSignInUseCase(sl.call()))
    ..registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(sl.call()))
    ..registerLazySingleton<GetChatIdUseCase>(() => GetChatIdUseCase(sl.call()))
    ..registerLazySingleton<UploadImageUsecase>(
      () => UploadImageUsecase(sl.call()),
    )
    ..registerLazySingleton<GetReferenceUseCase>(
      () => GetReferenceUseCase(sl.call()),
    )
    ..registerLazySingleton<UploadProgressUsecase>(
      () => UploadProgressUsecase(sl.call()),
    )
    ..registerLazySingleton<SetMessageIdUsecase>(
      () => SetMessageIdUsecase(sl.call()),
    )
    ..registerLazySingleton<GetNewMessagesUseCase>(
      () => GetNewMessagesUseCase(sl.call()),
    )
    ..registerLazySingleton<DownloadFileUseCase>(
      () => DownloadFileUseCase(sl.call()),
    )
    ..registerLazySingleton<DownloadProgressUseCase>(
      () => DownloadProgressUseCase(sl.call()),
    )
    ..registerLazySingleton<ReadMessagesUseCase>(
      () => ReadMessagesUseCase(sl.call()),
    )
    ..registerLazySingleton<GetDeviceTokenUseCase>(
      () => GetDeviceTokenUseCase(sl.call()),
    )
    ..registerLazySingleton<UpdateChattingWithIdUseCase>(
      () => UpdateChattingWithIdUseCase(sl.call()),
    )
    ..registerLazySingleton<ReceiveNotificationUseCase>(
      () => ReceiveNotificationUseCase(sl.call()),
    )

    //Repository
    ..registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseRemoteDataSource: sl.call()),
    )
    ..registerLazySingleton<FirebaseStorageRepository>(
      () => FirebaseStorageRepositoryImpl(sl.call()),
    )
    ..registerLazySingleton<FirebaseCloudMessagingRepository>(
      () => FirebaseCloudMessagingRepositoryImpl(sl.call()),
    )
    //DataSource
    ..registerLazySingleton<FirebaseRemoteDataSource>(
      FirebaseRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<FirebaseStorageRemoteDataSource>(
      FirebaseStorageRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<FirebaseCloudMessaging>(
      FirebaseCloudMessagingImpl.new,
    );

  //External
}
