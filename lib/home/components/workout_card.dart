import 'package:flutter/material.dart';

import 'headings.dart';

class WorkoutCard extends StatelessWidget {
  final String imagePath;
  const WorkoutCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: Container(
        height: 180,
        width: 300,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Heading(headingText: "testing", headingSize: 18),
        ),
      ),
    );
  }
}
