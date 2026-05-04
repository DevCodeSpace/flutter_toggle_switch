import 'package:flutter/material.dart';

/// Paints a rounded-rectangle border using a gradient.
///
/// Upgraded:
///  - Supports an [animationValue] so gradient can rotate/shift smoothly.
///  - `shouldRepaint` now returns true when relevant fields change.
class CustomBorderPaint extends CustomPainter {
  final double thickness;
  final Radius radius;
  final Gradient gradient;

  /// 0.0 → 1.0 rolling value used to animate the gradient sweep.
  final double animationValue;

  CustomBorderPaint({
    this.thickness = 8.0,
    this.radius = const Radius.circular(12),
    this.gradient = const LinearGradient(
      colors: [Colors.transparent, Colors.transparent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    this.animationValue = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Rect rectMaxSized = Rect.fromCenter(
      center: center,
      width: size.width,
      height: size.height,
    );
    final Rect innerSpace = Rect.fromCenter(
      center: center,
      width: size.width - thickness * 2,
      height: size.height - thickness * 2,
    );

    // If the gradient is a SweepGradient we rotate it using animationValue.
    Shader shader;
    if (gradient is SweepGradient && animationValue != 0.0) {
      final sweep = gradient as SweepGradient;
      final rotated = SweepGradient(
        colors: sweep.colors,
        stops: sweep.stops,
        startAngle: sweep.startAngle,
        endAngle: sweep.endAngle,
        transform: GradientRotation(animationValue * 6.28318),
        tileMode: sweep.tileMode,
      );
      shader = rotated.createShader(rectMaxSized);
    } else {
      shader = gradient.createShader(rectMaxSized);
    }

    final Paint paint = Paint()..shader = shader;

    canvas.drawDRRect(
      RRect.fromRectAndCorners(
        rectMaxSized,
        bottomLeft: radius,
        bottomRight: radius,
        topLeft: radius,
        topRight: radius,
      ),
      RRect.fromRectAndCorners(
        innerSpace,
        bottomLeft: radius,
        bottomRight: radius,
        topLeft: radius,
        topRight: radius,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomBorderPaint oldDelegate) {
    return oldDelegate.thickness != thickness ||
        oldDelegate.radius != radius ||
        oldDelegate.gradient != gradient ||
        oldDelegate.animationValue != animationValue;
  }
}
