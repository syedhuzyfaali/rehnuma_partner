import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class HandymanIllustration extends StatelessWidget {
  final double size;

  const HandymanIllustration({super.key, this.size = 200});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background soft circle halo
          Container(
            width: size * 0.9,
            height: size * 0.9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE8F3FD).withOpacity(0.8),
            ),
          ),
          CustomPaint(
            size: Size(size * 0.9, size * 0.9),
            painter: _HandymanPainter(),
          ),
        ],
      ),
    );
  }
}

class _HandymanPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Sparkles
    final sparklePaint = Paint()
      ..color = AppColors.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    _drawSparkle(canvas, Offset(w * 0.12, h * 0.35), 7, sparklePaint);
    _drawSparkle(canvas, Offset(w * 0.88, h * 0.36), 7, sparklePaint);

    // Sink cabinet in background
    final sinkCabinetPaint = Paint()..color = const Color(0xFFF1F5F9);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.65, h * 0.44, w * 0.28, h * 0.42),
        const Radius.circular(8),
      ),
      sinkCabinetPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.65, h * 0.44, w * 0.28, h * 0.42),
        const Radius.circular(8),
      ),
      Paint()
        ..color = const Color(0xFFCBD5E1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Faucet Pipe
    final faucetPaint = Paint()
      ..color = const Color(0xFF0072C6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    final faucetPath = Path()
      ..moveTo(w * 0.76, h * 0.42)
      ..lineTo(w * 0.76, h * 0.30)
      ..cubicTo(w * 0.76, h * 0.22, w * 0.88, h * 0.22, w * 0.88, h * 0.32);
    canvas.drawPath(faucetPath, faucetPaint);

    // Handyman Feet
    final shoePaint = Paint()..color = const Color(0xFF1E293B);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.32, h * 0.82, w * 0.14, h * 0.08), const Radius.circular(8)),
      shoePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.50, h * 0.82, w * 0.14, h * 0.08), const Radius.circular(8)),
      shoePaint,
    );

    // Legs
    final trouserPaint = Paint()..color = const Color(0xFF0072C6);
    canvas.drawRect(Rect.fromLTWH(w * 0.34, h * 0.70, w * 0.12, h * 0.14), trouserPaint);
    canvas.drawRect(Rect.fromLTWH(w * 0.50, h * 0.70, w * 0.12, h * 0.14), trouserPaint);

    // Overalls / Torso
    final overallPaint = Paint()..color = const Color(0xFF0084FF);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.30, h * 0.40, w * 0.36, h * 0.34), const Radius.circular(16)),
      overallPaint,
    );
    // Center Pocket
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.40, h * 0.48, w * 0.16, h * 0.14), const Radius.circular(4)),
      Paint()
        ..color = const Color(0xFF0072C6)
        ..style = PaintingStyle.fill,
    );

    // Left Arm & Hand
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.22, h * 0.42, w * 0.10, h * 0.22), const Radius.circular(10)),
      overallPaint,
    );
    canvas.drawCircle(Offset(w * 0.27, h * 0.67), 9, Paint()..color = const Color(0xFFFBCB9A));

    // Right Arm raised holding wrench
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.60, h * 0.36, w * 0.14, h * 0.12), const Radius.circular(8)),
      overallPaint,
    );
    canvas.drawCircle(Offset(w * 0.69, h * 0.37), 9, Paint()..color = const Color(0xFFFBCB9A));

    // Wrench in hand
    final wrenchPaint = Paint()
      ..color = const Color(0xFF0072C6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.69, h * 0.37), Offset(w * 0.74, h * 0.28), wrenchPaint);

    // Head
    final skinPaint = Paint()..color = const Color(0xFFFBCB9A);
    canvas.drawCircle(Offset(w * 0.48, h * 0.28), w * 0.16, skinPaint);

    // Blue Cap
    final capPaint = Paint()..color = const Color(0xFF0084FF);
    final capPath = Path()
      ..moveTo(w * 0.32, h * 0.26)
      ..arcToPoint(Offset(w * 0.64, h * 0.26), radius: Radius.circular(w * 0.16))
      ..close();
    canvas.drawPath(capPath, capPaint);
    // Visor
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.30, h * 0.25, w * 0.36, h * 0.05), const Radius.circular(4)),
      capPaint,
    );

    // Face eyes & smile
    final eyePaint = Paint()..color = const Color(0xFF1E293B);
    canvas.drawCircle(Offset(w * 0.42, h * 0.30), 3.5, eyePaint);
    canvas.drawCircle(Offset(w * 0.54, h * 0.30), 3.5, eyePaint);

    // Smile
    final smilePaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    final smilePath = Path()
      ..moveTo(w * 0.45, h * 0.34)
      ..quadraticBezierTo(w * 0.48, h * 0.38, w * 0.51, h * 0.34);
    canvas.drawPath(smilePath, smilePaint);
  }

  void _drawSparkle(Canvas canvas, Offset center, double size, Paint paint) {
    canvas.drawLine(Offset(center.dx - size, center.dy), Offset(center.dx + size, center.dy), paint);
    canvas.drawLine(Offset(center.dx, center.dy - size), Offset(center.dx, center.dy + size), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}