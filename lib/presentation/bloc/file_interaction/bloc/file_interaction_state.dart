part of 'file_interaction_bloc.dart';

abstract class FileInteractionState extends Equatable {
  const FileInteractionState();

  @override
  List<Object> get props => [];
}

class FileInteractionInitial extends FileInteractionState {}

class FileInteractionProgressUploading extends FileInteractionState {
  final num progress;

  const FileInteractionProgressUploading(this.progress);

  @override
  List<Object> get props => [progress];
}

class FileInteractionProgressDownloading extends FileInteractionState {
  final num downloadProgress;

  const FileInteractionProgressDownloading(this.downloadProgress);

  @override
  List<Object> get props => [downloadProgress];
}

class FileInteractinonError extends FileInteractionState {
  final String error;

  const FileInteractinonError(this.error);

  @override
  List<Object> get props => [error];
}
