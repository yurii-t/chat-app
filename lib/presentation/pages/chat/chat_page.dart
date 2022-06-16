import 'package:chat_app/presentation/pages/chat/widgets/message_bubble.dart';
import 'package:chat_app/presentation/widgets/custom_appbar.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textController
      ..removeListener(() {})
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        widgetleft: Row(
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
        widgetCenter: const Text(
          'Marren Margo',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        widgetRight: SvgPicture.asset('assets/icons/media.svg'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
        child: Column(
          children: [
            Expanded(
              child:
                  // const Center(
                  //   child: const Text(
                  //     'No message here yet.',
                  //     style: TextStyle(
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.w500,
                  //       color: AppColors.lightGreytextFieldSearchHintText,
                  //     ),
                  //   ),
                  // ),
                  ListView(
                padding: EdgeInsets.only(bottom: 10),
                reverse: false,
                children: const [
                  MessageBubble(
                    type: MessageBubbleType.sendMessage,
                    time: '13:00',
                    text: "hello",
                  ),
                  MessageBubble(
                    type: MessageBubbleType.reciveMessage,
                    time: '13:00',
                    text: "hello",
                  ),
                  MessageBubble(
                    type: MessageBubbleType.sendMessage,
                    time: '13:00',
                    text: "hellodas da  adsss",
                    seen: true,
                  ),
                  MessageBubble(
                    type: MessageBubbleType.sendMessage,
                    time: '13:00',
                    text: "hellodas da  ads",
                  ),
                  MessageBubble(
                    type: MessageBubbleType.reciveMessage,
                    time: '13:00',
                    text: "hello",
                  ),
                  MessageBubble(
                    type: MessageBubbleType.sendMessage,
                    time: '13:00',
                    text:
                        "hellodas da  ads,m g,.mr ,r.em.,egmg.rmklwemkl mwekn ",
                    error: true,
                  ),
                  MessageBubble(
                    type: MessageBubbleType.reciveMessage,
                    time: '13:00',
                    text:
                        "hello dasd a dasd dasda apod kpoaskd poka apko spk das dasm aksm sakma mdas j njknjkn ekjkjwr anjkn waj rasdasasdasdadasdaddddddddddddd dddddddddddddddddddddddddddddddddddddddddddddd",
                  ),
                  MessageBubble(
                    type: MessageBubbleType.sendDoc,
                    time: '13:00',
                  ),
                  MessageBubble(
                    type: MessageBubbleType.reciveDoc,
                    time: '13:00',
                  ),
                  MessageBubble(
                      type: MessageBubbleType.sendImage, time: '13:00'),
                  MessageBubble(
                      type: MessageBubbleType.reciveImage, time: '13:00'),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                                  SvgPicture.asset('assets/icons/photo.svg'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'Photo of Video',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 26,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/icons/file.svg'),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  const Text(
                                    'File',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
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
                  child: SvgPicture.asset('assets/icons/attach.svg'),
                ),
                SizedBox(
                  child: TextField(
                    controller: _textController,
                    minLines: 1,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 8,
                        bottom: 8,
                      ),
                      filled: true,
                      fillColor: AppColors.lightGrey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Message',
                      constraints: BoxConstraints(
                        minHeight: 35,
                        // maxHeight: 35,
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                        minWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      helperStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lightGreytextFieldSearchHintText,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: _textController.text.isNotEmpty
                      ? SvgPicture.asset('assets/icons/send.svg')
                      : SvgPicture.asset('assets/icons/send_empty.svg'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
