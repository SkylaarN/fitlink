import 'package:flutter/material.dart';
import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeptagonProgressBar extends StatelessWidget {
  final double progress; 
  final double size; 
  final Color backgroundColor; 
  final Color progressColor; 
  final TextStyle? textStyle; 

  const HeptagonProgressBar({
    super.key,
    required this.progress,
    this.size = 250,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.progressColor = Colors.blue,
    this.textStyle = const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CustomPaint(
        painter: HeptagonProgressPainter(
          progress,
          backgroundColor: backgroundColor,
          progressColor: progressColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                FontAwesomeIcons.solidHeart, 
                size: 20.0,
                color: Colors.pink,
              ),
                SizedBox(width: 10,),
                Text(
                  "Heart health",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              "${(progress * 100).toInt()}%", // Display progress percentage
              style: textStyle,
            ),
            const Text("This Week")

          ],
        ),
      ),
    );
  }
}

class HeptagonProgressPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  HeptagonProgressPainter(
    this.progress, {
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final List<Offset> heptagonPoints = _getPolygonPoints(size, 7);

    // Draw the heptagon background
    for (int i = 0; i < heptagonPoints.length; i++) {
      canvas.drawLine(
        heptagonPoints[i],
        heptagonPoints[(i + 1) % heptagonPoints.length],
        backgroundPaint,
      );
    }

    // Draw the progress part
    double progressPoints = heptagonPoints.length * progress;
    for (int i = 0; i < progressPoints.toInt(); i++) {
      canvas.drawLine(
        heptagonPoints[i],
        heptagonPoints[(i + 1) % heptagonPoints.length],
        progressPaint,
      );
    }

    // Draw partial segment for non-integer progress
    if (progressPoints % 1 > 0) {
      final int lastIndex = progressPoints.toInt();
      final Offset start = heptagonPoints[lastIndex];
      final Offset end = heptagonPoints[(lastIndex + 1) % heptagonPoints.length];
      final Offset partialPoint = Offset(
        start.dx + (end.dx - start.dx) * (progressPoints % 1),
        start.dy + (end.dy - start.dy) * (progressPoints % 1),
      );
      canvas.drawLine(start, partialPoint, progressPaint);
    }
  }

  List<Offset> _getPolygonPoints(Size size, int sides) {
    final double radius = size.width / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double angle = (2 * pi) / sides;

    return List.generate(sides, (index) {
      final double x = centerX + radius * cos(angle * index + pi / 2); 
      final double y = centerY + radius * sin(angle * index + pi / 2); 
      return Offset(x, y);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

