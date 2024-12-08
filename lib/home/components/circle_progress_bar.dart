import 'package:flutter/material.dart';

class CircleProgressBar extends StatelessWidget {
  final double heightWidth;
  final String label;
  final double value;
  final IconData icon; 
  final VoidCallback? onTap; 
  final int noSteps;

  const CircleProgressBar({
    super.key,
    required this.heightWidth,
    required this.label,
    required this.value,
    required this.icon,
    this.onTap, required this.noSteps, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        height: 60,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.blueGrey[800],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Circular progress bar
                  SizedBox(
                    height: heightWidth,
                    width: heightWidth,
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 8,
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.blue,
                    ),
                  ),
                  // Icon in the middle of the circle
                  Icon(
                    icon,
                    size: 10,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    noSteps.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
