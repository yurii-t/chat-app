part of 'file_interaction_bloc.dart';

abstract class FileInteractionState extends Equatable {
  const FileInteractionState();

  @override
  List<Object> get props => [];
}

class FileInteractionInitial extends FileInteractionState {}

class FileInteractionProgressUploading extends FileInteractionState {
  final List<UploadingProgress> uploadProgressList;

  const FileInteractionProgressUploading(
    this.uploadProgressList,
  );

  @override
  List<Object> get props => [
        uploadProgressList,
      ];
}

class FileInteractionProgressDownloading extends FileInteractionState {
  final List<DownloadingProgress> progressList;

  const FileInteractionProgressDownloading(
    this.progressList,
  );

  @override
  List<Object> get props => [progressList];
}

class DownloadingProgress {
  final String id;
  final double progress;

  DownloadingProgress(this.id, this.progress);
}

class FileInteractinonError extends FileInteractionState {
  final List<MessageModel> errorList;

  const FileInteractinonError(this.errorList);

  @override
  List<Object> get props => [errorList];
}

class UploadingProgress {
  final String docId;
  final double uploadProgress;

  UploadingProgress(this.docId, this.uploadProgress);
}
