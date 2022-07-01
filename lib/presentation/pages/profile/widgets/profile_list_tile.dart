import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    required this.image,
    required this.title,
    required this.textTrailing,
    this.tap,
    Key? key,
  }) : super(key: key);
  final Widget image;
  final String title;
  final String textTrailing;
  final VoidCallback? tap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tap,
      contentPadding: EdgeInsets.zero,
      leading: image,
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                textTrailing,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.numberPhoneTextGrey,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              SvgPicture.asset('assets/icons/chevron_right.svg'),
            ],
          ),
        ],
      ),
    );
  }
}
