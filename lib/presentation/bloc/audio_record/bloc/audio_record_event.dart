part of 'audio_record_bloc.dart';

abstract class AudioRecordEvent extends Equatable {
  const AudioRecordEvent();

  @override
  List<Object> get props => [];
}

class AudioRecordOnRecord extends AudioRecordEvent {}

class AudioRecordOnStart extends AudioRecordEvent {}

class AudioRecordOnStop extends AudioRecordEvent {}

class AudioRecordOnCancel extends AudioRecordEvent {}
