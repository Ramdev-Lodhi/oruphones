import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:oruphones/services/MyFirebaseMessagingService.dart';
import 'package:oruphones/services/auth_service.dart';
import 'package:oruphones/services/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'state/auth_bloc.dart';
import 'state/theme_provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background Message Received: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.initialize();
  await MyFirebaseMessagingService.initialize();
  setupLocator();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        BlocProvider(create: (_) => AuthBloc(locator<AuthService>())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    checkAndRequestNotificationPermission();
  }


  Future<void> checkAndRequestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      print("Notification Permission Denied! Requesting...");
      status = await Permission.notification.request();
    }

    if (status.isGranted) {
      print(" Notification Permission Granted!");
      setupFirebaseMessaging();
      fetchFcmToken();
    } else {
      print(" User denied notification permissions");
    }
  }


  Future<void> fetchFcmToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $fcmToken");
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ORUPhones',
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      initialRoute: Routes.splashView,
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
