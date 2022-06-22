import 'package:chat_app/data/datasource/firebase/firebase_remote_datasource_impl.dart';
import 'package:chat_app/data/repositories/firebase_repository_impl.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';
import 'package:chat_app/domain/usecases/signin_with_credential_usecase.dart';
import 'package:chat_app/domain/usecases/verify_phone_usecase.dart';

import 'package:chat_app/presentation/bloc/auth/bloc/phone_auth_bloc.dart';
import 'package:chat_app/presentation/bloc/current_user/bloc/current_user_bloc.dart';
import 'package:chat_app/presentation/bloc/user/bloc/user_bloc.dart';
import 'package:chat_app/routes/app_router.dart';
import 'package:chat_app/routes/app_router.gr.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/core/dependency_injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait(
    [
      di.init(),
      Firebase.initializeApp(),
    ],
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              // PhoneAuthBloc(firebasePhoneAuth: FirebaseRemoteDataSource()),
              di.sl<PhoneAuthBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<CurrentUserBloc>(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: AppColors.white),
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
    );
  }
}
