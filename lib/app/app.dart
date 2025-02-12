import 'package:flutter/material.dart';
import 'package:stacked/stacked_annotations.dart';
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
    MaterialRoute(page: HomeView),
  ],
)
class AppRouter {}
