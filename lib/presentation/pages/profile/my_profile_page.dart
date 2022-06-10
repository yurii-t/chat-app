import 'package:auto_route/auto_route.dart';
import 'package:chat_app/presentation/widgets/custom_appbar.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        widgetleft: GestureDetector(
          onTap: () => context.router.pop(),
          child: SvgPicture.asset('assets/icons/arrow_left.svg'),
        ),
        widgetCenter: const Text(
          'My profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        widgetRight: GestureDetector(
          onTap: () {
            showModalBottomSheet<Widget?>(
              useRootNavigator: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 40,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const SizedBox(
                      //   height: 40,
                      // ),
                      const Text(
                        'Save changes?',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => context.router.pop(),
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(166, 45),
                                elevation: null,
                                side: const BorderSide(color: AppColors.green),
                                primary: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Quit',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => context.router.pop(),
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(166, 45),
                                elevation: null,
                                primary: AppColors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const Text(
            'Save',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.green,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(
              height: 32,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet<Widget?>(
                  useRootNavigator: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        // right: 16,
                        top: 35,
                        bottom: 50,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/camera.svg'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Take a Photo',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/library.svg'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Choose from Library',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: CircleAvatar(
                radius: 45,
                backgroundColor: AppColors.lightGrey,
                child: SvgPicture.asset('assets/icons/camera.svg'),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: const [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      hintStyle: TextStyle(color: AppColors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                      hintStyle: TextStyle(color: AppColors.grey),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Phone',
                hintStyle: TextStyle(color: AppColors.grey),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Address',
                hintStyle: TextStyle(color: AppColors.grey),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Gender',
                hintStyle: TextStyle(color: AppColors.grey),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Marital Status',
                hintStyle: TextStyle(color: AppColors.grey),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Prefer Language',
                hintStyle: TextStyle(color: AppColors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
