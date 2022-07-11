import 'dart:io';

import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/repositories/firebase_storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GetReferenceUseCase implements UseCase<Reference, GetReferenceParams> {
  final FirebaseStorageRepository _firebaseStorageRepository;

  GetReferenceUseCase(this._firebaseStorageRepository);

  @override
  Future<Reference> call(GetReferenceParams params) async {
    return _firebaseStorageRepository.getReference(
      params.file,
      params.chatId,
      params.folder,
    );
  }
}

class GetReferenceParams {
  final File file;
  final String chatId;
  final String folder;

  GetReferenceParams(this.file, this.chatId, this.folder);
}
