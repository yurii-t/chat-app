import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:chat_app/presentation/bloc/chat/bloc/chat_interaction_bloc.dart';
import 'package:chat_app/presentation/bloc/file_interaction/bloc/file_interaction_bloc.dart';
import 'package:chat_app/presentation/pages/chat/widgets/message_bubble.dart';
import 'package:chat_app/presentation/widgets/custom_appbar.dart';
import 'package:chat_app/routes/app_router.gr.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ChatPage extends StatefulWidget {
  final String senderUid;
  final String recipientUid;
  final String senderName;
  final String recipientName;
  final String recipientPhoneNumber;
  final String senderPhoneNumber;
  const ChatPage({
    required this.senderUid,
    required this.recipientUid,
    required this.senderName,
    required this.recipientName,
    required this.recipientPhoneNumber,
    required this.senderPhoneNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class DownloadingProgress {
  final String id;
  final double progress;

  DownloadingProgress(this.id, this.progress);
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? image;
  String? imageName;
  num? imageSize;
  PlatformFile? pickedFile;

  List<DownloadingProgress> progresses = [];
  double dowProgress = 0;
  String progressString = '';
  bool fileDownloaded = false;
  bool downloading = false;
  String? downloadedPath;

  @override
  void initState() {
    context
        .read<ChatInteractionBloc>()
        .add(ChatInteractionsLoad(widget.senderUid, widget.recipientUid));
    super.initState();

    _textController.addListener(() {
      setState(() {});
    });
  }

  Future pickFile() async {
    try {
      final file = await FilePicker.platform.pickFiles();
      if (file == null) return;

      setState(() => this.pickedFile = file.files.first);
    } on PlatformException catch (e) {
      print('Failed to pick file: $e');
    }
  }

  // Future downloadFile(String url) async {
  //   final tempDir = await getTemporaryDirectory();
  //   final path = '${tempDir.path}/${url}';
  //   // final Directory appDocDir = await getApplicationDocumentsDirectory();
  //   // final path = '${appDocDir.path}/${url}';
  //   downloadedPath = path;
  //   print('PATH $path');
  //   File(path).exists();

  //   try {
  //     await Dio().download(url, path, onReceiveProgress: (recived, total) {
  //       double progress = recived / total;
  //       setState(() {
  //         dowProgress = progress;
  //         if (progress >= 1) {
  //           fileDownloaded = true;
  //           downloading = false;
  //         } else {
  //           progressString =
  //               '${(progress * 100).toStringAsFixed(0)}% downloaded';
  //           downloading = true;
  //         }
  //         //        final kb = file.size / 1024;
  //         // final mb = kb / 1024;
  //         // final size  = (mb>=1)?'${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
  //       });
  //     });
  //   } on DioError catch (e) {
  //     print(e.message);
  //   }
  // }

  // void openFile(PlatformFile? file) {
  //   OpenFile.open(file?.path);
  // }
  void openFile(String? file) {
    print(file);
    // OpenFile.open(file);
  }

  Future pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);
      final imageSizeTmp = imageTemp.readAsBytesSync().lengthInBytes;

      setState(() {
        this.image = imageTemp;
        this.imageSize = imageSizeTmp;
      });
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
    _textController
      ..removeListener(() {})
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatInteractionBloc, ChatInteractionState>(
      builder: (context, state) {
        if (state is ChatInteractionLoading) {
          return const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is ChatInteractionLoaded) {
          return Scaffold(
            appBar: CustomAppBar(
              widgetleft: GestureDetector(
                onTap: () => context.router.pop(),
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
              widgetCenter: GestureDetector(
                onTap: () => context.router.push(ProfileRoute()),
                child: const Text(
                  'Marren Margo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              widgetRight: GestureDetector(
                  onTap: () => context.router.push(ProfileRoute()),
                  child: SvgPicture.asset('assets/icons/media.svg')),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
              child: Column(
                children: [
                  Expanded(
                    child: state.messages.isEmpty
                        ? const Center(
                            child: const Text(
                              'No message here yet.',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color:
                                    AppColors.lightGreytextFieldSearchHintText,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.messages.length,
                            itemBuilder: (context, index) {
                              final messagesData = state.messages[index];
                              final bool sender =
                                  widget.senderUid == messagesData.sederUid;

                              if (messagesData.messageType == 'image') {
                                return MessageBubble(
                                  type: sender
                                      ? MessageBubbleType.sendImage
                                      : MessageBubbleType.reciveImage,
                                  text: messagesData.message,
                                  time: DateFormat('hh:mm a')
                                      .format(messagesData.time.toDate()),
                                );
                              } else if (messagesData.messageType == 'file') {
                                return GestureDetector(
                                  onTap: () {
                                    if (!sender) {
                                      context.read<FileInteractionBloc>().add(
                                          FileInteractionDownloading(
                                              messagesData.message));
                                    } else
                                      openFile(downloadedPath);

                                    // (!sender && fileDownloaded == false)
                                    //     ? downloadFile(messagesData.message)
                                    //     : openFile(downloadedPath ?? '');
                                    // fileDownloaded == true
                                    //     ? openFile(downloadedPath ?? '')
                                    //     : null;
                                    // openFile(pickedFile!);
                                  },
                                  // child: BlocListener<FileInteractionBloc,
                                  //     FileInteractionState>(
                                  //   listener: (context, state) {
                                  //     if (state
                                  //         is FileInteractionProgressDownloading) {
                                  //       progressString =
                                  //           state.downloadProgress.toString();
                                  //       dowProgress =
                                  //           state.downloadProgress.toDouble();
                                  //     }
                                  //   },
                                  // return
                                  child: BlocBuilder<FileInteractionBloc,
                                      FileInteractionState>(
                                    builder: (context, state) {
                                      if (state
                                          is FileInteractionProgressDownloading) {
                                        Column(
                                          children: [
                                            CircularProgressIndicator(
                                              value: state.downloadProgress
                                                  .toDouble(),
                                            ),
                                          ],
                                        );
                                        // dowProgress =
                                        //     state.downloadProgress.toDouble();
                                        // progressString =
                                        //     '${(state.downloadProgress * 100).toStringAsFixed(0)}% downloaded';
                                        return MessageBubble(
                                          downloaded: false, // fileDownloaded,
                                          docSize: messagesData.docSize
                                              .toString(), //pickedFile?.size.toString(),
                                          downloading: true, //downloading,
                                          downloadString:
                                              // state.downloadProgress
                                              //     .toString(),
                                              progressString,
                                          downloadValue:

                                              // state.downloadProgress,
                                              dowProgress,
                                          type: sender
                                              ? MessageBubbleType.sendDoc
                                              : MessageBubbleType.reciveDoc,
                                          text: messagesData
                                              .docName, // messagesData.message,
                                          time: DateFormat('hh:mm a').format(
                                              messagesData.time.toDate()),
                                        );
                                      }

                                      // return MessageBubble(
                                      //   downloaded: false, // fileDownloaded,
                                      //   docSize: messagesData.docSize
                                      //       .toString(), //pickedFile?.size.toString(),
                                      //   downloading: true, //downloading,
                                      //   downloadString:
                                      //       // state.downloadProgress
                                      //       //     .toString(),
                                      //       progressString,
                                      //   downloadValue:

                                      //       // state.downloadProgress,
                                      //       dowProgress,
                                      //   type: sender
                                      //       ? MessageBubbleType.sendDoc
                                      //       : MessageBubbleType.reciveDoc,
                                      //   text: messagesData
                                      //       .docName, // messagesData.message,
                                      //   time: DateFormat('hh:mm a')
                                      //       .format(messagesData.time.toDate()),

                                      // );
                                      return Text('error');
                                    },
                                  ),
                                );
                              }

                              return MessageBubble(
                                type: sender
                                    ? MessageBubbleType.sendMessage
                                    : MessageBubbleType.reciveMessage,
                                text: messagesData.message,
                                time: DateFormat('hh:mm a')
                                    .format(messagesData.time.toDate()),
                              );
                            },
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
                                    GestureDetector(
                                      onTap: () {
                                        // var tmp;
                                        pickImage().whenComplete(
                                          () {
                                            if (image != null) {
                                              return context
                                                  .read<ChatInteractionBloc>()
                                                  .add(
                                                    ChatInteractionsUploadImage(
                                                      image!,
                                                      widget.senderUid,
                                                      widget.senderName,
                                                      widget.senderPhoneNumber,
                                                      widget.recipientUid,
                                                      widget.recipientName,
                                                      widget
                                                          .recipientPhoneNumber,
                                                      '',
                                                      'image',
                                                      imageSize.toString(),
                                                      imageName ?? 'image name',
                                                    ),
                                                  );
                                            }

                                            return;
                                          },
                                        );

                                        // context.read<ChatInteractionBloc>().add(
                                        //       ChatInteractionsUploadImage(
                                        //         widget.senderUid,
                                        //         widget.recipientUid,
                                        //         image!,
                                        //       ),
                                        //     );
                                        print(' tap image upload');
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/photo.svg'),
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
                                    ),
                                    const SizedBox(
                                      height: 26,
                                    ),
                                    BlocBuilder<FileInteractionBloc,
                                        FileInteractionState>(
                                      builder: (context, state) {
                                        return state
                                                is FileInteractionProgressUploading
                                            ? Column(
                                                children: [
                                                  CircularProgressIndicator(
                                                    value: state.progress
                                                        .toDouble(),
                                                  ),
                                                  Text(
                                                      '${(state.progress * 100).toStringAsFixed(0)}% uploaded'),
                                                ],
                                              )
                                            //'${(progress * 100).toStringAsFixed(0)}% downloaded';
                                            : Text('no progress');
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        final double kb =
                                            (pickedFile?.size ?? 0) / 1024;
                                        final double mb = kb / 1024;
                                        final String size = (mb >= 1)
                                            ? '${mb.toStringAsFixed(2)} MB'
                                            : '${kb.toStringAsFixed(2)} KB';
                                        print('File ${pickedFile?.size}');
                                        print('SIZE $size');
                                        pickFile().whenComplete(() {
                                          context
                                              .read<FileInteractionBloc>()
                                              .add(
                                                FileInteractionUploadFile(
                                                  File(pickedFile?.path ?? ''),
                                                  widget.senderUid,
                                                  widget.senderName,
                                                  widget.senderPhoneNumber,
                                                  widget.recipientUid,
                                                  widget.recipientName,
                                                  widget.recipientPhoneNumber,
                                                  '',
                                                  'file',
                                                  size,
                                                  // pickedFile?.size.toDouble() ??
                                                  //     0,
                                                  pickedFile?.name ??
                                                      'document name loading,..',
                                                ),
                                              );
                                          // context
                                          //     .read<FileInteractionBloc>()
                                          //     .add(FileInteractionUploading(
                                          //       widget.senderUid,
                                          //       widget.recipientUid,
                                          //       File(pickedFile?.path ?? ''),
                                          //     ));
                                          // var fileState = context
                                          //     .watch<FileInteractionBloc>()
                                          //     .state;
                                          // if (fileState
                                          //     is FileInteractionProgressUploading) {
                                          //   print(fileState.progress);
                                          //   //   // return CircularProgressIndicator(

                                          //   //   //   value: fileState!.progress
                                          //   //   //       .toDouble(),
                                          //   //   // );
                                          // }
                                        });
                                        // var fileState = context
                                        //     .read<FileInteractionBloc>()
                                        //     .state;
                                        // if (fileState
                                        //     is FileInteractionProgressUploading) {
                                        //   print(
                                        //       'PROGRESS ${fileState.progress}');
                                        // }

                                        var tmp = File(pickedFile?.path ?? '');
                                        print('PATh $tmp');
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/file.svg'),
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
                        onTap: () {
                          context.read<ChatInteractionBloc>().add(
                                ChatInteractionsSendMessage(
                                  senderId: widget.senderUid,
                                  senderName: widget.senderName,
                                  senderPhoneNumber: widget.senderPhoneNumber,
                                  recipientId: widget.recipientUid,
                                  recipientName: widget.recipientName,
                                  recipientPhoneNumber:
                                      widget.recipientPhoneNumber,
                                  message: _textController.text,
                                  messageType: 'Text',
                                ),
                              );
                          _textController.clear();
                        },
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

        return Text('error');
      },
    );
  }
}
