// ignore_for_file: prefer-single-widget-per-file, use_if_null_to_convert_nulls_to_bools

import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:just_waveform/just_waveform.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.type,
    required this.time,
    required this.error,
    required this.seen,
    this.text,
    this.downloaded,
    this.docSize,
    this.downloading,
    this.downloadValue,
    this.downloadString,
    this.uploadValue,
    this.uploadString,
    this.url,
    this.isPlaying,
    this.audioWaveform,
    this.audioWaveformDuration,
    this.start,
    this.audioProgress,
    this.audioWaveWidget,
    Key? key,
  }) : super(key: key);
  final MessageBubbleType type;
  final String time;
  final String? text;
  final bool seen;
  final bool? downloaded;
  final bool error;
  final String? docSize;
  final bool? downloading;
  final num? downloadValue;
  final String? downloadString;
  final num? uploadValue;
  final String? uploadString;
  final String? url;
  final bool? isPlaying;
  final Waveform? audioWaveform;
  final Duration? audioWaveformDuration;
  final Duration? start;
  final Duration? audioProgress;
  final Widget? audioWaveWidget;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double maxBubbleWidth = constraints.maxWidth * 0.7;

      return Align(
        alignment: (type == MessageBubbleType.sendMessage ||
                    type == MessageBubbleType.sendImage ||
                    type == MessageBubbleType.sendDoc) ||
                type == MessageBubbleType.sendDocError ||
                type == MessageBubbleType.sendAudio
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
            time: time,
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
            time: time,
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
            imageUrl: text,
            color: AppColors.green,
            border: BorderRadius.circular(16),
            errorBorder: errorBorder,
          );
        }

      case MessageBubbleType.reciveImage:
        {
          return ImageCotainer(
            imageUrl: text,
            color: AppColors.lightGrey,
            border: const BorderRadius.only(
              topLeft: Radius.circular(19),
              topRight: Radius.circular(19),
              bottomRight: Radius.circular(19),
            ),
          );
        }
      case MessageBubbleType.sendDoc:
        {
          return DocContainerSend(
            seen: seen,
            docName: text ?? 'doc',
            docSize: docSize ?? '',
            color: AppColors.green,
            time: time,
            textColor: AppColors.white,
            subTextColor: AppColors.white,
            border: BorderRadius.circular(16),
            errorBorder: errorBorder,
            uploadValue: uploadValue ?? 0,
            uploadString: uploadString ?? '',
          );
        }
      case MessageBubbleType.reciveDoc:
        {
          return DocContainerRecive(
            docName: text ?? 'doc',
            docSize: docSize ?? '',
            color: AppColors.lightGrey,
            time: time,
            textColor: Colors.black,
            subTextColor: AppColors.numberPhoneTextGrey,
            border: const BorderRadius.only(
              topLeft: Radius.circular(19),
              topRight: Radius.circular(19),
              bottomRight: Radius.circular(19),
            ),
            downloadValue: downloadValue ?? 0,
            downloadString: downloadString ?? '',
          );
        }
      case MessageBubbleType.sendDocError:
        {
          return DocContainerSendError(
            seen: seen,
            docName: text ?? 'doc',
            docSize: docSize ?? '',
            color: AppColors.green,
            time: time,
            textColor: AppColors.white,
            subTextColor: AppColors.white,
            border: BorderRadius.circular(16),
            errorBorder: Colors.red,
            uploadValue: uploadValue ?? 0,
            uploadString: uploadString ?? '',
          );
        }
      case MessageBubbleType.sendAudio:
        {
          return AudioContainer(
            audioWaveWidget: audioWaveWidget ?? const SizedBox.shrink(),
            audioProgress: audioProgress ?? Duration.zero,
            audioWaveform: audioWaveform,
            audioWaveformDuration: audioWaveformDuration,
            start: start,
            isPlaying: isPlaying,
            url: url ?? '',
            seen: seen,
            docName: text ?? 'audio message',
            docSize: docSize ?? '',
            color: AppColors.green,
            time: time,
            textColor: AppColors.white,
            subTextColor: AppColors.white,
            border: BorderRadius.circular(16),
            errorBorder: errorBorder,
            uploadValue: 0,
            uploadString: '',
          );
        }
      case MessageBubbleType.receiveAudio:
        {
          return AudioContainer(
            audioWaveWidget: audioWaveWidget ?? const SizedBox.shrink(),
            audioProgress: audioProgress ?? Duration.zero,
            audioWaveform: audioWaveform,
            audioWaveformDuration: audioWaveformDuration,
            start: start,
            isPlaying: isPlaying,
            url: url ?? '',
            docName: text ?? 'audio message',
            docSize: docSize ?? '',
            color: AppColors.lightGrey,
            time: time,
            textColor: Colors.black,
            subTextColor: AppColors.numberPhoneTextGrey,
            border: const BorderRadius.only(
              topLeft: Radius.circular(19),
              topRight: Radius.circular(19),
              bottomRight: Radius.circular(19),
            ),
            uploadValue: 0,
            uploadString: '',
          );
        }
    }
  }
}

class AudioContainer extends StatelessWidget {
  const AudioContainer({
    required this.color,
    required this.time,
    required this.textColor,
    required this.subTextColor,
    required this.border,
    required this.docSize,
    required this.docName,
    required this.uploadValue,
    required this.uploadString,
    required this.url,
    required this.audioProgress,
    required this.audioWaveWidget,
    this.seen,
    this.errorBorder,
    this.isPlaying,
    this.audioWaveform,
    this.audioWaveformDuration,
    this.start,
    Key? key,
  }) : super(key: key);
  final Color color;
  final BorderRadius border;
  final String time;
  final Color textColor;
  final Color subTextColor;
  final Color? errorBorder;
  final bool? seen;

  final String docSize;
  final String docName;
  final num uploadValue;
  final String uploadString;
  final String url;
  final bool? isPlaying;
  final Waveform? audioWaveform;
  final Duration? audioWaveformDuration;
  final Duration? start;
  final Duration audioProgress;
  final Widget audioWaveWidget;

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
        horizontalTitleGap: 3,
        minVerticalPadding: 2,
        leading: SizedBox(
          height: double.infinity,
          child: isPlaying != true
              ? SvgPicture.asset('assets/icons/play_audio.svg')
              : SvgPicture.asset('assets/icons/stop_audio.svg'),
        ),
        title: Container(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          height: 50,
          child: audioWaveWidget,
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                docSize,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.transparent,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  '$time',
                  style: TextStyle(
                    fontSize: 12,
                    color: subTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (seen == true)
                  SvgPicture.asset('assets/icons/message_checks.svg')
                else
                  const Text(''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DocContainerSend extends StatelessWidget {
  const DocContainerSend({
    required this.color,
    required this.time,
    required this.textColor,
    required this.subTextColor,
    required this.border,
    required this.docSize,
    required this.docName,
    required this.uploadValue,
    required this.uploadString,
    required this.seen,
    this.errorBorder,
    Key? key,
  }) : super(key: key);
  final Color color;
  final BorderRadius border;
  final String time;
  final Color textColor;
  final Color subTextColor;
  final Color? errorBorder;
  final bool seen;

  final String docSize;
  final String docName;
  final num uploadValue;
  final String uploadString;

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
        leading: uploadValue == 0
            ? SvgPicture.asset('assets/icons/open_doc.svg')
            : uploadValue < 1
                ? CircularProgressIndicator(
                    value: uploadValue.toDouble(),
                  )
                : SvgPicture.asset('assets/icons/open_doc.svg'),
        title: Text(
          docName,
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
                uploadValue == 0
                    ? docSize
                    : uploadValue < 1
                        ? uploadString
                        : docSize,
                style: TextStyle(
                  fontSize: 12,
                  color: subTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  '$time',
                  style: TextStyle(
                    fontSize: 12,
                    color: subTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // ignore: no-boolean-literal-compare
                if (seen == true)
                  SvgPicture.asset('assets/icons/message_checks.svg')
                else
                  const Text(''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DocContainerSendError extends StatelessWidget {
  const DocContainerSendError({
    required this.color,
    required this.time,
    required this.textColor,
    required this.subTextColor,
    required this.border,
    required this.docSize,
    required this.docName,
    required this.uploadValue,
    required this.uploadString,
    required this.seen,
    required this.errorBorder,
    Key? key,
  }) : super(key: key);
  final Color color;
  final BorderRadius border;
  final String time;
  final Color textColor;
  final Color subTextColor;
  final Color errorBorder;
  final bool seen;

  final String docSize;
  final String docName;
  final num uploadValue;
  final String uploadString;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: border,
        border: Border.all(color: errorBorder),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: SvgPicture.asset('assets/icons/open_doc.svg'),
        title: Text(
          docName,
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
                docSize,
                style: TextStyle(
                  fontSize: 12,
                  color: subTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  '$time',
                  style: TextStyle(
                    fontSize: 12,
                    color: subTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // ignore: no-boolean-literal-compare
                if (seen == true)
                  SvgPicture.asset('assets/icons/message_checks.svg')
                else
                  const Text(''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DocContainerRecive extends StatelessWidget {
  const DocContainerRecive({
    required this.color,
    required this.time,
    required this.textColor,
    required this.subTextColor,
    required this.border,
    required this.docSize,
    required this.docName,
    required this.downloadValue,
    required this.downloadString,
    this.errorBorder,
    Key? key,
  }) : super(key: key);
  final Color color;
  final BorderRadius border;
  final String time;
  final Color textColor;
  final Color subTextColor;

  final Color? errorBorder;

  final num downloadValue;
  final String downloadString;
  final String docSize;
  final String docName;

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
        leading: downloadValue == 0
            ? SvgPicture.asset('assets/icons/download_doc.svg')
            : downloadValue < 1
                ? CircularProgressIndicator(
                    value: downloadValue.toDouble(),
                  )
                : SvgPicture.asset('assets/icons/open_doc.svg'),
        title: Text(
          docName,
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
                downloadValue == 0
                    ? docSize
                    : downloadValue < 1
                        ? downloadString
                        : docSize,
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
  final String? imageUrl;

  const ImageCotainer({
    required this.color,
    required this.border,
    this.errorBorder,
    this.imageUrl,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          color: color,
          borderRadius: border,
          border: Border.all(color: errorBorder ?? Colors.transparent),
        ),
        child: Image.network(
          imageUrl ?? '',
          loadingBuilder: (context, child, loadingProgress) {
            int? expSize;
            int? dowSize;
            expSize = loadingProgress?.expectedTotalBytes;
            dowSize = loadingProgress?.cumulativeBytesLoaded;

            return expSize != null && dowSize != null
                ? Center(
                    child: CircularProgressIndicator(
                      value: dowSize / expSize,
                      color: Colors.white,
                    ),
                  )
                : child;
          },
          fit: BoxFit.fill,
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
                    text: '00:00:00',
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
                if (seen == true)
                  SvgPicture.asset('assets/icons/message_checks.svg')
                else
                  const Text(''),
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
  reciveDoc,
  sendDocError,
  sendAudio,
  receiveAudio,
}
