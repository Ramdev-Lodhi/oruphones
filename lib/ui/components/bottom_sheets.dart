import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.locator.dart';
import '../../../services/auth_service.dart';
import '../widgets/custom_bottomsheet.dart';
final AuthService _authService = locator<AuthService>();
void showLoginBottomSheet(BuildContext context) {
  TextEditingController phoneController = TextEditingController();
  bool isChecked = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return CustomBottomsheet(
          title: "Sign in to continue",
          description: Text("Enter Your Phone Number"),
          buttonText: "Next",
          inputFields: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("+91", style: TextStyle(fontSize: 16)),
                ),
                hintText: "Mobile Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                const Text("Accept "),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Terms and condition",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
          onButtonPressed: () async {
            if (isChecked) {
              String phoneNumber = phoneController.text.trim();
              if (phoneNumber.isNotEmpty) {
                bool success = await _authService.sendOTP(phoneNumber);
                if (success) {
                  Navigator.pop(context);
                  showOtpBottomSheet(context, phoneNumber);
                }
              }
            }
          },
        );
      });
    },
  );
}

void showOtpBottomSheet(BuildContext context, String phoneNumber) {
  List<TextEditingController> otpControllers =
  List.generate(4, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return CustomBottomsheet(
        title: "Verify OTP",
        description: Align(
          alignment: Alignment.center,
          child: Text(
            "Please enter the 4-digit verification code sent to your mobile number +91-$phoneNumber via SMS",
          ),
        ),
        buttonText: "Verify OTP",
        showBackButton: true,
        inputFields: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              return SizedBox(
                width: 50,
                child: TextField(
                  controller: otpControllers[index],
                  focusNode: focusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  decoration: const InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {
                    if (value.isEmpty && index > 0) {
                      FocusScope.of(context)
                          .requestFocus(focusNodes[index - 1]);
                    } else if (value.isNotEmpty && index < 3) {
                      FocusScope.of(context)
                          .requestFocus(focusNodes[index + 1]);
                    }
                  },
                ),
              );
            }),
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                const Text(
                  "Didn't receive OTP?",
                  style: TextStyle(fontSize: 14),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Resend OTP in 0:23 Sec"),
                ),
              ],
            ),
          ),
        ],
        onButtonPressed: () async {
          String otp =
          otpControllers.map((controller) => controller.text).join();
          if (otp.length == 4) {
            bool success = await _authService.verifyOTP(phoneNumber, otp);
            if (success) {
              bool res = await _authService.isLoggedIn();
              if(res){
                var userName=_authService.currentUser?.userName;
                print(userName);
                if(userName != null && userName.isNotEmpty){
                  Navigator.pop(context);
                }else{
                  showSignUpBottomSheet(context);
                }
              }
            }
          }
        },
      );
    },
  );
}

void showSignUpBottomSheet(BuildContext context) {
  TextEditingController nameController = TextEditingController();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return CustomBottomsheet(
        title: "Sign Up to continue",
        description: RichText(
          text: TextSpan(
            text: "Please Tell Us Your Name ",
            style: TextStyle(fontSize: 14, color: Colors.black),
            children: [
              TextSpan(
                text: "*",
                style:
                TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        buttonText: "Confirm Name",
        inputFields: [
          TextField(
            controller: nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
        onButtonPressed: () async {
          String name = nameController.text.trim();
          if (name.isNotEmpty) {
            bool res = await _authService.updateUserName(name);
            Navigator.pop(context);
          }
        },
      );
    },
  );
}
