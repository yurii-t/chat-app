import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseStorageRepository {
  Future<UploadTask> uploadImage(File image, Reference ref);
  Stream<double> uploadProgress(UploadTask task);

  Future<Reference> getReference(File file, String chatId, String folder);

  Future<DownloadTask> downloadFile(String url, File file);
  Stream<double> downloadProgress(DownloadTask downloadTask);
}
