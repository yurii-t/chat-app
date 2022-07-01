import 'package:auto_route/auto_route.dart';
import 'package:chat_app/routes/app_router.gr.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        // HomeRoute(),
        StatusRoute(),
        CallRoute(),
        MessageRoute(),
        SettingRoute(),
      ],
      backgroundColor: AppColors.white,
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
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
            ),
            BottomNavigationBarItem(
              label: '',
              icon: SvgPicture.asset(
                'assets/icons/call.svg',
                // color: Colors.red,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: SvgPicture.asset(
                'assets/icons/chats.svg',
                // color: Colors.red,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: SvgPicture.asset(
                'assets/icons/setting.svg',
                // color: BottomNavigationBar ? Colors.red : Colors.amber,
              ),
            ),
          ],
        );
      },
    );
  }
}
