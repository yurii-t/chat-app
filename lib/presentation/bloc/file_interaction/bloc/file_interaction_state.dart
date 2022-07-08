part of 'file_interaction_bloc.dart';

abstract class FileInteractionState extends Equatable {
  const FileInteractionState();

  @override
  List<Object> get props => [];
}

class FileInteractionInitial extends FileInteractionState {}

class FileInteractionProgressUploading extends FileInteractionState {
  // final num progress;
  final List<UploadingProgress> uploadProgressList;

  const FileInteractionProgressUploading(
    this.uploadProgressList,
    // this.progress,
  );

  @override
  List<Object> get props => [
        uploadProgressList
        // progress,
      ];
}

class FileInteractionProgressDownloading extends FileInteractionState {
  //final num downloadProgress;
  final List<DownloadingProgress> progressList;

  const FileInteractionProgressDownloading(
    this.progressList,
    //this.downloadProgress);
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
  // final bool error;
  // final List<MessageEntity> errorList;
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
