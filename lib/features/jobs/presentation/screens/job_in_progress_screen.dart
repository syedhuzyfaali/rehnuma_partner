import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../widgets/handyman_illustration.dart';

class JobInProgressScreen extends StatelessWidget {
  final String jobId;

  const JobInProgressScreen({super.key, required this.jobId});

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
                    Text("Job in progress", style: AppTextStyles.screenTitle),
                    const SizedBox(height: 4),
                    Text("You’ve started the job. Let’s get it fixed!", style: AppTextStyles.bodyMedium),
                    const SizedBox(height: 18),

                    // Centered Handyman Graphic
                    const Center(child: HandymanIllustration(size: 200)),
                    const SizedBox(height: 16),

                    // Badge pill
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5F3FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.build_outlined, size: 14, color: AppColors.primaryBlue),
                            const SizedBox(width: 6),
                            Text(
                              "JOB IN PROGRESS",
                              style: AppTextStyles.badgeText.copyWith(
                                color: AppColors.primaryBlue,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

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
                    const SizedBox(height: 16),

                    // Client Info Card
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.borderLight, width: 1.2),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Maryam Bibi", style: AppTextStyles.itemTitle.copyWith(fontSize: 17)),
                                const SizedBox(height: 4),
                                Text(
                                  "House 24, Street 5, Gulberg III, Lahore",
                                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondaryGrey),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Arrival OTP verified · Ali Raza is working",
                                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryBlue),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => context.push('/jobs/$jobId/call'),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDF6FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.phone_outlined, size: 22, color: AppColors.primaryBlue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    Text(
                      "Add your bill before ending the job. Payment is confirmed in the next step.",
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondaryGrey, height: 1.35),
                    ),
                    const SizedBox(height: 24),

                    // // Bottom Action Buttons
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: SizedBox(
                    //         height: 52,
                    //         child: OutlinedButton(
                    //           style: OutlinedButton.styleFrom(
                    //             side: const BorderSide(color: AppColors.borderLight, width: 1.2),
                    //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    //           ),
                    //           onPressed: () => context.push('/jobs/$jobId/bill-upload'),
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               const Icon(Icons.upload_outlined, size: 18, color: AppColors.primaryBlue),
                    //               const SizedBox(width: 8),
                    //               Text(
                    //                 "Upload bills",
                    //                 style: AppTextStyles.labelSemibold.copyWith(color: AppColors.primaryBlue),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 14),
                    //     Expanded(
                    //       child: SizedBox(
                    //         height: 52,
                    //         child: ElevatedButton(
                    //           onPressed: () => context.push('/jobs/$jobId/bill-payment'),
                    //           child: const Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Icon(Icons.check, size: 18),
                    //               SizedBox(width: 8),
                    //               Text("End job"),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 20),
                    // Bottom Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 8), // Fixes the overflow
                                side: const BorderSide(color: AppColors.borderLight, width: 1.2),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                              onPressed: () => context.push('/jobs/$jobId/bill-upload'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min, // Prevents row from expanding beyond bounds
                                children: [
                                  const Icon(Icons.upload_outlined, size: 18, color: AppColors.primaryBlue),
                                  const SizedBox(width: 6), // Slightly adjusted spacing
                                  Text(
                                    "Upload bills",
                                    style: AppTextStyles.labelSemibold.copyWith(color: AppColors.primaryBlue),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 8), // Prevents potential future overflow
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                              onPressed: () => context.push('/jobs/$jobId/bill-payment'),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min, // Prevents row from expanding beyond bounds
                                children: [
                                  Icon(Icons.check, size: 18),
                                  SizedBox(width: 6),
                                  Text("End job"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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