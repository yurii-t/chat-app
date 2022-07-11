import 'package:auto_route/auto_route.dart';

import 'package:chat_app/presentation/bloc/auth_status/bloc/auth_status_bloc.dart';
import 'package:chat_app/presentation/bloc/notification/bloc/notification_bloc.dart';
import 'package:chat_app/presentation/bloc/user/bloc/user_bloc.dart';
import 'package:chat_app/routes/app_router.gr.dart';
import 'package:chat_app/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  final String userId;
  const HomePage({
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final authBlocState = context.watch<AuthStatusBloc>().state;

        if (state is UserLoaded && authBlocState is Authenticated) {
          final userInfo = state.allUsers.firstWhere(
            (user) => user.userId == userId,
          );
          context.read<NotificationBloc>().add(NotificationUpdateToken());

          return BlocListener<NotificationBloc, NotificationState>(
            listener: (context, state) {
              if (state is NotificationReceived) {
                const AndroidNotificationDetails
                    androidPlatformChannelSpecifics =
                    const AndroidNotificationDetails(
                  'Flutter chat demo',
                  'your channel description',
                  playSound: true,
                  enableVibration: true,
                  importance: Importance.max,
                  priority: Priority.high,
                );
                const IOSNotificationDetails iOSPlatformChannelSpecifics =
                    const IOSNotificationDetails();
                const NotificationDetails platformChannelSpecifics =
                    const NotificationDetails(
                  android: androidPlatformChannelSpecifics,
                  iOS: iOSPlatformChannelSpecifics,
                );
                flutterLocalNotificationsPlugin.show(
                  0,
                  state.notification.notification?.title,
                  state.notification.notification?.body,
                  platformChannelSpecifics,
                  payload: null,
                );
              }
            },
            child: AutoTabsScaffold(
              routes: [
                StatusRoute(userInfo: userInfo),
                const CallRoute(),
                MessageRoute(userInfo: userInfo),
                const SettingRoute(),
              ],
              backgroundColor: AppColors.white,
              bottomNavigationBuilder: (_, tabsRouter) {
                return SizedBox(
                  height: 90,
                  child: BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    elevation: 0,
                    currentIndex: tabsRouter.activeIndex,
                    onTap: tabsRouter.setActiveIndex,
                    selectedItemColor: AppColors.green,
                    items: [
                      BottomNavigationBarItem(
                        label: '',
                        icon: SvgPicture.asset(
                          'assets/icons/status.svg',
                        ),
                        activeIcon: SvgPicture.asset(
                          'assets/icons/status.svg',
                          color: AppColors.green,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: '',
                        icon: SvgPicture.asset(
                          'assets/icons/call.svg',
                        ),
                        activeIcon: SvgPicture.asset(
                          'assets/icons/call.svg',
                          color: AppColors.green,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: '',
                        icon: SvgPicture.asset(
                          'assets/icons/chats.svg',
                        ),
                        activeIcon: SvgPicture.asset(
                          'assets/icons/chats.svg',
                          color: AppColors.green,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: '',
                        icon: SvgPicture.asset(
                          'assets/icons/setting.svg',
                        ),
                        activeIcon: SvgPicture.asset(
                          'assets/icons/setting.svg',
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return const Scaffold();
        }
      },
    );
  }
}
