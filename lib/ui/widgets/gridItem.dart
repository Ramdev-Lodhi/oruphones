import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const GridItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: color),
          SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: color),
          ),
        ],
      ),
    );
  }
}
