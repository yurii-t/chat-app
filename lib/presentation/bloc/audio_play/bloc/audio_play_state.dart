part of 'audio_play_bloc.dart';

abstract class AudioPlayState extends Equatable {
  const AudioPlayState();

  @override
  List<Object> get props => [];
}

class AudioPlayInitial extends AudioPlayState {}

class AudioPlayCurrentState extends AudioPlayState {
  final List<AudioPosition> audioPosition;

  const AudioPlayCurrentState({
    required this.audioPosition,
  });

  @override
  List<Object> get props => [
        audioPosition,
      ];
}

class AudioPosition {
  final String id;
  final Duration position;
  final bool isPlaying;
  final Duration fullDuration;

  AudioPosition({
    required this.id,
    required this.position,
    required this.isPlaying,
    required this.fullDuration,
  });
}
