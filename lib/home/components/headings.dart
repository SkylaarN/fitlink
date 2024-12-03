import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String headingText;
  final double headingSize;
  final Color color;
  const Heading(
      {super.key, required this.headingText, required this.headingSize, this.color = Colors.white54});

  @override
  Widget build(BuildContext context) {
    return Text(headingText,
        style: TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: headingSize,
            color: color,
            letterSpacing: 2));
  }
}
