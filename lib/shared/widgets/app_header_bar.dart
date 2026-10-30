import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'brand_logo.dart';

class AppHeaderBar extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBackPress;
  final bool showMenuButton;
  final VoidCallback? onMenuPress;
  final bool showLanguageToggle;
  final VoidCallback? onLanguagePress;

  const AppHeaderBar({
    super.key,
    this.showBackButton = false,
    this.onBackPress,
    this.showMenuButton = false,
    this.onMenuPress,
    this.showLanguageToggle = true,
    this.onLanguagePress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.headerBlue,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.surfaceWhite, size: 26),
              onPressed: onBackPress ?? () => Navigator.of(context).maybePop(),
            )
          else if (showMenuButton)
            IconButton(
              icon: const Icon(Icons.menu, color: AppColors.surfaceWhite, size: 28),
              onPressed: onMenuPress,
            )
          else
            const SizedBox(width: 48),

          // // App House + Tools Icon Emblem
          // CustomPaint(
          //   size: const Size(48, 48),
          //   painter: _HeaderAppLogoPainter(),
          // ),
          // PNG Brand Logo
          const BrandLogo(size: 52),

          if (showLanguageToggle)
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.translate, color: AppColors.surfaceWhite, size: 26),
              ),
              onPressed: onLanguagePress ?? () {},
            )
          else
            const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class _HeaderAppLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.surfaceWhite
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = AppColors.surfaceWhite
      ..style = PaintingStyle.fill;

    // Roof Outline
    final roof = Path()
      ..moveTo(size.width * 0.15, size.height * 0.45)
      ..lineTo(size.width * 0.5, size.height * 0.15)
      ..lineTo(size.width * 0.85, size.height * 0.45);
    canvas.drawPath(roof, paint);

    // Wall pillars
    canvas.drawLine(
      Offset(size.width * 0.22, size.height * 0.45),
      Offset(size.width * 0.22, size.height * 0.85),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.78, size.height * 0.45),
      Offset(size.width * 0.78, size.height * 0.85),
      paint,
    );

    // Center Screwdriver & tool silhouettes
    final centerScrewdriver = Path()
      ..moveTo(size.width * 0.46, size.height * 0.35)
      ..lineTo(size.width * 0.54, size.height * 0.35)
      ..lineTo(size.width * 0.54, size.height * 0.55)
      ..lineTo(size.width * 0.51, size.height * 0.75)
      ..lineTo(size.width * 0.49, size.height * 0.75)
      ..lineTo(size.width * 0.46, size.height * 0.55)
      ..close();
    canvas.drawPath(centerScrewdriver, fillPaint);

    // Left Hammer head & handle
    canvas.drawLine(
      Offset(size.width * 0.35, size.height * 0.48),
      Offset(size.width * 0.35, size.height * 0.78),
      paint..strokeWidth = 3.0,
    );
    canvas.drawLine(
      Offset(size.width * 0.28, size.height * 0.48),
      Offset(size.width * 0.42, size.height * 0.48),
      paint..strokeWidth = 3.5,
    );

    // Right Wrench/Hammer
    canvas.drawLine(
      Offset(size.width * 0.65, size.height * 0.48),
      Offset(size.width * 0.65, size.height * 0.78),
      paint..strokeWidth = 3.0,
    );
    canvas.drawLine(
      Offset(size.width * 0.58, size.height * 0.48),
      Offset(size.width * 0.72, size.height * 0.48),
      paint..strokeWidth = 3.5,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}