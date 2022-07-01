import 'package:chat_app/core/usecases/use_case_stream.dart';
import 'package:chat_app/domain/repositories/firebase_storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DownloadProgressUseCase implements UseCaseStream<double, DownloadTask> {
  final FirebaseStorageRepository _firebaseStorageRepository;

  DownloadProgressUseCase(this._firebaseStorageRepository);

  @override
  Stream<double> call(DownloadTask downloadTask) {
    return _firebaseStorageRepository.downloadProgress(downloadTask);
  }
}
