import 'dart:io';

import 'package:chat_app/data/datasource/firebase/firebase_storage_remote_datasource.dart';
import 'package:chat_app/domain/repositories/firebase_storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepositoryImpl implements FirebaseStorageRepository {
  final FirebaseStorageRemoteDataSource _firebaseStorageRemoteDataSource;

  FirebaseStorageRepositoryImpl(this._firebaseStorageRemoteDataSource);

  @override
  Stream<double> uploadProgress(UploadTask task) {
    return _firebaseStorageRemoteDataSource.uploadProgress(task);
  }

  @override
  Future<UploadTask> uploadImage(File image, Reference ref) async {
    return _firebaseStorageRemoteDataSource.uploadImage(image, ref);
  }

  @override
  Future<Reference> getReference(
    File file,
    String chatId,
    String folder,
  ) async =>
      _firebaseStorageRemoteDataSource.getReference(file, chatId, folder);

  @override
  Future<DownloadTask> downloadFile(String url, File file) async {
    return _firebaseStorageRemoteDataSource.downloadFile(url, file);
  }

  @override
  Stream<double> downloadProgress(DownloadTask downloadTask) {
    return _firebaseStorageRemoteDataSource.downloadProgress(downloadTask);
  }
}
