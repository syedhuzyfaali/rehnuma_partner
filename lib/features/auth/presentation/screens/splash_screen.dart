import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_router.dart';
import '../../../../shared/widgets/brand_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(AppRoutes.register);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.headerBlue,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.go(AppRoutes.register),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Decorative concentric ripples
            Positioned(
              top: screenSize.height * 0.15,
              child: Container(
                width: screenSize.width * 1.5,
                height: screenSize.width * 1.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.surfaceWhite.withOpacity(0.08),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenSize.height * 0.22,
              child: Container(
                width: screenSize.width * 1.1,
                height: screenSize.width * 1.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.surfaceWhite.withOpacity(0.12),
                    width: 1.5,
                  ),
                ),
              ),
            ),

            // Content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),
                    const BrandLogo(size: 280),
                    const SizedBox(height: 36),
                    Text(
                      "Your skills. Better\nhomes.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.splashTitle,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Good work starts here.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.surfaceWhite.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(flex: 3),

                    // Indicator pills
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       width: 24,
                    //       height: 4,
                    //       decoration: BoxDecoration(
                    //         color: AppColors.surfaceWhite,
                    //         borderRadius: BorderRadius.circular(4),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 6),
                    //     Container(
                    //       width: 32,
                    //       height: 4,
                    //       decoration: BoxDecoration(
                    //         color: AppColors.surfaceWhite.withOpacity(0.4),
                    //         borderRadius: BorderRadius.circular(4),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: const Duration(seconds: 3), // Adjust the loading speed here
                      builder: (context, value, child) {
                        return SizedBox(
                          width: 150, // Set the total width of your progress bar
                          height: 4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: value,
                              backgroundColor: AppColors.surfaceWhite.withOpacity(0.4),
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.surfaceWhite),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Getting things ready",
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.surfaceWhite.withOpacity(0.85),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}