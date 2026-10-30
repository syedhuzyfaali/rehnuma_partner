import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SchematicMapWidget extends StatelessWidget {
  final double height;
  final String etaText;
  final String distanceText;

  const SchematicMapWidget({
    super.key,
    this.height = 280,
    this.etaText = "4 min",
    this.distanceText = "0.8 km",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Custom Painted schematic map
            Positioned.fill(
              child: CustomPaint(
                painter: _MapGridPainter(),
              ),
            ),

            // Street Label text overlays
            const Positioned(
              top: 50,
              left: 20,
              child: Text(
                "GULBERG III",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8)),
              ),
            ),
            const Positioned(
              top: 135,
              right: 140,
              child: Text(
                "Street 5",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
              ),
            ),
            const Positioned(
              bottom: 45,
              left: 20,
              child: Text(
                "Main Boulevard Gulberg",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
              ),
            ),
            const Positioned(
              top: 90,
              right: 60,
              child: Text(
                "Gulberg\nPark",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
              ),
            ),

            // Floating ETA and Distance pill
            Positioned(
              bottom: 30,
              right: 40,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  "$etaText · $distanceText",
                  style: AppTextStyles.labelSemibold.copyWith(
                    color: AppColors.textPrimaryDark,
                    fontSize: 13,
                  ),
                ),
              ),
            ),

            // Subtle map disclaimer caption
            Positioned(
              bottom: 8,
              left: 14,
              child: Text(
                "Illustrative route · Not live navigation",
                style: AppTextStyles.bodySmall.copyWith(fontSize: 9, color: AppColors.textMuted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Building Blocks
    final blockPaint = Paint()..color = const Color(0xFFE2E8F0);
    final parkPaint = Paint()..color = const Color(0xFFDCFCE7); // Soft Green for Gulberg Park

    // Gulberg Park
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.65, h * 0.18, w * 0.32, h * 0.38),
        const Radius.circular(12),
      ),
      parkPaint,
    );

    // Grid blocks left
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.05, h * 0.12, w * 0.22, h * 0.28), const Radius.circular(8)),
      blockPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.32, h * 0.12, w * 0.22, h * 0.28), const Radius.circular(8)),
      blockPaint,
    );

    // Grid blocks middle
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.05, h * 0.46, w * 0.22, h * 0.26), const Radius.circular(8)),
      blockPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.32, h * 0.46, w * 0.22, h * 0.26), const Radius.circular(8)),
      blockPaint,
    );

    // Grid blocks right
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.65, h * 0.60, w * 0.32, h * 0.26), const Radius.circular(8)),
      blockPaint,
    );

    // Active Route Path
    final routePaint = Paint()
      ..color = AppColors.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final routePath = Path()
      ..moveTo(w * 0.20, h * 0.68)
      ..lineTo(w * 0.58, h * 0.68)
      ..lineTo(w * 0.58, h * 0.32)
      ..lineTo(w * 0.78, h * 0.32);
    canvas.drawPath(routePath, routePaint);

    // Start Handyman Location Node
    final startNodeCenter = Offset(w * 0.20, h * 0.68);
    final haloPaint = Paint()..color = AppColors.primaryBlue.withOpacity(0.25);
    canvas.drawCircle(startNodeCenter, 14, haloPaint);
    canvas.drawCircle(startNodeCenter, 7, Paint()..color = AppColors.primaryBlue);
    canvas.drawCircle(startNodeCenter, 3.5, Paint()..color = Colors.white);

    // Destination Pin (House icon circle)
    final destCenter = Offset(w * 0.78, h * 0.32);
    canvas.drawCircle(destCenter, 15, Paint()..color = const Color(0xFF0072C6));
    // Draw small white house inside dest circle
    final iconPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final housePath = Path()
      ..moveTo(destCenter.dx, destCenter.dy - 6)
      ..lineTo(destCenter.dx - 6, destCenter.dy)
      ..lineTo(destCenter.dx - 4, destCenter.dy)
      ..lineTo(destCenter.dx - 4, destCenter.dy + 6)
      ..lineTo(destCenter.dx + 4, destCenter.dy + 6)
      ..lineTo(destCenter.dx + 4, destCenter.dy)
      ..lineTo(destCenter.dx + 6, destCenter.dy)
      ..close();
    canvas.drawPath(housePath, iconPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}