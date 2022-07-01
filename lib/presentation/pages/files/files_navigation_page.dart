import 'package:auto_route/auto_route.dart';
import 'package:chat_app/routes/app_router.gr.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilesNavigationPage extends StatelessWidget {
  const FilesNavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: const [
        MediaRoute(),
        FilesRoute(),
      ],
      builder: (context, child, controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => context.router.pop(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/chevron_left.svg'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Marren Margo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SvgPicture.asset('assets/icons/media.svg'),
              ],
            ),
            bottom: TabBar(
              labelColor: AppColors.green,
              unselectedLabelColor: AppColors.lightGreytextFieldSearchHintText,
              indicatorColor: AppColors.green,
              indicatorSize: TabBarIndicatorSize.label,
              controller: controller,
              tabs: const [
                Tab(
                  child: Text(
                    'Media',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Files',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
