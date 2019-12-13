import 'package:flutter/material.dart';
import 'package:galaxy_clock/clock/painter.dart';
import 'package:galaxy_clock/clock/theme.dart';

class ClockCircle extends StatelessWidget {
  final double diameter;

  final double strokeWidht;

  final ClockTheme theme;

  final double angleRadians;

  ClockCircle({
    this.diameter,
    this.strokeWidht,
    this.theme,
    this.angleRadians,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angleRadians,
      alignment: Alignment.center,
      child: CustomPaint(
        painter: ClockCirclePainter(
          strokeWidth: strokeWidht,
          theme: theme,
        ),
        child: Container(
          height: diameter,
          width: diameter,
        ),
      ),
    );
  }
}
