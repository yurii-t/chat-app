import 'dart:io';

import 'package:chat_app/data/datasource/firebase/firebase_storage_remote_datasource.dart';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRemoteDataSourceImpl
    implements FirebaseStorageRemoteDataSource {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  @override
  Future<Reference> getReference(
    File file,
    String chatId,
    String folder,
  ) async {
    return _firebaseStorage.ref().child(
          '$folder/$chatId/${DateTime.now().millisecondsSinceEpoch}${getNameOnly(file.path)}',
        );
  }

  @override
  Future<UploadTask> uploadImage(
    File file,
    Reference ref,
  ) async {
    final uploadTask = ref.putFile(file);

    return uploadTask;
  }

  @override
  Stream<double> uploadProgress(
    UploadTask task,
  ) {
    final tmp = task.snapshotEvents.map((event) {
      return event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
    });

    return tmp;
  }

  String getNameOnly(String path) {
    return path.split('/').last.split('%').last.split('?').first;
  }

  @override
  Future<DownloadTask> downloadFile(String url, File file) async {
    final downloadTask = _firebaseStorage
        .refFromURL(url)
        .writeToFile(await file.create(recursive: true));

    return downloadTask;
  }

  @override
  Stream<double> downloadProgress(
    DownloadTask downloadTask,
  ) {
    final dowTask = downloadTask.snapshotEvents.map((event) =>
        event.bytesTransferred.toDouble() / event.totalBytes.toDouble());

    return dowTask;
  }
}
