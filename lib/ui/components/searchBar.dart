import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 60;
  @override
  double get maxExtent => 60;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.white.withOpacity(0.9),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, size: 20),
          suffixIcon: Icon(Icons.mic_none, size: 20),
          hintText: 'Search...',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        ),
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  @override
  bool shouldRebuild(_SearchBarDelegate oldDelegate) => false;
}