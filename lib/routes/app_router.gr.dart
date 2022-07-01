// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;

import '../presentation/pages/auth/enter_phone_page.dart' as _i1;
import '../presentation/pages/auth/enter_pin_page.dart' as _i2;
import '../presentation/pages/call/call_page.dart' as _i8;
import '../presentation/pages/camera/camera_page.dart' as _i5;
import '../presentation/pages/chat/chat_page.dart' as _i3;
import '../presentation/pages/home_page.dart' as _i6;
import '../presentation/pages/message/message_page.dart' as _i9;
import '../presentation/pages/profile/profile_page.dart' as _i4;
import '../presentation/pages/settings/setting_page.dart' as _i10;
import '../presentation/pages/status/status_page.dart' as _i7;

class AppRouter extends _i11.RootStackRouter {
  AppRouter([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    EnterPhoneRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i1.EnterPhonePage());
    },
    EnterPinRoute.name: (routeData) {
      final args = routeData.argsAs<EnterPinRouteArgs>();
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i2.EnterPinPage(verId: args.verId, key: args.key));
    },
    ChatRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i3.ChatPage());
    },
    ProfileRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i4.ProfilePage());
    },
    CameraRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i5.CameraPage());
    },
    HomeRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i6.HomePage());
    },
    StatusRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i7.StatusPage());
    },
    CallRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i8.CallPage());
    },
    MessageRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i9.MessagePage());
    },
    SettingRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i10.SettingPage());
    }
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(EnterPhoneRoute.name, path: '/'),
        _i11.RouteConfig(EnterPinRoute.name, path: '/enter-pin-page'),
        _i11.RouteConfig(ChatRoute.name, path: '/chat-page'),
        _i11.RouteConfig(ProfileRoute.name, path: '/profile-page'),
        _i11.RouteConfig(CameraRoute.name, path: '/camera-page'),
        _i11.RouteConfig(HomeRoute.name, path: '/home-page', children: [
          _i11.RouteConfig(StatusRoute.name,
              path: 'status-page', parent: HomeRoute.name),
          _i11.RouteConfig(CallRoute.name,
              path: 'call-page', parent: HomeRoute.name),
          _i11.RouteConfig(MessageRoute.name,
              path: 'message-page', parent: HomeRoute.name),
          _i11.RouteConfig(SettingRoute.name,
              path: 'setting-page', parent: HomeRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.EnterPhonePage]
class EnterPhoneRoute extends _i11.PageRouteInfo<void> {
  const EnterPhoneRoute() : super(EnterPhoneRoute.name, path: '/');

  static const String name = 'EnterPhoneRoute';
}

/// generated route for
/// [_i2.EnterPinPage]
class EnterPinRoute extends _i11.PageRouteInfo<EnterPinRouteArgs> {
  EnterPinRoute({required String verId, _i12.Key? key})
      : super(EnterPinRoute.name,
            path: '/enter-pin-page',
            args: EnterPinRouteArgs(verId: verId, key: key));

  static const String name = 'EnterPinRoute';
}

class EnterPinRouteArgs {
  const EnterPinRouteArgs({required this.verId, this.key});

  final String verId;

  final _i12.Key? key;

  @override
  String toString() {
    return 'EnterPinRouteArgs{verId: $verId, key: $key}';
  }
}

/// generated route for
/// [_i3.ChatPage]
class ChatRoute extends _i11.PageRouteInfo<void> {
  const ChatRoute() : super(ChatRoute.name, path: '/chat-page');

  static const String name = 'ChatRoute';
}

/// generated route for
/// [_i4.ProfilePage]
class ProfileRoute extends _i11.PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: '/profile-page');

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i5.CameraPage]
class CameraRoute extends _i11.PageRouteInfo<void> {
  const CameraRoute() : super(CameraRoute.name, path: '/camera-page');

  static const String name = 'CameraRoute';
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/home-page', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i7.StatusPage]
class StatusRoute extends _i11.PageRouteInfo<void> {
  const StatusRoute() : super(StatusRoute.name, path: 'status-page');

  static const String name = 'StatusRoute';
}

/// generated route for
/// [_i8.CallPage]
class CallRoute extends _i11.PageRouteInfo<void> {
  const CallRoute() : super(CallRoute.name, path: 'call-page');

  static const String name = 'CallRoute';
}

/// generated route for
/// [_i9.MessagePage]
class MessageRoute extends _i11.PageRouteInfo<void> {
  const MessageRoute() : super(MessageRoute.name, path: 'message-page');

  static const String name = 'MessageRoute';
}

/// generated route for
/// [_i10.SettingPage]
class SettingRoute extends _i11.PageRouteInfo<void> {
  const SettingRoute() : super(SettingRoute.name, path: 'setting-page');

  static const String name = 'SettingRoute';
}
