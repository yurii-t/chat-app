import 'package:auto_route/auto_route.dart';
import 'package:chat_app/domain/entities/message_entity.dart';

import 'package:chat_app/presentation/bloc/user/bloc/user_bloc.dart';
import 'package:chat_app/presentation/pages/profile/widgets/profile_list_tile.dart';
import 'package:chat_app/routes/app_router.gr.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  final List<MessageEntity> allMessages;
  final String userid;
  const ProfilePage({
    required this.allMessages,
    required this.userid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is UserLoaded) {
          final userInfo = state.allUsers.firstWhere(
            (user) => user.userId == userid,
          );

          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.42,
                  color: AppColors.white,
                  child: userInfo.userImage != ''
                      ? Image.network(
                          userInfo.userImage,
                          fit: BoxFit.fill,
                        )
                      : SvgPicture.asset('assets/icons/media.svg'),
                ),
                GestureDetector(
                  onTap: () => context.router.pop(),
                  child: Container(
                    margin: const EdgeInsets.only(top: 41, left: 14),
                    width: 99,
                    height: 33,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(26)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/chevron_left.svg'),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Message',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.65,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: ListView(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userInfo.userName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    userInfo.userPhone,
                                    style: const TextStyle(
                                      color: AppColors.numberPhoneTextGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset('assets/icons/message.svg'),
                                const SizedBox(
                                  width: 15,
                                ),
                                SvgPicture.asset('assets/icons/video.svg'),
                                const SizedBox(
                                  width: 15,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/call_elipse.svg',
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Status',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              userInfo.userMartialStatus,
                              style: const TextStyle(
                                color: AppColors.numberPhoneTextGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ProfileListTile(
                          tap: () => context.router.push(FilesNavigationRoute(
                            allMessages: allMessages,
                            recipientName: userInfo.userName,
                            recipientPhoto: userInfo.userImage,
                          )),
                          image: SvgPicture.asset('assets/icons/media.svg'),
                          title: 'Media, Links and Docs',
                          textTrailing: '130',
                        ),
                        ProfileListTile(
                          image: SvgPicture.asset('assets/icons/starred.svg'),
                          title: 'Starred Messages',
                          textTrailing: '2',
                        ),
                        ProfileListTile(
                          image: SvgPicture.asset('assets/icons/search.svg'),
                          title: 'Chat Search',
                          textTrailing: '',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ProfileListTile(
                          image: SvgPicture.asset('assets/icons/mute.svg'),
                          title: 'Mute',
                          textTrailing: 'No',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const Text('error');
      },
    );
  }
}
