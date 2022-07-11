import 'package:chat_app/data/datasource/firebase/firebase_cloud_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseCloudMessagingImpl extends FirebaseCloudMessaging {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<String> getDeviceToken() async {
    final token = await _firebaseMessaging.getToken();
    print('TOKEN $token');

    return token ?? '';
  }

  @override
  Stream<RemoteMessage> receiveNotification() {
    final mes = FirebaseMessaging.onMessage;

    return mes;
  }
}
