import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_router.dart';
import '../../../../shared/widgets/app_header_bar.dart';

class JobRatingScreen extends StatefulWidget {
  final String jobId;

  const JobRatingScreen({super.key, required this.jobId});

  @override
  State<JobRatingScreen> createState() => _JobRatingScreenState();
}

class _JobRatingScreenState extends State<JobRatingScreen> {
  int _selectedStars = 5;
  final TextEditingController _feedbackCtrl = TextEditingController();

  @override
  void dispose() {
    _feedbackCtrl.dispose();
    super.dispose();
  }

  void _finishJob() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Thank you! Feedback submitted.")),
    );
    context.go(AppRoutes.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerBlue,
      body: Column(
        children: [
          AppHeaderBar(
            showBackButton: true,
            onBackPress: () => context.go(AppRoutes.dashboard),
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
                    // Large Checkmark Graphic
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFEAF5FF),
                            ),
                          ),
                          Container(
                            width: 90,
                            height: 90,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryBlue,
                            ),
                            child: const Icon(Icons.check, size: 50, color: AppColors.surfaceWhite),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Job Completed Pill
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
                              "JOB COMPLETED",
                              style: AppTextStyles.badgeText.copyWith(color: AppColors.statusGreen, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Title & Congratulation
                    Text(
                      "Job done successfully!",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.screenTitle.copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Great work, Ali! The job is complete and payment is confirmed.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: 20),

                    // Job Context Banner
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
                            "Ayesha Khan · Request #${widget.jobId}",
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryBlue),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Experience Question
                    Text("How was your experience?", style: AppTextStyles.sectionTitle.copyWith(fontSize: 22)),
                    const SizedBox(height: 4),
                    Text("Your rating and feedback are optional.", style: AppTextStyles.bodySmall),
                    const SizedBox(height: 16),

                    // Star Selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starNumber = index + 1;
                        final isFilled = starNumber <= _selectedStars;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedStars = starNumber;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Icon(
                              isFilled ? Icons.star : Icons.star_border,
                              size: 38,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),

                    // Optional Feedback
                    Text("Feedback (Optional)", style: AppTextStyles.labelSemibold),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.inputBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderLight, width: 1.2),
                      ),
                      child: TextField(
                        controller: _feedbackCtrl,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: false,
                          contentPadding: EdgeInsets.zero,
                          hintText: "Share anything about the job or your experience...",
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Submit CTA
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _finishJob,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, size: 20),
                            SizedBox(width: 8),
                            Text("Submit"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Skip Feedback Option
                    Center(
                      child: GestureDetector(
                        onTap: () => context.go(AppRoutes.dashboard),
                        child: Text(
                          "Skip feedback",
                          style: AppTextStyles.labelSemibold.copyWith(
                            color: AppColors.primaryBlue,
                            fontSize: 14,
                          ),
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