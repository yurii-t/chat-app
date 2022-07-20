part of 'audio_record_bloc.dart';

abstract class AudioRecordState extends Equatable {
  const AudioRecordState();

  @override
  List<Object> get props => [];
}

class AudioRecordInitial extends AudioRecordState {}

class AudioRecordOn extends AudioRecordState {
  final bool isRecording;
  final int recordTime;

  const AudioRecordOn({required this.isRecording, required this.recordTime});
  @override
  List<Object> get props => [isRecording, recordTime];
}

class AudioRecordStoped extends AudioRecordState {
  final bool isRecording;
  final String path;

  const AudioRecordStoped({required this.isRecording, required this.path});
  @override
  List<Object> get props => [isRecording, path];
}

class AudioRecordCanceled extends AudioRecordState {
  final bool isRecording;

  const AudioRecordCanceled({
    required this.isRecording,
  });
  @override
  List<Object> get props => [
        isRecording,
      ];
}
