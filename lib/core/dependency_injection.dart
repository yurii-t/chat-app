import 'package:chat_app/data/datasource/firebase/firebase_remote_datasource.dart';
import 'package:chat_app/data/datasource/firebase/firebase_remote_datasource_impl.dart';
import 'package:chat_app/data/datasource/firebase/firebase_storage_remote_datasource.dart';
import 'package:chat_app/data/datasource/firebase/firebase_storage_remote_datasource_impl.dart';
import 'package:chat_app/data/repositories/firebase_repository_impl.dart';
import 'package:chat_app/data/repositories/firebase_storage_repository_impl.dart';
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
import 'package:chat_app/domain/usecases/get_messages_usecase.dart';
import 'package:chat_app/domain/usecases/get_new_messages_usecase.dart';
import 'package:chat_app/domain/usecases/get_reference_usecase.dart';
import 'package:chat_app/domain/usecases/is_signin_usecase.dart';
import 'package:chat_app/domain/usecases/read_messages_usecase.dart';
import 'package:chat_app/domain/usecases/send_message_usecase.dart';
import 'package:chat_app/domain/usecases/set_messageid_usecase.dart';
import 'package:chat_app/domain/usecases/signin_with_credential_usecase.dart';
import 'package:chat_app/domain/usecases/signout_usecase.dart';
import 'package:chat_app/domain/usecases/upload_image_usecase.dart';
import 'package:chat_app/domain/usecases/upload_progress_usecase.dart';
import 'package:chat_app/domain/usecases/verify_phone_usecase.dart';
import 'package:chat_app/presentation/bloc/auth/bloc/phone_auth_bloc.dart';
import 'package:chat_app/presentation/bloc/auth_status/bloc/auth_status_bloc.dart';
import 'package:chat_app/presentation/bloc/chat/bloc/chat_interaction_bloc.dart';
import 'package:chat_app/presentation/bloc/current_user/bloc/current_user_bloc.dart';
import 'package:chat_app/presentation/bloc/file_interaction/bloc/file_interaction_bloc.dart';
import 'package:chat_app/presentation/bloc/messages/bloc/active_chats_bloc.dart';
import 'package:chat_app/presentation/bloc/user/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  //Bloc
  sl.registerLazySingleton<AuthStatusBloc>(() => AuthStatusBloc(
        getCurrentUserUidUseCase: sl.call(),
        isSignInUseCase: sl.call(),
        signOutUseCase: sl.call(),
      )..add(AuthStatusStarted()));

  sl.registerFactory<PhoneAuthBloc>(() => PhoneAuthBloc(
        signinWithCredentialUseCase: sl.call(),
        verifyPhoneUseCase: sl.call(),
      ));
  // sl.registerFactory<UserBloc>(() => UserBloc(
  //       createCurrentUserUseCase: sl.call(),
  //       getAllUsersUseCase: sl.call(),
  //     ));
  sl.registerLazySingleton<UserBloc>(
    () => UserBloc(
      // createCurrentUserUseCase: sl.call(),
      getAllUsersUseCase: sl.call(),
      // getCurrentUserInfoUseCase: sl.call(),
    )..add(LoadAllUsers()),
  );
  sl.registerLazySingleton<CurrentUserBloc>(
    () => CurrentUserBloc(
      createCurrentUserUseCase: sl.call(),
      getCurrentUserInfoUseCase: sl.call(),
      getReferenceUseCase: sl.call(),
      uploadImageUsecase: sl.call(),
    )..add(LoadCurrentUserInfo()),
  );
  sl.registerLazySingleton<ActiveChatsBloc>(
    () => ActiveChatsBloc(
        getActiveChatsUseCase: sl.call(),
        getNewMessagesUseCase: sl.call(),
        getChatIdUseCase: sl.call())
      ..add(LoadActiveChats()),
  );
  sl.registerLazySingleton(
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
    ),
  );
  sl.registerLazySingleton<FileInteractionBloc>(() => FileInteractionBloc(
        sl.call(),
        sl.call(),
        sl.call(),
        sl.call(),
        sl.call(),
        sl.call(),
        sl.call(),
        sl.call(),
        sl.call(),
      ));
  //UseCase
  sl.registerLazySingleton<VerifyPhoneUseCase>(
    () => VerifyPhoneUseCase(sl.call()),
  );
  sl.registerLazySingleton<SigninWithCredentialUseCase>(
    () => SigninWithCredentialUseCase(sl.call()),
  );
  sl.registerLazySingleton<CreateCurrentUserUseCase>(
    () => CreateCurrentUserUseCase(sl.call()),
  );
  sl.registerLazySingleton<GetAllUsersUseCase>(
    () => GetAllUsersUseCase(sl.call()),
  );
  sl.registerLazySingleton<GetCurrentUserInfoUseCase>(
    () => GetCurrentUserInfoUseCase(sl.call()),
  );
  sl.registerLazySingleton<AddActiveChatDetailsUseCase>(
    () => AddActiveChatDetailsUseCase(sl.call()),
  );
  sl.registerLazySingleton<CreateChatUseCase>(
    () => CreateChatUseCase(sl.call()),
  );
  sl.registerLazySingleton<GetActiveChatsUseCase>(
    () => GetActiveChatsUseCase(sl.call()),
  );
  sl.registerLazySingleton<GetMessagesUseCase>(
    () => GetMessagesUseCase(sl.call()),
  );
  sl.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(sl.call()),
  );
  sl.registerLazySingleton<GetCurrentUserUidUseCase>(
      () => GetCurrentUserUidUseCase(sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(() => IsSignInUseCase(sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(sl.call()));
  sl.registerLazySingleton<GetChatIdUseCase>(() => GetChatIdUseCase(sl.call()));
  sl.registerLazySingleton<UploadImageUsecase>(
      () => UploadImageUsecase(sl.call()));
  sl.registerLazySingleton<GetReferenceUseCase>(
      () => GetReferenceUseCase(sl.call()));
  sl.registerLazySingleton<UploadProgressUsecase>(
      () => UploadProgressUsecase(sl.call()));
  sl.registerLazySingleton<SetMessageIdUsecase>(
      () => SetMessageIdUsecase(sl.call()));
  sl.registerLazySingleton<GetNewMessagesUseCase>(
      () => GetNewMessagesUseCase(sl.call()));
  //Repository
  sl.registerLazySingleton<FirebaseRepository>(
    () => FirebaseRepositoryImpl(firebaseRemoteDataSource: sl.call()),
  );
  sl.registerLazySingleton<FirebaseStorageRepository>(
      () => FirebaseStorageRepositoryImpl(sl.call()));
  //DataSource
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
    () => FirebaseRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<FirebaseStorageRemoteDataSource>(
    () => FirebaseStorageRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<DownloadFileUseCase>(
      () => DownloadFileUseCase(sl.call()));
  sl.registerLazySingleton<DownloadProgressUseCase>(
      () => DownloadProgressUseCase(sl.call()));
  sl.registerLazySingleton<ReadMesagesUseCase>(
      () => ReadMesagesUseCase(sl.call()));

  //External
}
