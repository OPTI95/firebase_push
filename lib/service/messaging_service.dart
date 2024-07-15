import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  String? fcmToken;

  Future<void> init() async {
    _fcm.requestPermission();
    try {
      fcmToken = await _fcm.getToken();
      print(fcmToken);
    } catch (e) {
      print(e.toString());
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
    });
  }
}
