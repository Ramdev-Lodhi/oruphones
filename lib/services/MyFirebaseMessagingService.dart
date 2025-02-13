import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:oruphones/services/notification_service.dart';

class MyFirebaseMessagingService {
  static Future<void> backgroundHandler(RemoteMessage message) async {
    NotificationService.showNotification(
      title: message.notification?.title ?? "No Title",
      body: message.notification?.body ?? "No Body",
      imageUrl: message.notification?.android?.imageUrl,
    );
  }

  static Future<void> initialize() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService.showNotification(
        title: message.notification?.title ?? "No Title",
        body: message.notification?.body ?? "No Body",
        imageUrl: message.notification?.android?.imageUrl,
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification Clicked!");
    });

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }
}
