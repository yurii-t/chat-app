import 'dart:io';

import 'package:chat_app/data/datasource/firebase/firebase_storage_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorageRemoteDataSourceImpl
    implements FirebaseStorageRemoteDataSource {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  @override
  Future<Reference> getReference(File file, String chatId) async {
    return _firebaseStorage.ref().child(
        'chats/$chatId/${DateTime.now().millisecondsSinceEpoch}${getNameOnly(file.path)}');
  }

  @override
  // Future<String> uploadImage(
  Future<UploadTask> uploadImage(
    File file,
    Reference ref,
  ) async {
    // final ref = _firebaseStorage.ref().child(
    //       'chats/$chatId/${DateTime.now().millisecondsSinceEpoch}${getNameOnly(file.path)}',
    //     );

    final uploadTask = ref.putFile(file);
    // final progress = uploadTask.snapshot.bytesTransferred.toDouble() /
    //     uploadTask.snapshot.totalBytes.toDouble();
    // print('PROG $progress');
    // var sto = uploadTask.snapshotEvents
    //     .map((event) => event.bytesTransferred / event.totalBytes)
    //     .toString;

    // uploadProgress(uploadTask).listen((event) {
    //   print('EEEE $event');
    // });
    // uploadProgress(uploadTask);

    // // print('SENDDD $sto');
    // final fileUrl = await (await uploadTask
    //         .whenComplete(() => print('image upload complete')))
    //     .ref
    //     .getDownloadURL();
    // print(fileUrl);

    // return fileUrl;
    return uploadTask;
  }

  @override
  Stream<double> uploadProgress(
    UploadTask task,
  ) {
    // return (task.snapshot.bytesTransferred / task.snapshot.totalBytes);
    final tmp = task.snapshotEvents.map((event) {
      return event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
    });
    //  var tmp= task.snapshot.bytesTransferred / task.snapshot.totalBytes;

    return tmp;
  }

  String getNameOnly(String path) {
    return path.split('/').last.split('%').last.split("?").first;
  }

  // void blocF() async {
  //   final path = '';
  //   final url = '';

  //   if (File(path).existsSync()){
  //     await OpenFile.open(path);
  //   } else {
  //     this.download(url,path);
  //   }
  // }

  @override
  Future<DownloadTask> downloadFile(String url, File file) async {
    // final file = File(path);
    final downloadTask = _firebaseStorage
        .refFromURL(url)
        .writeToFile(await file.create(recursive: true));
    // FirebaseStorage.instance.refFromURL(url).writeToFile(file);

    // final tempDir = await getTemporaryDirectory();
    // final path = '${tempDir.path}/${url}';
    // // final Directory appDocDir = await getApplicationDocumentsDirectory();
    // // final path = '${appDocDir.path}/${url}';
    // // downloadedPath = path;
    // print('PATH $path');
    // // final filePath = File(path);
    // // // await File(path).exists();
    // double downloadProgress = 0;

    // if (File(path).existsSync()) {
    //   await OpenFile.open(path);
    // } else {
    //   await Dio().download(url, path, onReceiveProgress: (recived, total) {
    //     downloadProgress = recived / total;
    //     // setState(() {
    //     //   dowProgress = progress;
    //     //   if (progress >= 1) {
    //     //     fileDownloaded = true;
    //     //     downloading = false;
    //     //   } else {
    //     //     progressString =
    //     //         '${(progress * 100).toStringAsFixed(0)}% downloaded';
    //     //     downloading = true;
    //     //   }
    //     //   //        final kb = file.size / 1024;
    //     //   // final mb = kb / 1024;
    //     //   // final size  = (mb>=1)?'${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    //     // });
    //   });
    // }

    return downloadTask;
  }

  @override
  Stream<double> downloadProgress(
    DownloadTask downloadTask,
  ) {
    // return (task.snapshot.bytesTransferred / task.snapshot.totalBytes);
    // final tmp = task.snapshotEvents.map((event) {
    //   return event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
    final dowTask = downloadTask.snapshotEvents.map((event) =>
        event.bytesTransferred.toDouble() / event.totalBytes.toDouble());

    //  var tmp= task.snapshot.bytesTransferred / task.snapshot.totalBytes;

    return dowTask;
  }
}
