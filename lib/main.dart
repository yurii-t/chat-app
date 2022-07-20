import 'package:chat_app/core/dependency_injection.dart' as di;
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
import 'package:chat_app/routes/app_router.gr.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ignore: long-method
Future<void> main() async {
  const InitializationSettings initializationSettings =
      const InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait(
    [
      di.init(),
      Firebase.initializeApp(),
      FlutterLocalNotificationsPlugin().initialize(initializationSettings),
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
        BlocProvider(
          create: (context) => di.sl<NotificationBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<AudioRecordBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<AudioPlayBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<AudioWaveLoaderBloc>(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

//ignore: prefer-match-file-name
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: AppColors.white),
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
      builder: (context, child) {
        return BlocListener<AuthStatusBloc, AuthStatusState>(
          listener: (context, state) {
            if (state is Authenticated) {
              _appRouter.replace(HomeRoute(userId: state.uid));
            } else {
              _appRouter.replace(const EnterPhoneRoute());
            }
          },
          child: child,
        );
      },
    );
  }
}
