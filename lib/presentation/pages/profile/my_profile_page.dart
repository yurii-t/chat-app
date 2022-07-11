// ignore_for_file: always_put_control_body_on_new_line

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/presentation/bloc/current_user/bloc/current_user_bloc.dart';
import 'package:chat_app/presentation/widgets/custom_appbar.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final adressController = TextEditingController();
  final genderController = TextEditingController();
  final martialController = TextEditingController();
  final languageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  UserModel? userId;
  File? image;

  Future pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future takePhoto() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    adressController.dispose();
    genderController.dispose();
    martialController.dispose();
    languageController.dispose();
    super.dispose();
  }

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
                              onPressed: () {
                                final pickedImage = File(image?.path ?? '');
                                context.read<CurrentUserBloc>().add(CreateUser(
                                      '${firstNameController.text} ${lastNameController.text}',
                                      pickedImage,
                                      adressController.text,
                                      genderController.text,
                                      martialController.text,
                                      languageController.text,
                                    ));
                                context.router.pop();
                              },
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
      body: BlocBuilder<CurrentUserBloc, CurrentUserState>(
        builder: (context, state) {
          if (state is CurrentUserLoading) {
            return const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is CurrentUserLoaded) {
            return Padding(
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
                                GestureDetector(
                                  onTap: takePhoto,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/camera.svg',
                                      ),
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
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    pickImage();
                                    print('tap');
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/library.svg',
                                      ),
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
                      backgroundImage: state.usersInfo.userImage != ''
                          ? NetworkImage(
                              state.usersInfo.userImage,
                            )
                          : null,
                      child: SvgPicture.asset('assets/icons/camera.svg'),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            hintText: state.usersInfo.userName.split(' ').first,
                            hintStyle: const TextStyle(color: AppColors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                            hintText: state.usersInfo.userName.split(' ').last,
                            hintStyle: const TextStyle(color: AppColors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: '${state.usersInfo.userPhone}',
                      hintStyle: const TextStyle(color: AppColors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: adressController,
                    decoration: InputDecoration(
                      hintText: state.usersInfo.userAddress,
                      hintStyle: const TextStyle(color: AppColors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: genderController,
                    decoration: InputDecoration(
                      hintText: state.usersInfo.userGender,
                      hintStyle: const TextStyle(color: AppColors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: martialController,
                    decoration: InputDecoration(
                      hintText: state.usersInfo.userMartialStatus,
                      hintStyle: const TextStyle(color: AppColors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: languageController,
                    decoration: InputDecoration(
                      hintText: state.usersInfo.userPreferLanguage,
                      hintStyle: const TextStyle(color: AppColors.grey),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
