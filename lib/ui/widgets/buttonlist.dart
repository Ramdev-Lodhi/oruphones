import 'package:flutter/material.dart';

class Buttonlist extends StatelessWidget {
  final List<String> buttonLabels = [
    "Sell Used Phones",
    "Buy Used Phones",
    "Compare Price",
    "My Profile",
    "My Listing",
    "Services",
    "Register Your Store",
    "Get The App"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: buttonLabels.map((label) => _buildButton(label)).toList(),
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 1),
        color: Colors.white,
      ),
      child: TextButton(
        onPressed: () {
          print("$text Button Clicked");
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(text, style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
