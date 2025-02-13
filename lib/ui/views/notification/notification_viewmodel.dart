import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:oruphones/services/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class NotificationViewModel extends BaseViewModel {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  Future<void> requestNotificationPermission(BuildContext context) async {
    PermissionStatus status = await Permission.notification.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.notification.request();
    }

    if (status.isGranted) {
      setupFirebaseMessaging();
      fetchFcmToken();
    } else {
      print("User denied notification permissions");
      showPermissionDialog(context);
    }
  }

  /// Get FCM Token**
  Future<void> fetchFcmToken() async {
    String? fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token: $fcmToken");
  }

  //Setup Firebase Messaging**
  void setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground Notification: ${message.notification?.title}");
      NotificationService.showNotification(
        title: message.notification?.title ?? "No Title",
        body: message.notification?.body ?? "No Body",
        imageUrl: message.notification?.android?.imageUrl,
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Background Notification Clicked: ${message.notification?.title}");
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print("App Terminated Notification Clicked: ${message.notification?.title}");
      }
    });
  }

  //Show Permission Dialog**
  void showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Enable Notifications"),
        content: Text("To receive updates, please enable notifications in settings."),
        actions: [
          TextButton(
            onPressed: () async {
              await openAppSettings();
            },
            child: Text("Go to Settings"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
