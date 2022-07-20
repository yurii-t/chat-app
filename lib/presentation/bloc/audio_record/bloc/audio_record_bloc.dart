import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

part 'audio_record_event.dart';
part 'audio_record_state.dart';

class AudioRecordBloc extends Bloc<AudioRecordEvent, AudioRecordState> {
  AudioRecordBloc() : super(AudioRecordInitial()) {
    final _audioRecorder = Record();

    on<AudioRecordEvent>(
      (event, emit) async {
        int recordDuration = 0;
        if (event is AudioRecordOnRecord) {
          final Map<Permission, PermissionStatus> permissions = await [
            Permission.storage,
            Permission.microphone,
          ].request();

          final bool permissionsGranted =
              permissions[Permission.storage]!.isGranted &&
                  permissions[Permission.microphone]!.isGranted;

          if (permissionsGranted) {
            final tempDir = await getApplicationDocumentsDirectory();

            final pathFolder =
                '${tempDir.path}/${DateTime.now().microsecondsSinceEpoch}.mp3';
            await _audioRecorder.start(path: pathFolder);
            final bool isRecording = await _audioRecorder.isRecording();

            final timeStream = Stream.periodic(
              const Duration(seconds: 1),
              (t) => recordDuration++,
            );

            await emit.forEach(
              timeStream,
              onData: (time) => AudioRecordOn(
                isRecording: isRecording,
                recordTime: time as int,
              ),
            );
          }
        }
        if (event is AudioRecordOnStop) {
          final path = await _audioRecorder.stop();
          print('AUIDOPATH $path');
          print('TIMEE $recordDuration');
          final bool isRecording = await _audioRecorder.isRecording();

          emit(AudioRecordStoped(isRecording: isRecording, path: path ?? ''));
        }
        if (event is AudioRecordOnCancel) {
          final path = await _audioRecorder.stop();

          print('AUIDOPATH $path');
          print('TIMEE $recordDuration');
          final bool isRecording = await _audioRecorder.isRecording();

          emit(AudioRecordCanceled(isRecording: isRecording));
        }
      },
      transformer: restartable(),
    );
  }

  @override
  void onTransition(Transition<AudioRecordEvent, AudioRecordState> transition) {
    final nextState = transition.nextState;

    if (nextState is AudioRecordOn) {
      print('TRANSITION AudioRecordOn: ${nextState.recordTime}');
    }
    if (nextState is AudioRecordOnStop) {
      print('TRANSITION AudioRecordOnStop: ${nextState}');
    }

    super.onTransition(transition);
  }
}
