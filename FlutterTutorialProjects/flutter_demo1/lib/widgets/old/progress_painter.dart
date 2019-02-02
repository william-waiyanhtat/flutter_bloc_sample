import 'package:flutter/material.dart';
import 'dart:math';

class ProgressPainter extends CustomPainter {
  //
  Color defaultCircleColor;
  Color percentageCompletedCircleColor;
  double completedPercent;
  double circleWidth;

  ProgressPainter(
      {this.defaultCircleColor,
      this.percentageCompletedCircleColor,
      this.completedPercent,
      this.circleWidth});

  @override
  void paint(Canvas canvas, Size size) {
    // Paint helps to draw something on the screen //
    Paint defaultCirclePaint = getPaint(defaultCircleColor);
    Paint progressCirclePaint = getPaint(percentageCompletedCircleColor);

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, defaultCirclePaint);

    double arcAngle = 2 * pi * (completedPercent / 100);
    // rect of the arc, Then we give a start angle,
    // which is -pi/2radians, keep in mind its not 0.
    // The top is -pi/2, 0 is the right-most point of the circle.
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, progressCirclePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  getPaint(Color lineColor) {
    return new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth;
  }
}
