import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.63),
        border: Border.all(color: Colors.grey, width: 1),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.search, color: Colors.orangeAccent),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search phones with make, model...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10),
              ),
              style: TextStyle(fontSize: 16),
            ),
          ),
          Icon(Icons.mic_none, color: Colors.grey),
        ],
      ),
    );
  }
}
