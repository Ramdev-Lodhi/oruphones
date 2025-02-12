import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLogoSection(),
              _buildPhoneNumberField(viewModel),
              Column(
                children: [
                  _buildTermsAndConditions(viewModel),
                  _buildNextButton(viewModel, context),
                ],
              ),
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
        Text("Welcome", style: _textStyle(28, FontWeight.w600, Color(0xFF3F3E8F))),
        Text("Sign in to continue", style: _textStyle(14, FontWeight.w400, Color(0xFF707070))),
      ],
    );
  }

  Widget _buildPhoneNumberField(LoginViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Enter Your Phone Number", style: _textStyle(12, FontWeight.bold, Color(0xFF707070))),
        TextField(
          onChanged: viewModel.updatePhoneNumber,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            border: _inputBorder(),
            focusedBorder: _inputBorder(),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 16, right: 10),
              child: Text("+91", style: _textStyle(14, FontWeight.w400, Colors.black)),
            ),
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            hintText: "Mobile Number",
            hintStyle: _textStyle(14, FontWeight.w400, Color(0xFFCCCCCC)),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions(LoginViewModel viewModel) {
    return Row(
      children: [
        Checkbox(
          value: viewModel.isChecked,
          activeColor: Colors.green,
          onChanged: viewModel.updateCheckBox,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "Accept ",
                  style: _textStyle(14, FontWeight.w400, Colors.black)),
              WidgetSpan(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Terms and Conditions",
                    style: _textStyle(14, FontWeight.w400, Color(0xFF3F3E8F))
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton(LoginViewModel viewModel, BuildContext context) {
    return SizedBox(
      width: 358,
      height: 55,
      child: ElevatedButton(
        onPressed: viewModel.isButtonEnabled ? () => viewModel.sendOTP(context) : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: viewModel.isChecked ? Color(0xFF3F3E8F) : Color(0xFFB1B1B1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Next", style: _textStyle(16, FontWeight.w600, Colors.white)),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle(double size, FontWeight weight, Color color) {
    return TextStyle(fontFamily: 'Poppins', fontSize: size, fontWeight: weight, color: color);
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Color(0xFFCCCCCC), width: 1),
    );
  }
}
