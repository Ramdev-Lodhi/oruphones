import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import 'confirm_name_viewmodel.dart';

class ConfirmNameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConfirmNameViewModel>.reactive(
      viewModelBuilder: () => ConfirmNameViewModel(),
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
              _buildNextButton(viewModel, context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            locator<NavigationService>().clearStackAndShow(Routes
                .homeView);
          },
        ),
      ],
    );
  }

  Widget _buildLogoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/logo/oruphones.png",
            width: 136, height: 80, fit: BoxFit.contain),
        SizedBox(height: 45),
        Text("Welcome",
            style: _textStyle(28, FontWeight.w600, Color(0xFF3F3E8F))),
        Text("SignUp to continue",
            style: _textStyle(14, FontWeight.w400, Color(0xFF707070))),
      ],
    );
  }

  Widget _buildPhoneNumberField(ConfirmNameViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "Please Tell Us Your Name ", // Normal text
            style: _textStyle(12, FontWeight.bold, Color(0xFF707070)),
            children: [
              TextSpan(
                text: "*", // Asterisk (*)
                style: _textStyle(12, FontWeight.bold, Colors.red), // 🔴 Red color for '*'
              ),
            ],
          ),
        ),
        TextField(
          onChanged: viewModel.updateName,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            border: _inputBorder(),
            focusedBorder: _inputBorder(),
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            hintText: "Name",
            hintStyle: _textStyle(14, FontWeight.w400, Color(0xFFCCCCCC)),
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton(
      ConfirmNameViewModel viewModel, BuildContext context) {
    return SizedBox(
      width: 358,
      height: 55,
      child: ElevatedButton(
        onPressed:
            viewModel.isButtonEnabled ? () => viewModel.saveName() : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor:
              viewModel.isButtonEnabled ? Color(0xFF3F3E8F) : Color(0xFFB1B1B1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Confirm Name",
                style: _textStyle(16, FontWeight.w600, Colors.white)),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle(double size, FontWeight weight, Color color) {
    return TextStyle(
        fontFamily: 'Poppins',
        fontSize: size,
        fontWeight: weight,
        color: color);
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Color(0xFFCCCCCC), width: 1),
    );
  }
}
