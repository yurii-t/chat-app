// ignore_for_file: prefer-single-widget-per-file

import 'dart:io';

import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.type,
    required this.time,
    this.text,
    this.seen,
    this.downloaded,
    this.error = false,
    Key? key,
  }) : super(key: key);
  final MessageBubbleType type;
  final String time; //DateTime...
  final String? text;
  final bool? seen;
  final bool? downloaded;
  final bool error;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double maxBubbleWidth = constraints.maxWidth * 0.7;

      return Align(
        alignment: (type == MessageBubbleType.sendMessage ||
                type == MessageBubbleType.sendImage ||
                type == MessageBubbleType.sendDoc)
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: !error
            ? buildMessageBubble(
                maxBubbleWidth,
                Colors.transparent,
              )
            : GestureDetector(
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
                                SvgPicture.asset('assets/icons/resend.svg'),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Resend',
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
                                SvgPicture.asset('assets/icons/delete.svg'),
                                const SizedBox(
                                  width: 12,
                                ),
                                const Text(
                                  'Delete',
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buildMessageBubble(
                      maxBubbleWidth,
                      Colors.red,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SvgPicture.asset('assets/icons/error.svg'),
                  ],
                ),
              ),
      );
    });
  }

  // ignore: long-method
  Widget buildMessageBubble(
    double maxWidth,
    Color errorBorder,
  ) {
    switch (type) {
      case MessageBubbleType.sendMessage:
        {
          return MessageContainer(
            text: text,
            time: '12:00',
            maxWidth: maxWidth,
            color: AppColors.green,
            messageColor: AppColors.white,
            timeColor: AppColors.white,
            border: BorderRadius.circular(16),
            seen: seen,
            errorBorder: errorBorder,
          );
        }
      case MessageBubbleType.reciveMessage:
        {
          return MessageContainer(
            text: text,
            time: '12:00',
            maxWidth: maxWidth,
            color: AppColors.lightGrey,
            messageColor: Colors.black,
            timeColor: AppColors.numberPhoneTextGrey,
            border: const BorderRadius.only(
              topLeft: Radius.circular(19),
              topRight: Radius.circular(19),
              bottomRight: Radius.circular(19),
            ),
          );
        }
      case MessageBubbleType.sendImage:
        {
          return ImageCotainer(
            color: AppColors.green,
            border: BorderRadius.circular(16),
            errorBorder: errorBorder,
          );
        }

      case MessageBubbleType.reciveImage:
        {
          return const ImageCotainer(
            color: AppColors.lightGrey,
            border: BorderRadius.only(
              topLeft: Radius.circular(19),
              topRight: Radius.circular(19),
              bottomRight: Radius.circular(19),
            ),
            // width: maxWidth,
          );
        }
      case MessageBubbleType.sendDoc:
        {
          return DocContainer(
            color: AppColors.green,
            time: time,
            textColor: AppColors.white,
            subTextColor: AppColors.white,
            border: BorderRadius.circular(16),
            downloaded: true,
            errorBorder: errorBorder,
          );
        }
      case MessageBubbleType.reciveDoc:
        {
          return DocContainer(
            color: AppColors.lightGrey,
            time: time,
            textColor: Colors.black,
            subTextColor: AppColors.numberPhoneTextGrey,
            border: const BorderRadius.only(
              topLeft: Radius.circular(19),
              topRight: Radius.circular(19),
              bottomRight: Radius.circular(19),
            ),
            downloaded: downloaded,
          );
        }
    }
  }
}

class DocContainer extends StatelessWidget {
  const DocContainer({
    required this.color,
    required this.time,
    required this.textColor,
    required this.subTextColor,
    required this.border,
    this.downloaded,
    this.errorBorder,
    Key? key,
  }) : super(key: key);
  final Color color;
  final BorderRadius border;
  final String time;
  final Color textColor;
  final Color subTextColor;
  final bool? downloaded;
  final Color? errorBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: border,
        border: Border.all(color: errorBorder ?? Colors.transparent),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: downloaded == true
            ? SvgPicture.asset('assets/icons/open_doc.svg')
            : SvgPicture.asset('assets/icons/download_doc.svg'),
        title: Text(
          'Document Name.doc',
          style: TextStyle(
            fontSize: 15,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                '12 Kb',
                style: TextStyle(
                  fontSize: 12,
                  color: subTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              '$time',
              style: TextStyle(
                fontSize: 12,
                color: subTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageCotainer extends StatelessWidget {
  final Color color;
  final BorderRadius border;
  final Color? errorBorder;

  const ImageCotainer({
    required this.color,
    required this.border,
    this.errorBorder,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.3,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: border,
            border: Border.all(color: errorBorder ?? Colors.transparent),
            // image:
          ),
        ),
      ),
    );
  }
}

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    required this.time,
    this.text,
    this.color,
    this.border,
    this.messageColor,
    this.timeColor,
    this.timeChecsRow,
    this.maxWidth,
    this.seen,
    this.errorBorder,
    Key? key,
  }) : super(key: key);
  final Color? color;
  final BorderRadius? border;
  final Color? messageColor;
  final Color? timeColor;
  final Widget? timeChecsRow;
  final double? maxWidth;
  final String? text;
  final String time;
  final bool? seen;
  final Color? errorBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? 0.7,
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: color ?? AppColors.green,
        borderRadius: border ?? BorderRadius.circular(16),
        border: Border.all(color: errorBorder ?? Colors.transparent),
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$text  ',
                    style: TextStyle(
                      fontSize: 14,
                      color: messageColor ?? AppColors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const TextSpan(
                    text: '00:00', //time
                    style: TextStyle(
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //real additionalInfo
          Positioned(
            right: 0,
            bottom: 0,
            child: Row(
              children: [
                Text(
                  '$time  ',
                  style: TextStyle(
                    fontSize: 10,
                    color: timeColor ?? AppColors.numberPhoneTextGrey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                seen == true
                    ? SvgPicture.asset('assets/icons/message_checks.svg')
                    : const Text(''),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum MessageBubbleType {
  sendMessage,
  reciveMessage,
  sendImage,
  reciveImage,
  sendDoc,
  reciveDoc
}
