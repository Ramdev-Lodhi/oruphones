import 'package:oruphones/services/MyFirebaseMessagingService.dart';
import 'package:oruphones/services/api_service.dart';
import 'package:oruphones/services/filter_service.dart';
import 'package:oruphones/services/notification_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../services/auth_service.dart';
import '../services/product_service.dart';

final locator = StackedLocator.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => ProductService());
  locator.registerLazySingleton(() => FilterService());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => MyFirebaseMessagingService());
}