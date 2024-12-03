import 'dart:math';

import 'package:flutter/material.dart';

class WaveCircle extends StatefulWidget {
  final double progress; // Value between 0 and 1 representing the fill percentage.
  final Color waveColor;
  final Color borderColor;
  final double borderWidth;

  const WaveCircle({
    Key? key,
    this.progress = 0.5,
    this.waveColor = Colors.blue,
    this.borderColor = Colors.black, // Default border color
    this.borderWidth = 4.0,          // Default border width
  }) : super(key: key);

  @override
  _WaveCircleState createState() => _WaveCircleState();
}

class _WaveCircleState extends State<WaveCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _WavePainter(
            progress: widget.progress,
            waveColor: widget.waveColor,
            animationValue: _controller.value,
            borderColor: widget.borderColor,
            borderWidth: widget.borderWidth,
          ),
          child: const SizedBox(
            width: 250,
            height: 250,
          ),
        );
      },
    );
  }
}

class _WavePainter extends CustomPainter {
  final double progress; // Progress of the wave (0 to 1)
  final Color waveColor;
  final double animationValue; // Animation value for the wave motion
  final Color borderColor;
  final double borderWidth;

  _WavePainter({
    required this.progress,
    required this.waveColor,
    required this.animationValue,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    final circleCenter = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw border
    paint
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawCircle(circleCenter, radius, paint);

    // Draw wave
    paint
      ..color = waveColor
      ..style = PaintingStyle.fill;

    final path = Path();

    final waveHeight = size.height * 0.05; // Height of the wave
    final waveLength = size.width * 0.5; // Length of one wave

    // Clip to a circle
    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: circleCenter, radius: radius - borderWidth / 2)));

    // Start the wave path
    path.moveTo(0, size.height * (1 - progress));

    for (double i = 0; i <= size.width; i++) {
      double dx = i;
      double dy = size.height * (1 - progress) +
          sin((i / waveLength + animationValue * 2 * pi) * 2 * pi) * waveHeight;
      path.lineTo(dx, dy);
    }

    // Close the wave path
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
