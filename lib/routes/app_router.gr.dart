// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;

import '../presentation/pages/auth/enter_phone_page.dart' as _i1;
import '../presentation/pages/auth/enter_pin_page.dart' as _i2;
import '../presentation/pages/call/call_page.dart' as _i12;
import '../presentation/pages/camera/camera_page.dart' as _i5;
import '../presentation/pages/chat/chat_page.dart' as _i3;
import '../presentation/pages/files/files_navigation_page.dart' as _i7;
import '../presentation/pages/files/files_page.dart' as _i10;
import '../presentation/pages/files/media_page.dart' as _i9;
import '../presentation/pages/home_page.dart' as _i8;
import '../presentation/pages/message/message_page.dart' as _i13;
import '../presentation/pages/profile/my_profile_page.dart' as _i6;
import '../presentation/pages/profile/profile_page.dart' as _i4;
import '../presentation/pages/settings/setting_page.dart' as _i14;
import '../presentation/pages/status/status_page.dart' as _i11;

class AppRouter extends _i15.RootStackRouter {
  AppRouter([_i16.GlobalKey<_i16.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    EnterPhoneRoute.name: (routeData) {
      return _i15.MaterialPageX<void>(
          routeData: routeData, child: const _i1.EnterPhonePage());
    },
    EnterPinRoute.name: (routeData) {
      final args = routeData.argsAs<EnterPinRouteArgs>();
      return _i15.MaterialPageX<void>(
          routeData: routeData,
          child: _i2.EnterPinPage(verId: args.verId, key: args.key));
    },
    ChatRoute.name: (routeData) {
      return _i15.MaterialPageX<void>(
          routeData: routeData, child: const _i3.ChatPage());
    },
    ProfileRoute.name: (routeData) {
      return _i15.MaterialPageX<void>(
          routeData: routeData, child: const _i4.ProfilePage());
    },
    CameraRoute.name: (routeData) {
      return _i15.MaterialPageX<void>(
          routeData: routeData, child: const _i5.CameraPage());
    },
    MyProfileRoute.name: (routeData) {
      return _i15.MaterialPageX<void>(
          routeData: routeData, child: const _i6.MyProfilePage());
    },
    FilesNavigationRoute.name: (routeData) {
      return _i15.MaterialPageX<void>(
          routeData: routeData, child: const _i7.FilesNavigationPage());
    },
    HomeRoute.name: (routeData) {
      return _i15.MaterialPageX<void>(
          routeData: routeData, child: const _i8.HomePage());
    },
    MediaRoute.name: (routeData) {
      return _i15.MaterialPageX<void>(
          routeData: routeData, child: const _i9.MediaPage());
    },
    FilesRoute.name: (routeData) {
      return _i15.MaterialPageX<void>(
          routeData: routeData, child: const _i10.FilesPage());
    },
    StatusRoute.name: (routeData) {
      return _i15.MaterialPageX<void>(
          routeData: routeData, child: const _i11.StatusPage());
    },
    CallRoute.name: (routeData) {
      return _i15.MaterialPageX<void>(
          routeData: routeData, child: const _i12.CallPage());
    },
    MessageRoute.name: (routeData) {
      return _i15.MaterialPageX<void>(
          routeData: routeData, child: const _i13.MessagePage());
    },
    SettingRoute.name: (routeData) {
      return _i15.MaterialPageX<void>(
          routeData: routeData, child: const _i14.SettingPage());
    }
  };

  @override
  List<_i15.RouteConfig> get routes => [
        _i15.RouteConfig(EnterPhoneRoute.name, path: '/'),
        _i15.RouteConfig(EnterPinRoute.name, path: '/enter-pin-page'),
        _i15.RouteConfig(ChatRoute.name, path: '/chat-page'),
        _i15.RouteConfig(ProfileRoute.name, path: '/profile-page'),
        _i15.RouteConfig(CameraRoute.name, path: '/camera-page'),
        _i15.RouteConfig(MyProfileRoute.name, path: '/my-profile-page'),
        _i15.RouteConfig(FilesNavigationRoute.name,
            path: '/files-navigation-page',
            children: [
              _i15.RouteConfig(MediaRoute.name,
                  path: 'media-page', parent: FilesNavigationRoute.name),
              _i15.RouteConfig(FilesRoute.name,
                  path: 'files-page', parent: FilesNavigationRoute.name)
            ]),
        _i15.RouteConfig(HomeRoute.name, path: '/home-page', children: [
          _i15.RouteConfig(StatusRoute.name,
              path: 'status-page', parent: HomeRoute.name),
          _i15.RouteConfig(CallRoute.name,
              path: 'call-page', parent: HomeRoute.name),
          _i15.RouteConfig(MessageRoute.name,
              path: 'message-page', parent: HomeRoute.name),
          _i15.RouteConfig(SettingRoute.name,
              path: 'setting-page', parent: HomeRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.EnterPhonePage]
class EnterPhoneRoute extends _i15.PageRouteInfo<void> {
  const EnterPhoneRoute() : super(EnterPhoneRoute.name, path: '/');

  static const String name = 'EnterPhoneRoute';
}

/// generated route for
/// [_i2.EnterPinPage]
class EnterPinRoute extends _i15.PageRouteInfo<EnterPinRouteArgs> {
  EnterPinRoute({required String verId, _i16.Key? key})
      : super(EnterPinRoute.name,
            path: '/enter-pin-page',
            args: EnterPinRouteArgs(verId: verId, key: key));

  static const String name = 'EnterPinRoute';
}

class EnterPinRouteArgs {
  const EnterPinRouteArgs({required this.verId, this.key});

  final String verId;

  final _i16.Key? key;

  @override
  String toString() {
    return 'EnterPinRouteArgs{verId: $verId, key: $key}';
  }
}

/// generated route for
/// [_i3.ChatPage]
class ChatRoute extends _i15.PageRouteInfo<void> {
  const ChatRoute() : super(ChatRoute.name, path: '/chat-page');

  static const String name = 'ChatRoute';
}

/// generated route for
/// [_i4.ProfilePage]
class ProfileRoute extends _i15.PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: '/profile-page');

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i5.CameraPage]
class CameraRoute extends _i15.PageRouteInfo<void> {
  const CameraRoute() : super(CameraRoute.name, path: '/camera-page');

  static const String name = 'CameraRoute';
}

/// generated route for
/// [_i6.MyProfilePage]
class MyProfileRoute extends _i15.PageRouteInfo<void> {
  const MyProfileRoute() : super(MyProfileRoute.name, path: '/my-profile-page');

  static const String name = 'MyProfileRoute';
}

/// generated route for
/// [_i7.FilesNavigationPage]
class FilesNavigationRoute extends _i15.PageRouteInfo<void> {
  const FilesNavigationRoute({List<_i15.PageRouteInfo>? children})
      : super(FilesNavigationRoute.name,
            path: '/files-navigation-page', initialChildren: children);

  static const String name = 'FilesNavigationRoute';
}

/// generated route for
/// [_i8.HomePage]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/home-page', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i9.MediaPage]
class MediaRoute extends _i15.PageRouteInfo<void> {
  const MediaRoute() : super(MediaRoute.name, path: 'media-page');

  static const String name = 'MediaRoute';
}

/// generated route for
/// [_i10.FilesPage]
class FilesRoute extends _i15.PageRouteInfo<void> {
  const FilesRoute() : super(FilesRoute.name, path: 'files-page');

  static const String name = 'FilesRoute';
}

/// generated route for
/// [_i11.StatusPage]
class StatusRoute extends _i15.PageRouteInfo<void> {
  const StatusRoute() : super(StatusRoute.name, path: 'status-page');

  static const String name = 'StatusRoute';
}

/// generated route for
/// [_i12.CallPage]
class CallRoute extends _i15.PageRouteInfo<void> {
  const CallRoute() : super(CallRoute.name, path: 'call-page');

  static const String name = 'CallRoute';
}

/// generated route for
/// [_i13.MessagePage]
class MessageRoute extends _i15.PageRouteInfo<void> {
  const MessageRoute() : super(MessageRoute.name, path: 'message-page');

  static const String name = 'MessageRoute';
}

/// generated route for
/// [_i14.SettingPage]
class SettingRoute extends _i15.PageRouteInfo<void> {
  const SettingRoute() : super(SettingRoute.name, path: 'setting-page');

  static const String name = 'SettingRoute';
}
