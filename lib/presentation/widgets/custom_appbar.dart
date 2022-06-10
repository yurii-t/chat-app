import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.widgetleft,
    required this.widgetCenter,
    required this.widgetRight,
    Key? key,
  }) : super(key: key);
  final Widget widgetleft;
  final Widget widgetCenter;
  final Widget widgetRight;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widgetleft,
          // GestureDetector(
          //   child: SvgPicture.asset('assets/icons/camera.svg'),
          // ),
          widgetCenter,
          // const Text(
          //   'Message',
          //   style: TextStyle(
          //     fontSize: 18,
          //     fontWeight: FontWeight.w400,
          //     color: Colors.black,
          //   ),
          // ),
          widgetRight,
          // GestureDetector(
          //   child: const Text(
          //     'My profile',
          //     style: TextStyle(
          //       fontSize: 15,
          //       fontWeight: FontWeight.w400,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
