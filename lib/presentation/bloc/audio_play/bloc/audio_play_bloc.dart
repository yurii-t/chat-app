// ignore_for_file: long-method

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:just_audio/just_audio.dart';

part 'audio_play_event.dart';
part 'audio_play_state.dart';

class AudioPlayBloc extends Bloc<AudioPlayEvent, AudioPlayState> {
  AudioPlayBloc() : super(AudioPlayInitial()) {
    on<AudioPlayPauseToggled>(
      (event, emit) async {
        final _player = AudioPlayer();

        const path = 'data/user/0/com.example.chat_app/app_flutter/';

        final audioPath = path + event.docName;
        await _player.setFilePath(audioPath);
        final Duration? fullDuration = await _player.setFilePath(audioPath);

        if (event.play) {
          unawaited(_player.play());
          bool isPlaying = true;
          isPlaying = _player.playing;

          final position = _player.positionStream;

          print('PPP${_player.position}');

          await emit.forEach(
            position,
            onData: (curPos) {
              final state = this.state;

              final audioPositionList = state is AudioPlayCurrentState
                  ? List<AudioPosition>.from(state.audioPosition)
                  : <AudioPosition>[];

              final audioIndex = audioPositionList.indexWhere(
                (audioPosition) => audioPosition.id == event.messageId,
              );
              if (audioIndex == -1) {
                audioPositionList.add(AudioPosition(
                  id: event.messageId,
                  position: curPos as Duration,
                  isPlaying: isPlaying,
                  fullDuration: fullDuration ?? Duration.zero,
                ));
              } else {
                audioPositionList[audioIndex] = AudioPosition(
                  id: event.messageId,
                  position: curPos as Duration,
                  isPlaying: isPlaying,
                  fullDuration: fullDuration ?? Duration.zero,
                );
              }
              if (curPos == _player.duration) {
                isPlaying = false;
                print('STOPSTOPSTOP');
                _player.pause();
              }

              return AudioPlayCurrentState(audioPosition: audioPositionList);
            },
          );
        } else {
          await _player.stop();
        }
      },
      transformer: restartable(),
    );
  }

  @override
  void onTransition(Transition<AudioPlayEvent, AudioPlayState> transition) {
    final nextState = transition.nextState;

    if (nextState is AudioPlayCurrentState) {
      print('POSTIOOOON AudioRecordOn: ${nextState.audioPosition}');
    }

    super.onTransition(transition);
  }
}
