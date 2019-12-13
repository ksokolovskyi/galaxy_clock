import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:galaxy_clock/clock/theme.dart';

class ClockCirclePainter extends CustomPainter {
  final double strokeWidth;

  final ClockTheme theme;

  ClockCirclePainter({
    this.strokeWidth = 50,
    this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final x = size.width / 2;
    final y = size.height / 2;
    final radius = size.height / 2;

    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [
          theme.startColor,
          theme.endColor,
        ],
      ).createShader(Rect.fromCircle(center: Offset(x, y), radius: 0))
      ..color = theme.endColor;

    canvas.save();
    canvas.rotate(-math.pi / 2);
    canvas.translate(-2 * x, 0);

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(x, y),
        radius: radius - strokeWidth / 2,
      ),
      0,
      math.pi * 2,
      false,
      paint,
    );

    canvas.restore();
    paint.shader = null;
    paint.style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(x - 1, strokeWidth / 2),
        radius: strokeWidth / 2,
      ),
      -math.pi / 2,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(ClockCirclePainter oldDelegate) {
    return oldDelegate.theme != theme || oldDelegate.strokeWidth != strokeWidth;
  }
}
