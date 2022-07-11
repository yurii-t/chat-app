import 'package:chat_app/data/datasource/firebase/firebase_cloud_messaging.dart';
import 'package:chat_app/domain/repositories/firebase_cloud_messaging_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseCloudMessagingRepositoryImpl
    implements FirebaseCloudMessagingRepository {
  final FirebaseCloudMessaging firebaseCloudMessaging;

  FirebaseCloudMessagingRepositoryImpl(this.firebaseCloudMessaging);

  @override
  Future<String> getDeviceToken() => firebaseCloudMessaging.getDeviceToken();
  @override
  Stream<RemoteMessage> receiveNotification() =>
      firebaseCloudMessaging.receiveNotification();
}
