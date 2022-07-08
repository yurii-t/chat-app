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

import '../domain/entities/message_entity.dart' as _i17;
import '../domain/entities/user_entity.dart' as _i18;
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
      final args = routeData.argsAs<ChatRouteArgs>();
      return _i15.MaterialPageX<void>(
          routeData: routeData,
          child: _i3.ChatPage(
              senderUid: args.senderUid,
              recipientUid: args.recipientUid,
              senderName: args.senderName,
              recipientName: args.recipientName,
              recipientPhoneNumber: args.recipientPhoneNumber,
              senderPhoneNumber: args.senderPhoneNumber,
              recipientImage: args.recipientImage,
              key: args.key));
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>();
      return _i15.MaterialPageX<void>(
          routeData: routeData,
          child: _i4.ProfilePage(
              allMessages: args.allMessages,
              userid: args.userid,
              key: args.key));
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
      final args = routeData.argsAs<FilesNavigationRouteArgs>();
      return _i15.MaterialPageX<void>(
          routeData: routeData,
          child: _i7.FilesNavigationPage(
              allMessages: args.allMessages,
              recipientName: args.recipientName,
              recipientPhoto: args.recipientPhoto,
              key: args.key));
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return _i15.MaterialPageX<void>(
          routeData: routeData,
          child: _i8.HomePage(userId: args.userId, key: args.key));
    },
    MediaRoute.name: (routeData) {
      final args = routeData.argsAs<MediaRouteArgs>();
      return _i15.MaterialPageX<void>(
          routeData: routeData,
          child: _i9.MediaPage(imagesList: args.imagesList, key: args.key));
    },
    FilesRoute.name: (routeData) {
      final args = routeData.argsAs<FilesRouteArgs>();
      return _i15.MaterialPageX<void>(
          routeData: routeData,
          child: _i10.FilesPage(filesList: args.filesList, key: args.key));
    },
    StatusRoute.name: (routeData) {
      final args = routeData.argsAs<StatusRouteArgs>();
      return _i15.MaterialPageX<void>(
          routeData: routeData,
          child: _i11.StatusPage(userInfo: args.userInfo, key: args.key));
    },
    CallRoute.name: (routeData) {
      return _i15.MaterialPageX<void>(
          routeData: routeData, child: const _i12.CallPage());
    },
    MessageRoute.name: (routeData) {
      final args = routeData.argsAs<MessageRouteArgs>();
      return _i15.MaterialPageX<void>(
          routeData: routeData,
          child: _i13.MessagePage(userInfo: args.userInfo, key: args.key));
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
class ChatRoute extends _i15.PageRouteInfo<ChatRouteArgs> {
  ChatRoute(
      {required String senderUid,
      required String recipientUid,
      required String senderName,
      required String recipientName,
      required String recipientPhoneNumber,
      required String senderPhoneNumber,
      required String recipientImage,
      _i16.Key? key})
      : super(ChatRoute.name,
            path: '/chat-page',
            args: ChatRouteArgs(
                senderUid: senderUid,
                recipientUid: recipientUid,
                senderName: senderName,
                recipientName: recipientName,
                recipientPhoneNumber: recipientPhoneNumber,
                senderPhoneNumber: senderPhoneNumber,
                recipientImage: recipientImage,
                key: key));

  static const String name = 'ChatRoute';
}

class ChatRouteArgs {
  const ChatRouteArgs(
      {required this.senderUid,
      required this.recipientUid,
      required this.senderName,
      required this.recipientName,
      required this.recipientPhoneNumber,
      required this.senderPhoneNumber,
      required this.recipientImage,
      this.key});

  final String senderUid;

  final String recipientUid;

  final String senderName;

  final String recipientName;

  final String recipientPhoneNumber;

  final String senderPhoneNumber;

  final String recipientImage;

  final _i16.Key? key;

  @override
  String toString() {
    return 'ChatRouteArgs{senderUid: $senderUid, recipientUid: $recipientUid, senderName: $senderName, recipientName: $recipientName, recipientPhoneNumber: $recipientPhoneNumber, senderPhoneNumber: $senderPhoneNumber, recipientImage: $recipientImage, key: $key}';
  }
}

/// generated route for
/// [_i4.ProfilePage]
class ProfileRoute extends _i15.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute(
      {required List<_i17.MessageEntity> allMessages,
      required String userid,
      _i16.Key? key})
      : super(ProfileRoute.name,
            path: '/profile-page',
            args: ProfileRouteArgs(
                allMessages: allMessages, userid: userid, key: key));

  static const String name = 'ProfileRoute';
}

class ProfileRouteArgs {
  const ProfileRouteArgs(
      {required this.allMessages, required this.userid, this.key});

  final List<_i17.MessageEntity> allMessages;

  final String userid;

  final _i16.Key? key;

  @override
  String toString() {
    return 'ProfileRouteArgs{allMessages: $allMessages, userid: $userid, key: $key}';
  }
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
class FilesNavigationRoute
    extends _i15.PageRouteInfo<FilesNavigationRouteArgs> {
  FilesNavigationRoute(
      {required List<_i17.MessageEntity> allMessages,
      required String recipientName,
      required String recipientPhoto,
      _i16.Key? key,
      List<_i15.PageRouteInfo>? children})
      : super(FilesNavigationRoute.name,
            path: '/files-navigation-page',
            args: FilesNavigationRouteArgs(
                allMessages: allMessages,
                recipientName: recipientName,
                recipientPhoto: recipientPhoto,
                key: key),
            initialChildren: children);

  static const String name = 'FilesNavigationRoute';
}

class FilesNavigationRouteArgs {
  const FilesNavigationRouteArgs(
      {required this.allMessages,
      required this.recipientName,
      required this.recipientPhoto,
      this.key});

  final List<_i17.MessageEntity> allMessages;

  final String recipientName;

  final String recipientPhoto;

  final _i16.Key? key;

  @override
  String toString() {
    return 'FilesNavigationRouteArgs{allMessages: $allMessages, recipientName: $recipientName, recipientPhoto: $recipientPhoto, key: $key}';
  }
}

/// generated route for
/// [_i8.HomePage]
class HomeRoute extends _i15.PageRouteInfo<HomeRouteArgs> {
  HomeRoute(
      {required String userId,
      _i16.Key? key,
      List<_i15.PageRouteInfo>? children})
      : super(HomeRoute.name,
            path: '/home-page',
            args: HomeRouteArgs(userId: userId, key: key),
            initialChildren: children);

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({required this.userId, this.key});

  final String userId;

  final _i16.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{userId: $userId, key: $key}';
  }
}

/// generated route for
/// [_i9.MediaPage]
class MediaRoute extends _i15.PageRouteInfo<MediaRouteArgs> {
  MediaRoute({required List<_i17.MessageEntity> imagesList, _i16.Key? key})
      : super(MediaRoute.name,
            path: 'media-page',
            args: MediaRouteArgs(imagesList: imagesList, key: key));

  static const String name = 'MediaRoute';
}

class MediaRouteArgs {
  const MediaRouteArgs({required this.imagesList, this.key});

  final List<_i17.MessageEntity> imagesList;

  final _i16.Key? key;

  @override
  String toString() {
    return 'MediaRouteArgs{imagesList: $imagesList, key: $key}';
  }
}

/// generated route for
/// [_i10.FilesPage]
class FilesRoute extends _i15.PageRouteInfo<FilesRouteArgs> {
  FilesRoute({required List<_i17.MessageEntity> filesList, _i16.Key? key})
      : super(FilesRoute.name,
            path: 'files-page',
            args: FilesRouteArgs(filesList: filesList, key: key));

  static const String name = 'FilesRoute';
}

class FilesRouteArgs {
  const FilesRouteArgs({required this.filesList, this.key});

  final List<_i17.MessageEntity> filesList;

  final _i16.Key? key;

  @override
  String toString() {
    return 'FilesRouteArgs{filesList: $filesList, key: $key}';
  }
}

/// generated route for
/// [_i11.StatusPage]
class StatusRoute extends _i15.PageRouteInfo<StatusRouteArgs> {
  StatusRoute({required _i18.UserEntity userInfo, _i16.Key? key})
      : super(StatusRoute.name,
            path: 'status-page',
            args: StatusRouteArgs(userInfo: userInfo, key: key));

  static const String name = 'StatusRoute';
}

class StatusRouteArgs {
  const StatusRouteArgs({required this.userInfo, this.key});

  final _i18.UserEntity userInfo;

  final _i16.Key? key;

  @override
  String toString() {
    return 'StatusRouteArgs{userInfo: $userInfo, key: $key}';
  }
}

/// generated route for
/// [_i12.CallPage]
class CallRoute extends _i15.PageRouteInfo<void> {
  const CallRoute() : super(CallRoute.name, path: 'call-page');

  static const String name = 'CallRoute';
}

/// generated route for
/// [_i13.MessagePage]
class MessageRoute extends _i15.PageRouteInfo<MessageRouteArgs> {
  MessageRoute({required _i18.UserEntity userInfo, _i16.Key? key})
      : super(MessageRoute.name,
            path: 'message-page',
            args: MessageRouteArgs(userInfo: userInfo, key: key));

  static const String name = 'MessageRoute';
}

class MessageRouteArgs {
  const MessageRouteArgs({required this.userInfo, this.key});

  final _i18.UserEntity userInfo;

  final _i16.Key? key;

  @override
  String toString() {
    return 'MessageRouteArgs{userInfo: $userInfo, key: $key}';
  }
}

/// generated route for
/// [_i14.SettingPage]
class SettingRoute extends _i15.PageRouteInfo<void> {
  const SettingRoute() : super(SettingRoute.name, path: 'setting-page');

  static const String name = 'SettingRoute';
}
