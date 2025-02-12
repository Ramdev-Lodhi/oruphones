import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/auth_service.dart';

class LoginViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String phoneNumber = '';
  bool isChecked = false;

  bool get isButtonEnabled => isChecked && phoneNumber.length == 10;

  void updatePhoneNumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  void updateCheckBox(bool? value) {
    isChecked = value ?? false;
    notifyListeners();
  }

  Future<void> sendOTP(BuildContext context) async {
    setBusy(true);
    print("Sending OTP to: $phoneNumber");

    bool success = await _authService.sendOTP(phoneNumber);
    setBusy(false);

    if (success) {
      print("✅ OTP Sent Successfully");
      _navigationService.navigateTo(
        Routes.verifyOtpView,
        arguments: VerifyOtpViewArguments(phoneNumber: phoneNumber),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send OTP")),
      );
    }
  }
}
