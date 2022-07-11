import 'package:firebase_messaging/firebase_messaging.dart';

abstract class FirebaseCloudMessaging {
  Future<String> getDeviceToken();
  Stream<RemoteMessage> receiveNotification();
}
