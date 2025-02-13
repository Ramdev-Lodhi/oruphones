import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    String? localImagePath;

    if (imageUrl != null) {
      try {
        final Dio dio = Dio();
        final Directory tempDir = await getTemporaryDirectory();
        final String filePath = '${tempDir.path}/notification_image.jpg';
        await dio.download(imageUrl, filePath);
        localImagePath = filePath;
      } catch (e) {
        print('Error downloading image: $e');
      }
    }

    final BigPictureStyleInformation? bigPictureStyleInformation =
    localImagePath != null
        ? BigPictureStyleInformation(
      FilePathAndroidBitmap(localImagePath),
      contentTitle: title,
      summaryText: body,
    )
        : null;

    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General Notifications',
      importance: Importance.max,
      priority: Priority.high,
      largeIcon: localImagePath != null
          ? FilePathAndroidBitmap(localImagePath)
          : null,
      styleInformation: bigPictureStyleInformation,
    );

    final NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
    );
  }
}
