// ignore_for_file: long-method

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:chat_app/domain/usecases/download_file_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:just_waveform/just_waveform.dart';

part 'audio_wave_loader_event.dart';
part 'audio_wave_loader_state.dart';

class AudioWaveLoaderBloc
    extends Bloc<AudioWaveLoaderEvent, AudioWaveLoaderState> {
  final DownloadFileUseCase downloadFileUseCase;
  AudioWaveLoaderBloc(this.downloadFileUseCase)
      : super(AudioWaveLoaderInitial()) {
    on<AudioWaveLoaderStart>(
      (event, emit) async {
        print('EventID ${event.messageId}');
        const path = 'data/user/0/com.example.chat_app/app_flutter/';

        final auidoFile = await File(path + event.docName);
        final String waveName = '${event.docName.split('.').first}.wave';
        final waveFile = await File(path + waveName);
        Waveform? completeWave;

        ;

        if (!auidoFile.existsSync()) {
          await (await downloadFileUseCase.call(DownloadFileParams(
            event.url,
            auidoFile,
          )));
        }
        if (!waveFile.existsSync()) {
          final progressStream = JustWaveform.extract(
            audioInFile: auidoFile,
            waveOutFile: waveFile,
            zoom: const WaveformZoom.pixelsPerSecond(100),
          );

          await emit.forEach(
            progressStream,
            onData: (waveformProgress) {
              final state = this.state;

              final waveList = state is AudioWaveLoaderLoaded
                  ? List<WaveSetter>.from(state.waveFormList)
                  : <WaveSetter>[];

              final waveSetter =
                  (waveformProgress as WaveformProgress).progress >= 1
                      ? WaveSetterLoaded(
                          id: event.messageId,
                          waveform: waveformProgress.waveform,
                        )
                      : WaveSetterLoading(id: event.messageId);

              final waveIndex = waveList.indexWhere(
                (wave) => wave.id == event.messageId,
              );
              if (waveIndex == -1) {
                waveList.add(
                  waveSetter,
                );
              } else {
                waveList[waveIndex] = waveSetter;
              }

              return AudioWaveLoaderLoaded(waveList);
            },
          );
        } else {
          final parseWaveFile = await JustWaveform.parse(waveFile);
          completeWave = parseWaveFile;
          print('WAVE PARSED');
          final state = this.state;
          final waveList = state is AudioWaveLoaderLoaded
              ? List<WaveSetter>.from(state.waveFormList)
              : <WaveSetter>[];

          final waveSetter =
              WaveSetterLoaded(id: event.messageId, waveform: completeWave);

          final waveIndex = waveList.indexWhere(
            (wave) => wave.id == event.messageId,
          );
          if (waveIndex == -1) {
            waveList.add(
              waveSetter,
            );
          } else {
            waveList[waveIndex] = waveSetter;
          }

          emit(AudioWaveLoaderLoaded(waveList));
        }
      },
      transformer: sequential(),
    );
  }

  @override
  void onTransition(
    Transition<AudioWaveLoaderEvent, AudioWaveLoaderState> transition,
  ) {
    final nextState = transition.nextState;

    if (nextState is AudioWaveLoaderLoaded) {
      nextState.waveFormList
        ..forEach(
          (element) {
            print('${element.runtimeType}--->ID: ${element.id}');
          },
        );
    }

    print('TRANSITION: ${nextState.runtimeType}');

    super.onTransition(transition);
  }
}
