import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';

class BrandLogo extends StatelessWidget {
  final double size;
  final Color? color;
  final BoxFit fit;

  const BrandLogo({
    super.key,
    this.size = 120,
    this.color,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        AppAssets.brandLogo,
        width: size,
        height: size,
        fit: fit,
        color: color,
        // errorBuilder: (context, error, stackTrace) {
        //   // Fallback vector painter if PNG has not been placed yet
        //   return CustomPaint(
        //     size: Size(size, size),
        //     painter: _FallbackBrandLogoPainter(
        //       color: color ?? AppColors.surfaceWhite,
        //     ),
        //   );
        // },
      ),
    );
  }
}

// class _FallbackBrandLogoPainter extends CustomPainter {
//   final Color color;
//
//   _FallbackBrandLogoPainter({required this.color});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final strokePaint = Paint()
//       ..color = color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.05
//       ..strokeCap = StrokeCap.round
//       ..strokeJoin = StrokeJoin.round;
//
//     final fillPaint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;
//
//     final w = size.width;
//     final h = size.height;
//
//     // Roof Outline
//     final roof = Path()
//       ..moveTo(w * 0.12, h * 0.42)
//       ..lineTo(w * 0.50, h * 0.12)
//       ..lineTo(w * 0.88, h * 0.42);
//     canvas.drawPath(roof, strokePaint);
//
//     // Wall Pillars
//     canvas.drawLine(Offset(w * 0.20, h * 0.42), Offset(w * 0.20, h * 0.86), strokePaint);
//     canvas.drawLine(Offset(w * 0.80, h * 0.42), Offset(w * 0.80, h * 0.86), strokePaint);
//
//     // Screwdriver Shaft & Handle
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.45, h * 0.26, w * 0.10, h * 0.20), Radius.circular(w * 0.03)),
//       fillPaint,
//     );
//     canvas.drawLine(Offset(w * 0.50, h * 0.46), Offset(w * 0.50, h * 0.70), strokePaint);
//
//     // Left & Right Tools
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.28, h * 0.44, w * 0.18, h * 0.08), Radius.circular(w * 0.02)),
//       fillPaint,
//     );
//     canvas.drawLine(Offset(w * 0.38, h * 0.48), Offset(w * 0.38, h * 0.84), strokePaint);
//
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.54, h * 0.44, w * 0.18, h * 0.08), Radius.circular(w * 0.02)),
//       fillPaint,
//     );
//     canvas.drawLine(Offset(w * 0.62, h * 0.48), Offset(w * 0.62, h * 0.84), strokePaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
//


// import 'package:flutter/material.dart';
// import '../../core/theme/app_colors.dart';
//
// class BrandLogo extends StatelessWidget {
//   final double size;
//   final Color color;
//
//   const BrandLogo({
//     super.key,
//     this.size = 120,
//     this.color = AppColors.surfaceWhite,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(size, size),
//       painter: _BrandLogoPainter(color: color),
//     );
//   }
// }
//
// class _BrandLogoPainter extends CustomPainter {
//   final Color color;
//
//   _BrandLogoPainter({required this.color});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final strokePaint = Paint()
//       ..color = color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.05
//       ..strokeCap = StrokeCap.round
//       ..strokeJoin = StrokeJoin.round;
//
//     final fillPaint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;
//
//     final w = size.width;
//     final h = size.height;
//
//     // Roof Triangle Outline
//     final roof = Path()
//       ..moveTo(w * 0.12, h * 0.42)
//       ..lineTo(w * 0.50, h * 0.12)
//       ..lineTo(w * 0.88, h * 0.42);
//     canvas.drawPath(roof, strokePaint);
//
//     // Left and Right Wall Pillars
//     canvas.drawLine(Offset(w * 0.20, h * 0.42), Offset(w * 0.20, h * 0.86), strokePaint);
//     canvas.drawLine(Offset(w * 0.80, h * 0.42), Offset(w * 0.80, h * 0.86), strokePaint);
//
//     // Chimney
//     final chimney = Path()
//       ..moveTo(w * 0.68, h * 0.25)
//       ..lineTo(w * 0.68, h * 0.16)
//       ..lineTo(w * 0.77, h * 0.16)
//       ..lineTo(w * 0.77, h * 0.33);
//     canvas.drawPath(chimney, strokePaint);
//
//     // Center Screwdriver
//     // Handle
//     final screwHandle = RRect.fromRectAndRadius(
//       Rect.fromLTWH(w * 0.45, h * 0.26, w * 0.10, h * 0.20),
//       Radius.circular(w * 0.03),
//     );
//     canvas.drawRRect(screwHandle, fillPaint);
//     // Shaft
//     canvas.drawLine(
//       Offset(w * 0.50, h * 0.46),
//       Offset(w * 0.50, h * 0.70),
//       strokePaint..strokeWidth = w * 0.04,
//     );
//     // Screw Threads
//     final threadPaint = Paint()
//       ..color = color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = w * 0.025
//       ..strokeCap = StrokeCap.round;
//     for (int i = 0; i < 4; i++) {
//       final y = h * 0.72 + (i * h * 0.03);
//       final offset = (i % 2 == 0) ? -w * 0.02 : w * 0.02;
//       canvas.drawLine(Offset(w * 0.47 + offset, y), Offset(w * 0.53 + offset, y), threadPaint);
//     }
//
//     // Left Hammer
//     // Head
//     final leftHammerHead = RRect.fromRectAndRadius(
//       Rect.fromLTWH(w * 0.28, h * 0.44, w * 0.18, h * 0.08),
//       Radius.circular(w * 0.02),
//     );
//     canvas.drawRRect(leftHammerHead, fillPaint);
//     // Handle
//     canvas.drawLine(
//       Offset(w * 0.38, h * 0.48),
//       Offset(w * 0.38, h * 0.84),
//       strokePaint..strokeWidth = w * 0.045,
//     );
//
//     // Right Hammer / Mallet
//     // Head
//     final rightHammerHead = RRect.fromRectAndRadius(
//       Rect.fromLTWH(w * 0.54, h * 0.44, w * 0.18, h * 0.08),
//       Radius.circular(w * 0.02),
//     );
//     canvas.drawRRect(rightHammerHead, fillPaint);
//     // Handle
//     canvas.drawLine(
//       Offset(w * 0.62, h * 0.48),
//       Offset(w * 0.62, h * 0.84),
//       strokePaint..strokeWidth = w * 0.045,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }