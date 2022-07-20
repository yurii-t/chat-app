part of 'audio_wave_loader_bloc.dart';

abstract class AudioWaveLoaderEvent extends Equatable {
  const AudioWaveLoaderEvent();

  @override
  List<Object> get props => [];
}

class AudioWaveLoaderStart extends AudioWaveLoaderEvent {
  final String messageId;
  final String docName;
  final String url;
  const AudioWaveLoaderStart(this.messageId, this.docName, this.url);

  @override
  List<Object> get props => [messageId, docName, url];
}
