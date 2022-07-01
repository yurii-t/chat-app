import 'package:auto_route/auto_route.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/presentation/bloc/chat/bloc/chat_interaction_bloc.dart';
import 'package:chat_app/presentation/bloc/messages/bloc/active_chats_bloc.dart';
import 'package:chat_app/presentation/widgets/custom_appbar.dart';
import 'package:chat_app/routes/app_router.gr.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:flutter_svg/flutter_svg.dart';

class MessagePage extends StatelessWidget {
  final UserEntity userInfo;
  const MessagePage({
    required this.userInfo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: CustomAppBar(
        widgetleft: GestureDetector(
          child: SvgPicture.asset('assets/icons/camera.svg'),
        ),
        widgetCenter: const Text(
          'Message',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        widgetRight: GestureDetector(
          onTap: () => context.router.push(const MyProfileRoute()),
          child: const Text(
            'My profile',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),

      body: BlocBuilder<ActiveChatsBloc, ActiveChatsState>(
        builder: (context, state) {
          if (state is ActiveChatsError) {
            print(state.error);
          }
          if (state is ActiveChatsLoading) {
            return const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is ActiveChatsLoaded) {
            return state.chats.isEmpty
                ? const Center(
                    child: Text('No mesages yet'),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                        thickness: 2,
                      );
                    },
                    itemCount: state.chats.length,
                    itemBuilder: (context, index) {
                      final chatsData = state.chats[index];

                      return Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          extentRatio: 0.7,
                          motion: ScrollMotion(),
                          children: [
                            CustomSlidableAction(
                              onPressed: null,
                              backgroundColor: AppColors.green,
                              foregroundColor: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/unread.svg'),
                                  const SizedBox(height: 8),
                                  const Text('Unread'),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: 1,
                              color: AppColors.green,
                              child: Center(
                                child: Container(
                                  width: 1,
                                  height: 40,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ),
                            CustomSlidableAction(
                              onPressed: null,
                              backgroundColor: AppColors.green,
                              foregroundColor: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/pin.svg'),
                                  const SizedBox(height: 8),
                                  const Text('Pin'),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: 1,
                              color: AppColors.green,
                              child: Center(
                                child: Container(
                                  width: 1,
                                  height: 40,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ),
                            CustomSlidableAction(
                              padding: EdgeInsets.only(top: 10),
                              onPressed: null,
                              backgroundColor: AppColors.green,
                              foregroundColor: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/more.svg'),
                                  const SizedBox(height: 16),
                                  const Text('More'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            // context.read<ChatInteractionBloc>().add(ChatInte)
                            context.router.push(ChatRoute(
                                senderUid: userInfo.userId,
                                senderName: chatsData.senderName,
                                senderPhoneNumber: chatsData.senderPhoneNumber,
                                recipientUid: chatsData.recepientUid,
                                recipientName: chatsData.recepientName,
                                recipientPhoneNumber:
                                    chatsData.recepientPhoneNumber));
                          },
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          leading: const CircleAvatar(
                            radius: 30,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    // 'User Name',
                                    chatsData.recepientName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  DateFormat('hh:mm a')
                                      .format(chatsData.time.toDate()),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  // 'Text message',
                                  chatsData.recentTextMessage,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              Container(
                                // margin: EdgeInsets.only(top: 16),
                                alignment: Alignment.center,
                                width: 22,
                                height: 22,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.green,
                                ),
                                child: const Text(
                                  '2',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              // SvgPicture.asset('assets/icons/check_marks.svg'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
