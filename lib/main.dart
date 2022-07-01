import 'package:auto_route/auto_route.dart';
import 'package:chat_app/data/datasource/firebase/firebase_remote_datasource_impl.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/data/repositories/firebase_repository_impl.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';
import 'package:chat_app/domain/usecases/signin_with_credential_usecase.dart';
import 'package:chat_app/domain/usecases/verify_phone_usecase.dart';

import 'package:chat_app/presentation/bloc/auth/bloc/phone_auth_bloc.dart';
import 'package:chat_app/presentation/bloc/auth_status/bloc/auth_status_bloc.dart';
import 'package:chat_app/presentation/bloc/chat/bloc/chat_interaction_bloc.dart';
import 'package:chat_app/presentation/bloc/current_user/bloc/current_user_bloc.dart';
import 'package:chat_app/presentation/bloc/file_interaction/bloc/file_interaction_bloc.dart';
import 'package:chat_app/presentation/bloc/messages/bloc/active_chats_bloc.dart';
import 'package:chat_app/presentation/bloc/user/bloc/user_bloc.dart';
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
          create: (context) => di.sl<AuthStatusBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<PhoneAuthBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<CurrentUserBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ActiveChatsBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ChatInteractionBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<FileInteractionBloc>(),
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
    // bool? logedIn;

    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: AppColors.white),
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
      builder: (context, child) {
        return BlocListener<AuthStatusBloc, AuthStatusState>(
          // return BlocBuilder<AuthStatusBloc, AuthStatusState>(
          // builder: (context, state) {
          listener: (context, state) {
            if (state is Authenticated) {
              // _appRouter.replace(MyProfileRoute());

              _appRouter.replace(HomeRoute(userId: state.uid));

              //  BlocBuilder<UserBloc, UserState>(
              //   builder: (context, userState) {
              //     if (userState is UserLoaded) {
              //       final currentUseInfo = userState.allUsers.firstWhere(
              //         (user) => user.userId == state.uid,
              //       );

              //       _appRouter.replace(HomeRoute(userInfo: currentUseInfo));
              //     }
              //     return Container();
              //   },
              // );
            } else {
              _appRouter.replace(EnterPhoneRoute());
            }

            // return Container();
          },
          child: child,
        );
      },
    );

    // return BlocBuilder<AuthStatusBloc, AuthStatusState>(
    //   builder: (context, state) {
    //     return MaterialApp.router(
    //       theme: ThemeData(scaffoldBackgroundColor: AppColors.white),
    //       routeInformationParser: _appRouter.defaultRouteParser(),
    //       routerDelegate: AutoRouterDelegate.declarative(
    //         _appRouter,
    //         routes: (_) => [
    //           if (state is Authenticated) HomeRoute() else EnterPhoneRoute(),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
