import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/repositories/firebase_cloud_messaging_repository.dart';

class GetDeviceTokenUseCase implements UseCase<String, NoParams> {
  final FirebaseCloudMessagingRepository firebaseCloudMessagingRepository;

  GetDeviceTokenUseCase(this.firebaseCloudMessagingRepository);

  @override
  Future<String> call(NoParams params) =>
      firebaseCloudMessagingRepository.getDeviceToken();
}
