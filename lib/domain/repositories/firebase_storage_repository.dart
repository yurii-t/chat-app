import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseStorageRepository {
  // Future<String> uploadImage(File image, String chatId);
  Future<UploadTask> uploadImage(File image, Reference ref);
  Stream<double> uploadProgress(UploadTask task);
  Future<Reference> getReference(File file, String chatId);
  // Future<double> downloadFile(String url);
  // Future<DownloadTask> downloadFile(String url, String path);
  Future<DownloadTask> downloadFile(String url, File file);
  Stream<double> downloadProgress(DownloadTask downloadTask);
}
