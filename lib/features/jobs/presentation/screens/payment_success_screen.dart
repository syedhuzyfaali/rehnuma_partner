import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header_bar.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String jobId;

  const PaymentSuccessScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerBlue,
      body: Column(
        children: [
          AppHeaderBar(
            showBackButton: true,
            onBackPress: () => context.pop(),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.surfaceWhite,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  children: [
                    Text("Online payment done successfully!", style: AppTextStyles.screenTitle),
                    const SizedBox(height: 4),
                    Text("Payment received. You’re ready to finish the job.", style: AppTextStyles.bodyMedium),
                    const SizedBox(height: 18),

                    // Job Reference Banner
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDF6FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Leaking kitchen tap", style: AppTextStyles.itemTitle.copyWith(fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(
                            "Ayesha Khan · Request #$jobId",
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryBlue),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Circular Checkmark Animation Badge
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 140,
                            height: 140,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFE8F3FD),
                            ),
                          ),
                          Container(
                            width: 96,
                            height: 96,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryBlue,
                            ),
                            child: const Icon(Icons.check, size: 54, color: AppColors.surfaceWhite),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Automatically Confirmed Pill
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDF8F3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.check_circle_outline, size: 15, color: AppColors.statusGreen),
                            const SizedBox(width: 6),
                            Text(
                              "AUTOMATICALLY CONFIRMED",
                              style: AppTextStyles.badgeText.copyWith(color: AppColors.statusGreen, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Payment Amount Card
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7FAFD),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE2EAF4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Online payment", style: AppTextStyles.labelSemibold.copyWith(fontSize: 16)),
                              Text(
                                "£85.00",
                                style: AppTextStyles.itemTitle.copyWith(
                                  fontSize: 22,
                                  color: const Color(0xFF0072C6),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Payment was confirmed automatically. You don’t need to verify it manually.",
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondaryGrey, height: 1.35),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => context.push('/jobs/$jobId/rating'),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, size: 20),
                            SizedBox(width: 8),
                            Text("Continue"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}