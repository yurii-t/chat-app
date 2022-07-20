// ignore_for_file: always_put_control_body_on_new_line

import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/presentation/bloc/audio_play/bloc/audio_play_bloc.dart';
import 'package:chat_app/presentation/bloc/audio_record/bloc/audio_record_bloc.dart';
import 'package:chat_app/presentation/bloc/audio_wave_loader/bloc/audio_wave_loader_bloc.dart';

import 'package:chat_app/presentation/bloc/chat/bloc/chat_interaction_bloc.dart';
import 'package:chat_app/presentation/bloc/file_interaction/bloc/file_interaction_bloc.dart';
import 'package:chat_app/presentation/pages/chat/widgets/audio_waveform.dart';
import 'package:chat_app/presentation/pages/chat/widgets/message_bubble.dart';
import 'package:chat_app/presentation/widgets/custom_appbar.dart';
import 'package:chat_app/routes/app_router.gr.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:open_file/open_file.dart';

class ChatPage extends StatefulWidget {
  final String senderUid;
  final String recipientUid;
  final String senderName;
  final String recipientName;
  final String recipientPhoneNumber;
  final String senderPhoneNumber;
  final String recipientImage;

  const ChatPage({
    required this.senderUid,
    required this.recipientUid,
    required this.senderName,
    required this.recipientName,
    required this.recipientPhoneNumber,
    required this.senderPhoneNumber,
    required this.recipientImage,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  File? image;
  String? imageName;
  num? imageSize;
  PlatformFile? pickedFile;

  List<DownloadingProgress> progresses = [];
  double dowProgress = 0;
  String progressString = '';
  double updateProgress = 0;
  String updateProgressString = '';
  bool fileDownloaded = false;
  bool downloading = false;
  String? downloadedPath;
  bool uploadError = false;

  @override
  void initState() {
    context
        .read<ChatInteractionBloc>()
        .add(ChatInteractionsLoad(widget.senderUid, widget.recipientUid));

    context
        .read<ChatInteractionBloc>()
        .add(ChatInteractionsupdateChattingWithId(widget.recipientUid));

    super.initState();

    _textController.addListener(() {
      // ignore: no-empty-block
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

  void openFile(String? file) {
    print(file);
    OpenFile.open(file);
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

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  @override
  void dispose() {
    _textController
      // ignore: no-empty-block
      ..removeListener(() {})
      ..dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatInteractionBloc, ChatInteractionState>(
      builder: (context, state) {
        context.read<ChatInteractionBloc>().add(ChatInteractionsSeenMessages(
              widget.senderUid,
              widget.recipientUid,
            ));
        if (state is ChatInteractionLoading) {
          return const Scaffold(
            body: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state is ChatInteractionLoaded) {
          final errorList =
              context.select<FileInteractionBloc, List<MessageModel>>(
            (bloc) {
              final state = bloc.state;

              return state is FileInteractinonError ? state.errorList : [];
            },
          );
          final messages = [...state.messages, ...errorList];

          return Scaffold(
            appBar: CustomAppBar(
              widgetleft: GestureDetector(
                onTap: () {
                  context
                      .read<ChatInteractionBloc>()
                      .add(const ChatInteractionsupdateChattingWithId(''));
                  context.router.pop();
                },
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
                onTap: () => context.router.push(ProfileRoute(
                  userid: widget.recipientUid,
                  allMessages: messages,
                )),
                child: Text(
                  '${widget.recipientName}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              widgetRight: CircleAvatar(
                radius: 15,
                backgroundImage: widget.recipientImage != ''
                    ? NetworkImage(widget.recipientImage)
                    : null,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
              child: Column(
                children: [
                  Expanded(
                    child: messages.isEmpty
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
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final messageRevers = messages.reversed.toList();
                              print(messageRevers.last);
                              final messagesData = messageRevers[index];
                              final bool sender =
                                  widget.senderUid == messagesData.sederUid;

                              if (messagesData.messageType == 'image') {
                                return MessageBubble(
                                  seen: messagesData.isRead,
                                  error: false,
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
                                      context
                                          .read<FileInteractionBloc>()
                                          .add(FileInteractionDownloading(
                                            messagesData.messageId,
                                            messagesData.message,
                                          ));
                                    } else
                                      openFile(downloadedPath);
                                  },
                                  child: BlocBuilder<FileInteractionBloc,
                                      FileInteractionState>(
                                    builder: (context, state) {
                                      if (state is FileInteractinonError &&
                                          state.errorList
                                              .contains(messagesData)) {
                                        final errorIndex = state.errorList
                                            .indexWhere((element) =>
                                                element.docId ==
                                                messagesData.docId);

                                        final errorMes = errorIndex != -1
                                            ? state.errorList[errorIndex]
                                            : state.errorList.last;

                                        return GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet<Widget?>(
                                              useRootNavigator: true,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(24),
                                                ),
                                              ),
                                              context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 16,
                                                    top: 35,
                                                    bottom: 50,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          final resendfile =
                                                              File(
                                                            pickedFile?.path ??
                                                                '',
                                                          );
                                                          // ignore: unnecessary_null_comparison
                                                          if (resendfile !=
                                                              null) {
                                                            context
                                                                .read<
                                                                    FileInteractionBloc>()
                                                                .add(
                                                                  FileInteractionUploadFile(
                                                                    resendfile,
                                                                    widget
                                                                        .senderUid,
                                                                    widget
                                                                        .senderName,
                                                                    widget
                                                                        .senderPhoneNumber,
                                                                    widget
                                                                        .recipientUid,
                                                                    widget
                                                                        .recipientName,
                                                                    widget
                                                                        .recipientPhoneNumber,
                                                                    '',
                                                                    'file',
                                                                    errorMes
                                                                        .docSize,
                                                                    errorMes
                                                                        .docName,
                                                                    errorMes
                                                                        .docId,
                                                                  ),
                                                                );
                                                          }

                                                          return;
                                                        },
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/icons/resend.svg',
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            const Text(
                                                              'Resend',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 26,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            state.errorList
                                                                .remove(
                                                              errorMes,
                                                            );
                                                          });

                                                          print('tap');
                                                        },
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/icons/delete.svg',
                                                            ),
                                                            const SizedBox(
                                                              width: 12,
                                                            ),
                                                            const Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              MessageBubble(
                                                docSize: errorMes.docSize,
                                                text: errorMes.docName,
                                                type: MessageBubbleType
                                                    .sendDocError,
                                                time: DateFormat('hh:mm a')
                                                    .format(
                                                  errorMes.time.toDate(),
                                                ),
                                                error: uploadError,
                                                seen: false,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              SvgPicture.asset(
                                                'assets/icons/error.svg',
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      if (state
                                          is FileInteractionProgressDownloading) {
                                        final downloadIndex = state.progressList
                                            .indexWhere((progressId) =>
                                                progressId.id ==
                                                messagesData.messageId);

                                        final progress = downloadIndex != -1
                                            ? state.progressList[downloadIndex]
                                                .progress
                                            : 0;
                                        dowProgress = progress.toDouble();
                                        progressString =
                                            '${(dowProgress * 100).toStringAsFixed(0)}% downloaded';
                                      }
                                      if (state
                                          is FileInteractionProgressUploading) {
                                        final uploadIndex =
                                            state.uploadProgressList.indexWhere(
                                          (progressDocId) =>
                                              progressDocId.docId ==
                                              messagesData.docId,
                                        );

                                        final uploadProgress = uploadIndex != -1
                                            ? state
                                                .uploadProgressList[uploadIndex]
                                                .uploadProgress
                                            : 0;
                                        updateProgress =
                                            uploadProgress.toDouble();
                                        updateProgressString =
                                            '${(updateProgress * 100).toStringAsFixed(0)}% uploaded';

                                        return MessageBubble(
                                          seen: messagesData.isRead,
                                          error: uploadError,
                                          uploadValue: updateProgress,
                                          uploadString: updateProgressString,
                                          docSize:
                                              messagesData.docSize.toString(),
                                          type: sender
                                              ? MessageBubbleType.sendDoc
                                              : MessageBubbleType.reciveDoc,
                                          text: messagesData.docName,
                                          time: DateFormat('hh:mm a').format(
                                            messagesData.time.toDate(),
                                          ),
                                        );
                                      }

                                      return MessageBubble(
                                        seen: messagesData.isRead,
                                        error: false,
                                        docSize:
                                            messagesData.docSize.toString(),
                                        downloadString: progressString,
                                        downloadValue: dowProgress,
                                        type: sender
                                            ? MessageBubbleType.sendDoc
                                            : MessageBubbleType.reciveDoc,
                                        text: messagesData.docName,
                                        time: DateFormat('hh:mm a')
                                            .format(messagesData.time.toDate()),
                                      );
                                    },
                                  ),
                                );
                              } else if (messagesData.messageType == 'audio') {
                                const bool play = false;
                                context.read<AudioWaveLoaderBloc>().add(
                                      AudioWaveLoaderStart(
                                        messagesData.messageId,
                                        messagesData.docName,
                                        messagesData.message,
                                      ),
                                    );

                                return BlocBuilder<AudioWaveLoaderBloc,
                                    AudioWaveLoaderState>(
                                  builder: (context, waveState) {
                                    Waveform? wave;

                                    WaveSetter? waveSetter;

                                    if (waveState is AudioWaveLoaderLoaded) {
                                      final waveIndex = waveState.waveFormList
                                          .indexWhere((waveSet) =>
                                              waveSet.id ==
                                              messagesData.messageId);

                                      final waveAudio = waveIndex != -1
                                          ? waveState.waveFormList[waveIndex]
                                          : null;
                                      waveSetter = waveAudio;
                                    }

                                    return GestureDetector(
                                      onTap: () {
                                        context
                                            .read<AudioPlayBloc>()
                                            .add(AudioPlayPauseToggled(
                                              play: !play,
                                              docName: messagesData.docName,
                                              messageId: messagesData.messageId,
                                            ));
                                      },
                                      child: BlocBuilder<AudioPlayBloc,
                                          AudioPlayState>(
                                        builder: (context, state) {
                                          bool isPlaying = false;

                                          Duration currentAudioPosition =
                                              Duration.zero;

                                          if (state is AudioPlayCurrentState) {
                                            final auidoPositionIndex =
                                                state.audioPosition.indexWhere(
                                              (audioPosId) =>
                                                  audioPosId.id ==
                                                  messagesData.messageId,
                                            );

                                            final audioPosition =
                                                auidoPositionIndex != -1
                                                    ? state
                                                        .audioPosition[
                                                            auidoPositionIndex]
                                                        .position
                                                    : Duration.zero;
                                            final fullAudioDuration =
                                                auidoPositionIndex != -1
                                                    ? state
                                                        .audioPosition[
                                                            auidoPositionIndex]
                                                        .fullDuration
                                                    : Duration.zero;

                                            final audioisPlaying =
                                                // ignore: avoid_bool_literals_in_conditional_expressions
                                                auidoPositionIndex != -1
                                                    ? state
                                                        .audioPosition[
                                                            auidoPositionIndex]
                                                        .isPlaying
                                                    : false;

                                            currentAudioPosition =
                                                audioPosition;

                                            isPlaying = audioisPlaying;
                                            if (currentAudioPosition ==
                                                fullAudioDuration) {
                                              isPlaying = false;
                                            }
                                          }

                                          return MessageBubble(
                                            audioWaveWidget: (waveSetter
                                                    is WaveSetterLoaded)
                                                ? AudioWaveform(
                                                    waveform: waveSetter
                                                            .waveform ??
                                                        Waveform(
                                                          version: 1,
                                                          flags: 0,
                                                          sampleRate: 0,
                                                          samplesPerPixel: 0,
                                                          length: 0,
                                                          data: [
                                                            0,
                                                          ],
                                                        ),
                                                    start: Duration.zero,
                                                    progress:
                                                        currentAudioPosition,
                                                    duration: waveSetter
                                                            .waveform
                                                            ?.duration ??
                                                        Duration.zero,
                                                  )
                                                : const Center(
                                                    child: SizedBox(
                                                      width: 24,
                                                      height: 24,
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                  ),
                                            audioProgress: currentAudioPosition,
                                            start: Duration.zero,
                                            audioWaveform: wave,
                                            audioWaveformDuration:
                                                wave?.duration ?? Duration.zero,
                                            isPlaying: isPlaying,
                                            seen: messagesData.isRead,
                                            error: uploadError,
                                            uploadValue: updateProgress,
                                            uploadString: updateProgressString,
                                            docSize: '',
                                            type: sender
                                                ? MessageBubbleType.sendAudio
                                                : MessageBubbleType
                                                    .receiveAudio,
                                            text: messagesData.docName,
                                            time: DateFormat('hh:mm a').format(
                                              messagesData.time.toDate(),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              }

                              return MessageBubble(
                                seen: messagesData.isRead,
                                error: false,
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
                                  top: 35,
                                  bottom: 50,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
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

                                        print(' tap image upload');
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/photo.svg',
                                          ),
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
                                    GestureDetector(
                                      onTap: () {
                                        pickFile().whenComplete(() {
                                          final double kb =
                                              (pickedFile!.size) / 1024;
                                          final double mb = kb / 1024;
                                          final String size = (mb >= 1)
                                              ? '${mb.toStringAsFixed(2)} MB'
                                              : '${kb.toStringAsFixed(2)} KB';
                                          print(
                                            'PATHHH ${File(pickedFile?.path ?? '')}',
                                          );
                                          final pkfile =
                                              File(pickedFile?.path ?? '');
                                          // ignore: unnecessary_null_comparison
                                          if (pkfile != null) {
                                            context
                                                .read<FileInteractionBloc>()
                                                .add(
                                                  FileInteractionUploadFile(
                                                    pkfile,
                                                    widget.senderUid,
                                                    widget.senderName,
                                                    widget.senderPhoneNumber,
                                                    widget.recipientUid,
                                                    widget.recipientName,
                                                    widget.recipientPhoneNumber,
                                                    '',
                                                    'file',
                                                    size,
                                                    pickedFile?.name ??
                                                        'document name loading,..',
                                                    '$pkfile/${Timestamp.now()}',
                                                  ),
                                                );
                                          }

                                          return;
                                        });

                                        final tmp =
                                            File(pickedFile?.path ?? '');
                                        print('PATh $tmp');
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/file.svg',
                                          ),
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
                      BlocConsumer<AudioRecordBloc, AudioRecordState>(
                        listener: (context, state) {
                          if (state is AudioRecordStoped) {
                            if (state.path != '') {
                              final audioFile = File(state.path);
                              final audioName = audioFile.path.split('/').last;
                              context.read<FileInteractionBloc>().add(
                                    FileInteractionUploadFile(
                                      audioFile,
                                      widget.senderUid,
                                      widget.senderName,
                                      widget.senderPhoneNumber,
                                      widget.recipientUid,
                                      widget.recipientName,
                                      widget.recipientPhoneNumber,
                                      '',
                                      'audio',
                                      'min:sec',
                                      audioName,
                                      '$audioFile/${Timestamp.now()}',
                                    ),
                                  );
                            }
                          }
                        },
                        builder: (context, state) {
                          final voiceRecording = (state is AudioRecordOn &&
                                  state.isRecording) ||
                              (state is AudioRecordStoped && state.isRecording);

                          String minutes = '00';
                          String seconds = '00';
                          if (state is AudioRecordOn) {
                            minutes = _formatNumber(state.recordTime ~/ 60);
                            seconds = _formatNumber(state.recordTime % 60);
                          }

                          return SizedBox(
                            child: !voiceRecording
                                ? TextField(
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
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        minWidth:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                      ),
                                      helperStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors
                                            .lightGreytextFieldSearchHintText,
                                      ),
                                    ),
                                  )
                                : Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 5,
                                      ),
                                      const SizedBox(width: 5),
                                      Text('$minutes:$seconds'),
                                      const SizedBox(width: 75),
                                      SvgPicture.asset(
                                        'assets/icons/chevron_left.svg',
                                      ),
                                      const SizedBox(width: 5),
                                      const Text('Swipe to cancel'),
                                    ],
                                  ),
                          );
                        },
                      ),
                      GestureDetector(
                        onLongPressStart: (_) {
                          context
                              .read<AudioRecordBloc>()
                              .add(AudioRecordOnRecord());

                          print('Long Press Start');
                        },
                        onLongPressEnd: (_) {
                          context
                              .read<AudioRecordBloc>()
                              .add(AudioRecordOnStop());

                          print('Long Press End');
                        },
                        onLongPressMoveUpdate: (details) {
                          final Offset localPosition = details.localPosition;
                          print('local $localPosition');
                          if (localPosition.dx < -1.0) {
                            context
                                .read<AudioRecordBloc>()
                                .add(AudioRecordOnCancel());

                            print('Cancel');
                          }
                        },
                        onTap: () {
                          if (_textController.text.isNotEmpty) {
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
                          }
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

        return const Scaffold(
          body: Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
