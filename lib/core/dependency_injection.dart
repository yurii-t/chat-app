import 'package:chat_app/data/datasource/firebase/firebase_remote_datasource.dart';
import 'package:chat_app/data/datasource/firebase/firebase_remote_datasource_impl.dart';
import 'package:chat_app/data/repositories/firebase_repository_impl.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';
import 'package:chat_app/domain/usecases/create_current_user_usecase.dart';
import 'package:chat_app/domain/usecases/get_all_users_usecase.dart';
import 'package:chat_app/domain/usecases/get_current_user_info_usecase.dart';
import 'package:chat_app/domain/usecases/signin_with_credential_usecase.dart';
import 'package:chat_app/domain/usecases/verify_phone_usecase.dart';
import 'package:chat_app/presentation/bloc/auth/bloc/phone_auth_bloc.dart';
import 'package:chat_app/presentation/bloc/current_user/bloc/current_user_bloc.dart';
import 'package:chat_app/presentation/bloc/user/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  //Bloc
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
    )..add(LoadCurrentUserInfo()),
  );

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

  //Repository
  sl.registerLazySingleton<FirebaseRepository>(
    () => FirebaseRepositoryImpl(firebaseRemoteDataSource: sl.call()),
  );
  //DataSource
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
      () => FirebaseRemoteDataSourceImpl());

  //External
}
