import 'dart:io';

import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/repositories/firebase_storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DownloadFileUseCase implements UseCase<DownloadTask, DownloadFileParams> {
  final FirebaseStorageRepository _firebaseStorageRepository;

  DownloadFileUseCase(this._firebaseStorageRepository);

  @override
  Future<DownloadTask> call(DownloadFileParams params) async {
    return _firebaseStorageRepository.downloadFile(params.url, params.file);
  }
}

class DownloadFileParams {
  final String url;

  File file;

  DownloadFileParams(this.url, this.file);
}
