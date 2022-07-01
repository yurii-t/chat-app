import 'dart:io';

import 'package:chat_app/data/datasource/firebase/firebase_storage_remote_datasource.dart';
import 'package:chat_app/domain/repositories/firebase_storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepositoryImpl implements FirebaseStorageRepository {
  final FirebaseStorageRemoteDataSource _firebaseStorageRemoteDataSource;

  FirebaseStorageRepositoryImpl(this._firebaseStorageRemoteDataSource);
  // @override
  // Future<String> uploadImage(File image, String chatId) async {
  //   return _firebaseStorageRemoteDataSource.uploadImage(image, chatId);
  // }

  @override
  Stream<double> uploadProgress(UploadTask task) {
    return _firebaseStorageRemoteDataSource.uploadProgress(task);
  }

  @override
  Future<UploadTask> uploadImage(File image, Reference ref) async {
    return _firebaseStorageRemoteDataSource.uploadImage(image, ref);
  }

  @override
  Future<Reference> getReference(File file, String chatId) async {
    return _firebaseStorageRemoteDataSource.getReference(file, chatId);
  }

  @override
  Future<DownloadTask> downloadFile(String url, String path) async {
    return _firebaseStorageRemoteDataSource.downloadFile(url, path);
  }

  @override
  Stream<double> downloadProgress(DownloadTask downloadTask) {
    return _firebaseStorageRemoteDataSource.downloadProgress(downloadTask);
  }
}
