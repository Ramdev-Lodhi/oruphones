import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'verify_otp_viewmodel.dart';

class VerifyOtpView extends StatelessWidget {
  final String phoneNumber;

  VerifyOtpView({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyOtpViewModel>.reactive(
      viewModelBuilder: () => VerifyOtpViewModel(phoneNumber),
      onModelReady: (viewModel) {
        viewModel.context = context; // ✅ Fix: Assign context to ViewModel
      },
      builder: (context, viewModel, child) => Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLogoSection(),
              _buildOtpFields(context,viewModel),
              _buildResendOtp(viewModel),
              _buildVerifyButton(context, viewModel),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(icon: Icon(Icons.cancel), onPressed: () => Navigator.pop(context)),
      ],
    );
  }
  Widget _buildLogoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/logo/oruphones.png", width: 136, height: 80, fit: BoxFit.contain),
        SizedBox(height: 45),
        Text("Verify Mobile No.", style: _textStyle(28, FontWeight.w600, Color(0xFF3F3E8F))),
        SizedBox(height: 10),
        Text(
          "Please enter the 4 digit verification code sent to your mobile number $phoneNumber via SMS",
          textAlign: TextAlign.center,
          style: _textStyle(14, FontWeight.w400, Color(0xFF707070)),
        ),
      ],
    );
  }

  Widget _buildOtpFields(BuildContext context, VerifyOtpViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 50,
          child: TextField(
            controller: viewModel.otpControllers[index],
            focusNode: viewModel.focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: "",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                if (index < 3) {
                  Future.delayed(Duration(milliseconds: 100), () {
                    viewModel.focusNodes[index + 1].requestFocus();
                  });
                } else {
                  FocusScope.of(context).unfocus();
                }
              } else if (value.isEmpty && index > 0) {
                Future.delayed(Duration(milliseconds: 100), () {
                  viewModel.focusNodes[index - 1].requestFocus();
                });
              }
              viewModel.notifyListeners();
            },
          ),
        );
      }),
    );
  }

  Widget _buildResendOtp(VerifyOtpViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Text("Didn't receive OTP?", style: _textStyle(14, FontWeight.w600, Color(0xFF757474))),
          viewModel.isTimerActive
              ? Text("Resend OTP in ${viewModel.timerSeconds}s", style: _textStyle(14, FontWeight.w400, Color(0xFF191919)))
              : GestureDetector(
            onTap: viewModel.resendOTP,
            child: Text("Resend OTP", style: _textStyle(14, FontWeight.w600, Color(0xFF191919))),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyButton(BuildContext context, VerifyOtpViewModel viewModel) {
    return SizedBox(
      width: 358,
      height: 55,
      child: ElevatedButton(
        onPressed: viewModel.isOtpComplete ? () => viewModel.verifyOTP(context) : null, // ✅ Pass context
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: viewModel.isOtpComplete ? Color(0xFF3F3E8F) : Color(0xFFB1B1B1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Verify OTP", style: _textStyle(16, FontWeight.w600, Colors.white)),
            SizedBox(width: 10),
            Icon(Icons.check, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle(double size, FontWeight weight, Color color) {
    return TextStyle(fontFamily: 'Poppins', fontSize: size, fontWeight: weight, color: color);
  }
}
