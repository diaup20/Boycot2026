import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  final double size;
  const CustomCircularProgressIndicator({super.key, this.size = 90});

  @override
  State<CustomCircularProgressIndicator> createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = widget.size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: _MiniRingPainter(progress: _controller.value),
          child: SizedBox(
            width: size,
            height: size,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.hub,
                    size: 24,
                    color: kPrimaryColor.withOpacity(0.95),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MiniRingPainter extends CustomPainter {
  final double progress;
  _MiniRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 4;
    double radius = (size.width - strokeWidth) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final glowPaint = Paint()
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 2 * pi,
        colors: [
          kPrimaryColor.withOpacity(0.1),
          kPrimaryColor.withOpacity(0.5),
          kPrimaryColor.withOpacity(0.8),
          kPrimaryColor.withOpacity(0.2),
        ],
        stops: const [0.0, 0.3, 0.7, 1.0],
        transform: GradientRotation(progress * 2 * pi),
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, glowPaint);

    for (int i = 0; i < 3; i++) {
      final angle = (progress + i * 0.33) * 2 * pi;
      final point = Offset(
        center.dx + cos(angle) * radius * 0.85,
        center.dy + sin(angle) * radius * 0.85,
      );

      final pulsePaint = Paint()
        ..color = kPrimaryColor.withOpacity(0.7)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(point, 2.5, pulsePaint);
    }

    final pulse = Paint()
      ..color = kPrimaryColor.withOpacity(0.25 + 0.15 * sin(progress * 2 * pi))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius * 0.9, pulse);
  }

  @override
  bool shouldRepaint(covariant _MiniRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
