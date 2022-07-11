import 'package:firebase_messaging/firebase_messaging.dart';

abstract class FirebaseCloudMessagingRepository {
  Future<String> getDeviceToken();
  Stream<RemoteMessage> receiveNotification();
}
