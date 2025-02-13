import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/auth_service.dart';

import 'package:stacked_services/stacked_services.dart';

class VerifyOtpViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final String phoneNumber;
  List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());
  BuildContext? context;
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  bool isTimerActive = true;
  int timerSeconds = 30;

  VerifyOtpViewModel(this.phoneNumber) {
    _startTimer();
    otpControllers = List.generate(4, (index) => TextEditingController());
    focusNodes = List.generate(4, (index) => FocusNode());
  }

  bool get isOtpComplete =>
      otpControllers.every((controller) => controller.text.isNotEmpty);

  void _startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerSeconds > 0) {
        timerSeconds--;
        notifyListeners();
      } else {
        isTimerActive = false;
        notifyListeners();
        timer.cancel();
      }
    });
  }

  void resendOTP() {
    isTimerActive = true;
    timerSeconds = 30;
    notifyListeners();
    _startTimer();
    _authService.sendOTP(phoneNumber);
  }

  Future<void> verifyOTP(BuildContext context) async {
    setBusy(true);
    String otp = otpControllers.map((controller) => controller.text).join();
    print("Entered OTP: $otp");
    bool success = await _authService.verifyOTP(phoneNumber, otp);
    setBusy(false);
    if (success) {
      print(_authService.currentUser?.userName);
      if (_authService.currentUser?.userName != null && _authService.currentUser!.userName.isNotEmpty) {
        _navigationService.clearStackAndShow(Routes.mainView);
      } else {
        _navigationService.clearStackAndShow(Routes.confirmNameView);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP, please try again")),
      );
    }
  }
}
