import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Custom Drop Logo matching OilDri drop emblem
class AppDropLogo extends StatelessWidget {
  final double size;
  final Color color;

  const AppDropLogo({
    super.key,
    this.size = 38,
    this.color = const Color(0xFF013CA6),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size * 1.15),
      painter: _DropLogoPainter(color: color),
    );
  }
}

class _DropLogoPainter extends CustomPainter {
  final Color color;

  _DropLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final Path outerDrop = Path();
    final double w = size.width;
    final double h = size.height;

    // Outer tear-drop shape
    outerDrop.moveTo(w * 0.5, 0);
    outerDrop.cubicTo(
      w * 0.88, h * 0.42,
      w * 1.0, h * 0.62,
      w * 1.0, h * 0.75,
    );
    outerDrop.cubicTo(
      w * 1.0, h * 0.95,
      w * 0.78, h * 1.0,
      w * 0.5, h * 1.0,
    );
    outerDrop.cubicTo(
      w * 0.22, h * 1.0,
      0, h * 0.95,
      0, h * 0.75,
    );
    outerDrop.cubicTo(
      0, h * 0.62,
      w * 0.12, h * 0.42,
      w * 0.5, 0,
    );
    outerDrop.close();

    // Inner cutout teardrop
    final Path innerDrop = Path();
    innerDrop.moveTo(w * 0.5, h * 0.32);
    innerDrop.cubicTo(
      w * 0.72, h * 0.55,
      w * 0.75, h * 0.68,
      w * 0.75, h * 0.75,
    );
    innerDrop.cubicTo(
      w * 0.75, h * 0.86,
      w * 0.64, h * 0.88,
      w * 0.5, h * 0.88,
    );
    innerDrop.cubicTo(
      w * 0.36, h * 0.88,
      w * 0.25, h * 0.86,
      w * 0.25, h * 0.75,
    );
    innerDrop.cubicTo(
      w * 0.25, h * 0.68,
      w * 0.28, h * 0.55,
      w * 0.5, h * 0.32,
    );
    innerDrop.close();

    final Path finalPath = Path.combine(
      PathOperation.difference,
      outerDrop,
      innerDrop,
    );

    canvas.drawPath(finalPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _DropLogoPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Custom Sliders Icon (Calibration)
class CalibrationIcon extends StatelessWidget {
  final double size;
  final Color color;

  const CalibrationIcon({
    super.key,
    this.size = 24,
    this.color = const Color(0xFF7E8088),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CalibrationIconPainter(color: color),
    );
  }
}

class _CalibrationIconPainter extends CustomPainter {
  final Color color;

  _CalibrationIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.09
      ..strokeCap = StrokeCap.round;

    final Paint circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double w = size.width;
    final double h = size.height;
    final double r = w * 0.14;

    // Line 1 (left)
    double x1 = w * 0.22;
    canvas.drawLine(Offset(x1, h * 0.1), Offset(x1, h * 0.9), linePaint);
    canvas.drawCircle(Offset(x1, h * 0.35), r, circlePaint);

    // Line 2 (center)
    double x2 = w * 0.5;
    canvas.drawLine(Offset(x2, h * 0.1), Offset(x2, h * 0.9), linePaint);
    canvas.drawCircle(Offset(x2, h * 0.65), r, circlePaint);

    // Line 3 (right)
    double x3 = w * 0.78;
    canvas.drawLine(Offset(x3, h * 0.1), Offset(x3, h * 0.9), linePaint);
    canvas.drawCircle(Offset(x3, h * 0.4), r, circlePaint);
  }

  @override
  bool shouldRepaint(covariant _CalibrationIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Custom Balance Scale Icon (Catch Test)
class CatchTestIcon extends StatelessWidget {
  final double size;
  final Color color;

  const CatchTestIcon({
    super.key,
    this.size = 24,
    this.color = const Color(0xFF7E8088),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CatchTestIconPainter(color: color),
    );
  }
}

class _CatchTestIconPainter extends CustomPainter {
  final Color color;

  _CatchTestIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.075
      ..strokeCap = StrokeCap.round;

    final double w = size.width;
    final double h = size.height;

    // Central pillar
    canvas.drawLine(Offset(w * 0.5, h * 0.2), Offset(w * 0.5, h * 0.8), paint);
    // Base
    canvas.drawLine(Offset(w * 0.35, h * 0.8), Offset(w * 0.65, h * 0.8), paint);
    // Top bar
    canvas.drawLine(Offset(w * 0.15, h * 0.3), Offset(w * 0.85, h * 0.3), paint);
    // Top loop
    canvas.drawCircle(Offset(w * 0.5, h * 0.18), w * 0.05, paint);

    // Left pan strings & pan
    canvas.drawLine(Offset(w * 0.15, h * 0.3), Offset(w * 0.08, h * 0.55), paint);
    canvas.drawLine(Offset(w * 0.15, h * 0.3), Offset(w * 0.22, h * 0.55), paint);
    canvas.drawArc(
      Rect.fromLTRB(w * 0.05, h * 0.55, w * 0.25, h * 0.65),
      0,
      math.pi,
      false,
      paint,
    );

    // Right pan strings & pan
    canvas.drawLine(Offset(w * 0.85, h * 0.3), Offset(w * 0.78, h * 0.55), paint);
    canvas.drawLine(Offset(w * 0.85, h * 0.3), Offset(w * 0.92, h * 0.55), paint);
    canvas.drawArc(
      Rect.fromLTRB(w * 0.75, h * 0.55, w * 0.95, h * 0.65),
      0,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CatchTestIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Custom Scalloped Badge with Checkmark Icon (Quality Check)
class QualityCheckBadgeIcon extends StatelessWidget {
  final double size;
  final Color color;

  const QualityCheckBadgeIcon({
    super.key,
    this.size = 24,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _QualityCheckBadgePainter(color: color),
    );
  }
}

class _QualityCheckBadgePainter extends CustomPainter {
  final Color color;

  _QualityCheckBadgePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.085
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double w = size.width;
    final double h = size.height;
    final double cx = w / 2;
    final double cy = h / 2;
    final double radius = w * 0.42;

    final Path badgePath = Path();
    const int points = 12;

    for (int i = 0; i < points; i++) {
      final double angle = (i * 2 * math.pi) / points;
      final double nextAngle = ((i + 1) * 2 * math.pi) / points;
      final double midAngle = (angle + nextAngle) / 2;

      final double px = cx + radius * math.cos(angle);
      final double py = cy + radius * math.sin(angle);

      final double rBump = radius * 1.1;
      final double bx = cx + rBump * math.cos(midAngle);
      final double by = cy + rBump * math.sin(midAngle);

      final double npx = cx + radius * math.cos(nextAngle);
      final double npy = cy + radius * math.sin(nextAngle);

      if (i == 0) {
        badgePath.moveTo(px, py);
      }
      badgePath.quadraticBezierTo(bx, by, npx, npy);
    }
    badgePath.close();

    canvas.drawPath(badgePath, paint);

    // Checkmark inside badge
    final Path checkPath = Path();
    checkPath.moveTo(w * 0.35, h * 0.5);
    checkPath.lineTo(w * 0.46, h * 0.62);
    checkPath.lineTo(w * 0.66, h * 0.38);

    canvas.drawPath(checkPath, paint);
  }

  @override
  bool shouldRepaint(covariant _QualityCheckBadgePainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Custom Right Arrow Icon
class RightArrowIcon extends StatelessWidget {
  final double size;
  final Color color;

  const RightArrowIcon({
    super.key,
    this.size = 20,
    this.color = const Color(0xFF000000),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size * 0.6),
      painter: _RightArrowPainter(color: color),
    );
  }
}

class _RightArrowPainter extends CustomPainter {
  final Color color;

  _RightArrowPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height * 0.15
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double w = size.width;
    final double h = size.height;

    // Horizontal shaft
    canvas.drawLine(Offset(0, h * 0.5), Offset(w, h * 0.5), paint);

    // Arrowhead
    final Path head = Path();
    head.moveTo(w * 0.7, h * 0.1);
    head.lineTo(w, h * 0.5);
    head.lineTo(w * 0.7, h * 0.9);

    canvas.drawPath(head, paint);
  }

  @override
  bool shouldRepaint(covariant _RightArrowPainter oldDelegate) =>
      oldDelegate.color != color;
}
