import 'package:auto_route/auto_route.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/presentation/bloc/auth_status/bloc/auth_status_bloc.dart';
import 'package:chat_app/presentation/bloc/user/bloc/user_bloc.dart';
import 'package:chat_app/routes/app_router.gr.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  // final UserEntity userInfo;
  final String userId;
  const HomePage({
    // required this.userInfo,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final authBlocState = context.watch<AuthStatusBloc>().state;

        if (state is UserLoaded && authBlocState is Authenticated) {
          final userInfo = state.allUsers.firstWhere(
            (user) => user.userId == userId, //authBlocState.uid,
          );

          return AutoTabsScaffold(
            routes: [
              // HomeRoute(),
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
                        // color: Colors.red,
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/status.svg',
                        color: AppColors.green,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: '',
                      // icon: Icon(Icons.ac_unit_sharp),
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
                        // color: Colors.red,
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
                        // color: BottomNavigationBar ? Colors.red : Colors.amber,
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
          );
        } else {
          return Scaffold();
        }
      },
    );
  }
}
