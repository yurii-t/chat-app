part of 'audio_wave_loader_bloc.dart';

abstract class AudioWaveLoaderState extends Equatable {
  const AudioWaveLoaderState();

  @override
  List<Object> get props => [];
}

class AudioWaveLoaderInitial extends AudioWaveLoaderState {}

class AudioWaveLoaderLoaded extends AudioWaveLoaderState {
  final List<WaveSetter> waveFormList;

  const AudioWaveLoaderLoaded(this.waveFormList);

  @override
  List<Object> get props => [waveFormList];
}

// waveForm = [ WaveSetterLoading(),  WaveSetterLoaded()]

abstract class WaveSetter {
  final String id;

  WaveSetter({required this.id});
}

class WaveSetterLoading extends WaveSetter {
  WaveSetterLoading({required super.id});
}

class WaveSetterLoaded extends WaveSetter {
  final Waveform? waveform;

  WaveSetterLoaded({required super.id, required this.waveform});
}
