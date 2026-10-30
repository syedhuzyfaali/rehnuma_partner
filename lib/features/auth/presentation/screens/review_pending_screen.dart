import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_router.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../widgets/toolbox_mascot.dart';

class ReviewPendingScreen extends StatelessWidget {
  const ReviewPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerBlue,
      body: Column(
        children: [
          AppHeaderBar(
            showBackButton: true,
            onBackPress: () => context.go(AppRoutes.register),
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    children: [
                      // Status Badge pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF5FF),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.schedule, size: 15, color: AppColors.primaryBlue),
                            const SizedBox(width: 6),
                            Text(
                              "APPLICATION UNDER REVIEW",
                              style: AppTextStyles.badgeText.copyWith(
                                color: AppColors.primaryBlue,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Mascot Character
                      const ToolboxMascot(size: 200),
                      const SizedBox(height: 20),

                      // Title & Subtitle
                      Text(
                        "Wait to get verified!",
                        style: AppTextStyles.screenTitle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "You’re all set, Ali! Our admin team is checking your CNIC, profile and skills to help keep every home in safe hands.",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyLarge,
                      ),
                      const SizedBox(height: 28),

                      // Status Details Container
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6FAFD),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFE5EFF9), width: 1.2),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.check_circle_outline, color: AppColors.primaryBlue, size: 22),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    "Profile submitted successfully",
                                    style: AppTextStyles.itemTitle.copyWith(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.notifications_none_outlined, color: AppColors.primaryBlue, size: 22),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    "We’ll notify you as soon as you’re verified. This usually takes 24–48 hours.",
                                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondaryGrey),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Contact Support Action
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Support team: support@rehnuma.pk")),
                          );
                        },
                        child: Text(
                          "Need a hand? Contact support",
                          style: AppTextStyles.labelSemibold.copyWith(
                            color: AppColors.primaryBlue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Direct bypass button for reviewer demo
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primaryBlue, width: 1.2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: () => context.go(AppRoutes.dashboard),
                          child: Text(
                            "Preview Verified Dashboard",
                            style: AppTextStyles.buttonText.copyWith(color: AppColors.primaryBlue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}