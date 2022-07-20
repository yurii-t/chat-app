part of 'audio_play_bloc.dart';

abstract class AudioPlayEvent extends Equatable {
  const AudioPlayEvent();

  @override
  List<Object> get props => [];
}

class AudioPlayPauseToggled extends AudioPlayEvent {
  final bool play;
  final String docName;
  final String messageId;

  const AudioPlayPauseToggled({
    required this.play,
    required this.docName,
    required this.messageId,
  });
  @override
  List<Object> get props => [play, docName, messageId];
}
