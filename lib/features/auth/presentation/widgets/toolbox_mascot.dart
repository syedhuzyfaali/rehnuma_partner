import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ToolboxMascot extends StatelessWidget {
  final double size;

  const ToolboxMascot({super.key, this.size = 220});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background soft circular halo
          Container(
            width: size * 0.9,
            height: size * 0.9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentLightBlue.withOpacity(0.6),
            ),
          ),
          // Toolbox Body Illustration
          CustomPaint(
            size: Size(size * 0.85, size * 0.85),
            painter: _ToolboxPainter(),
          ),
        ],
      ),
    );
  }
}

class _ToolboxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Sparkles
    final sparklePaint = Paint()
      ..color = AppColors.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    _drawSparkle(canvas, Offset(w * 0.1, h * 0.35), 8, sparklePaint);

    // Shadow on ground
    final shadowPaint = Paint()..color = const Color(0xFFD6E4F0);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.5, h * 0.88), width: w * 0.65, height: h * 0.08),
      shadowPaint,
    );

    // Toolbox Feet
    final footPaint = Paint()..color = const Color(0xFF1E293B);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.28, h * 0.80, w * 0.12, h * 0.09),
        const Radius.circular(8),
      ),
      footPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.60, h * 0.80, w * 0.12, h * 0.09),
        const Radius.circular(8),
      ),
      footPaint,
    );

    // Toolbox Main Body
    final bodyPaint = Paint()..color = const Color(0xFF0084FF);
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.20, h * 0.32, w * 0.60, h * 0.50),
      const Radius.circular(24),
    );
    canvas.drawRRect(bodyRect, bodyPaint);

    // Arms
    final armPaint = Paint()
      ..color = const Color(0xFF0072E0)
      ..style = PaintingStyle.fill;
    // Left arm
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.13, h * 0.44, w * 0.08, h * 0.18),
        const Radius.circular(10),
      ),
      armPaint,
    );
    // Right arm
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.79, h * 0.44, w * 0.08, h * 0.18),
        const Radius.circular(10),
      ),
      armPaint,
    );

    // Toolbox Lid divider stripe
    final lidStripe = Paint()..color = const Color(0xFF006ECC);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.20, h * 0.44, w * 0.60, h * 0.04),
        const Radius.circular(4),
      ),
      lidStripe,
    );

    // Handle on top
    final handlePaint = Paint()
      ..color = const Color(0xFF006ECC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round;
    final handlePath = Path()
      ..moveTo(w * 0.38, h * 0.32)
      ..lineTo(w * 0.38, h * 0.24)
      ..lineTo(w * 0.62, h * 0.24)
      ..lineTo(w * 0.62, h * 0.32);
    canvas.drawPath(handlePath, handlePaint);

    // Front Metal Latch
    final latchPaint = Paint()..color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.45, h * 0.38, w * 0.10, h * 0.12),
        const Radius.circular(6),
      ),
      latchPaint,
    );

    // Eyes
    final eyePaint = Paint()..color = const Color(0xFF0F243A);
    canvas.drawCircle(Offset(w * 0.38, h * 0.60), 5.5, eyePaint);
    canvas.drawCircle(Offset(w * 0.62, h * 0.60), 5.5, eyePaint);

    // Cheeks
    final cheekPaint = Paint()..color = const Color(0xFF90C2FF);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.33, h * 0.64), width: 14, height: 7),
      cheekPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.67, h * 0.64), width: 14, height: 7),
      cheekPaint,
    );

    // Smile
    final smilePaint = Paint()
      ..color = const Color(0xFF0F243A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final smilePath = Path()
      ..moveTo(w * 0.44, h * 0.63)
      ..quadraticBezierTo(w * 0.50, h * 0.70, w * 0.56, h * 0.63);
    canvas.drawPath(smilePath, smilePaint);

    // Clock icon near right ear
    final clockCenter = Offset(w * 0.78, h * 0.34);
    final clockRadius = w * 0.12;
    canvas.drawCircle(clockCenter, clockRadius, Paint()..color = Colors.white);
    canvas.drawCircle(
      clockCenter,
      clockRadius,
      Paint()
        ..color = AppColors.borderLight
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    // Clock hands
    final clockHandPaint = Paint()
      ..color = AppColors.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(clockCenter, Offset(clockCenter.dx, clockCenter.dy - 12), clockHandPaint);
    canvas.drawLine(clockCenter, Offset(clockCenter.dx + 10, clockCenter.dy), clockHandPaint);
  }

  void _drawSparkle(Canvas canvas, Offset center, double size, Paint paint) {
    canvas.drawLine(Offset(center.dx - size, center.dy), Offset(center.dx + size, center.dy), paint);
    canvas.drawLine(Offset(center.dx, center.dy - size), Offset(center.dx, center.dy + size), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}