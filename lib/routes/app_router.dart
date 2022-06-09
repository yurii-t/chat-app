import 'package:auto_route/auto_route.dart';
import 'package:chat_app/presentation/pages/auth/enter_phone_page.dart';
import 'package:chat_app/presentation/pages/auth/enter_pin_page.dart';
import 'package:chat_app/presentation/pages/call/call_page.dart';
import 'package:chat_app/presentation/pages/camera/camera_page.dart';
import 'package:chat_app/presentation/pages/chat/chat_page.dart';
import 'package:chat_app/presentation/pages/home_page.dart';
import 'package:chat_app/presentation/pages/message/message_page.dart';
import 'package:chat_app/presentation/pages/profile/profile_page.dart';

import 'package:chat_app/presentation/pages/settings/setting_page.dart';
import 'package:chat_app/presentation/pages/status/status_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<void>(page: EnterPhonePage, initial: true),
    AutoRoute<void>(page: EnterPinPage),
    AutoRoute<void>(page: ChatPage),
    AutoRoute<void>(page: ProfilePage),
    AutoRoute<void>(page: CameraPage),

    AutoRoute<void>(
      page: HomePage,
      children: [
        AutoRoute<void>(
          page: StatusPage,
        ),
        AutoRoute<void>(
          page: CallPage,
        ),
        AutoRoute<void>(page: MessagePage),
        AutoRoute<void>(page: SettingPage),
      ],
    ),

    // AutoRoute<void>(page: FilterScreen),
    // AutoRoute<void>(page: SearchScreen),
  ],
)
class $AppRouter {}
