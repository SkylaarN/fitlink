import 'package:flutter/material.dart';

class LineDivider extends StatelessWidget {
  final double hieght;
  // final double width;
  final Color color;
  const LineDivider({super.key, this.hieght = 7, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hieght,
      color: color,
    );
  }
}
