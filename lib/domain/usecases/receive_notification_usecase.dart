import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/core/usecases/use_case_stream.dart';
import 'package:chat_app/domain/repositories/firebase_cloud_messaging_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ReceiveNotificationUseCase
    implements UseCaseStream<RemoteMessage, NoParams> {
  final FirebaseCloudMessagingRepository firebaseCloudMessagingRepository;

  ReceiveNotificationUseCase(this.firebaseCloudMessagingRepository);

  @override
  Stream<RemoteMessage> call(NoParams params) =>
      firebaseCloudMessagingRepository.receiveNotification();
}
