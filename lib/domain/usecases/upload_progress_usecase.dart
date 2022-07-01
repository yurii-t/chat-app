import 'package:chat_app/core/usecases/use_case_stream.dart';
import 'package:chat_app/domain/repositories/firebase_storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadProgressUsecase implements UseCaseStream<double, UploadTask> {
  final FirebaseStorageRepository _firebaseStorageRepository;

  UploadProgressUsecase(this._firebaseStorageRepository);

  @override
  Stream<double> call(UploadTask task) {
    return _firebaseStorageRepository.uploadProgress(task);
  }
}
