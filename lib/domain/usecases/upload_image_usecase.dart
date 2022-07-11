import 'dart:io';

import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/repositories/firebase_storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadImageUsecase implements UseCase<UploadTask, UploadImageParams> {
  final FirebaseStorageRepository _firebaseStorageRepository;

  UploadImageUsecase(this._firebaseStorageRepository);

  @override
  Future<UploadTask> call(UploadImageParams params) async {
    return _firebaseStorageRepository.uploadImage(params.image, params.ref);
  }
}

class UploadImageParams {
  final File image;
  final Reference ref;

  UploadImageParams(this.image, this.ref);
}
