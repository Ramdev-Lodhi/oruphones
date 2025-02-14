import 'package:flutter/material.dart';
import 'package:oruphones/ui/views/filter/filterproduct_view.dart';
import 'package:stacked/stacked_annotations.dart';
import '../ui/views/main/main_view.dart';
import '../ui/views/splash/splash_view.dart';
import '../ui/views/auth/login_view.dart';
import '../ui/views/auth/verify_otp_view.dart';
import '../ui/views/auth/confirm_name_view.dart';
import '../ui/views/home/home_view.dart';


@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: VerifyOtpView),
    MaterialRoute(page: ConfirmNameView),
    MaterialRoute(page: MainView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: FilterproductView, guards: []),
  ],
)
class AppRouter {}
