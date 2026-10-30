import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header_bar.dart';

class BillUploadScreen extends StatelessWidget {
  final String jobId;

  const BillUploadScreen({super.key, required this.jobId});

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
                    Text("Bill uploaded", style: AppTextStyles.screenTitle),
                    const SizedBox(height: 4),
                    Text("All set. Your bill is ready for review.", style: AppTextStyles.bodyMedium),
                    const SizedBox(height: 14),

                    // Badge pill
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDF8F3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle_outline, size: 15, color: AppColors.statusGreen),
                              const SizedBox(width: 6),
                              Text(
                                "BILL UPLOADED",
                                style: AppTextStyles.badgeText.copyWith(
                                  color: AppColors.statusGreen,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

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
                    const SizedBox(height: 20),

                    // Uploaded Bill Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Uploaded bill", style: AppTextStyles.sectionTitle.copyWith(fontSize: 18)),
                        Text(
                          "Original document",
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondaryGrey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Itemized Bill Card
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.borderLight, width: 1.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Your bill", style: AppTextStyles.screenTitle.copyWith(fontSize: 22)),
                          const SizedBox(height: 4),
                          Text("Work completed. Here’s the breakdown.", style: AppTextStyles.bodyMedium),
                          const SizedBox(height: 16),

                          // Inner Invoice Box
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAFCFF),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: AppColors.borderLight),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Leaking kitchen tap", style: AppTextStyles.itemTitle.copyWith(fontSize: 15)),
                                const SizedBox(height: 12),
                                _buildBillField("Technician", "James Wilson"),
                                const SizedBox(height: 6),
                                _buildBillField("Requester", "Alex"),
                                const SizedBox(height: 6),
                                _buildBillField("Contact no.", "07700 900000"),
                                const SizedBox(height: 6),
                                _buildBillField("Date", "20 Oct 2026"),
                                const SizedBox(height: 6),
                                _buildBillField("Time of work", "10:00–11:00 · 1 hr"),
                                const Divider(height: 20, color: AppColors.borderLight),
                                _buildBillField("Equipment fee", "£20.00"),
                                const SizedBox(height: 6),
                                _buildBillField("Labour fee", "£60.00"),
                                const SizedBox(height: 6),
                                _buildBillField("Platform fee", "£5.00"),
                                const Divider(height: 20, color: AppColors.borderLight),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total amount to pay", style: AppTextStyles.labelSemibold.copyWith(fontSize: 16)),
                                    Text(
                                      "£85.00",
                                      style: AppTextStyles.itemTitle.copyWith(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Your uploaded document is shown as provided.",
                            style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      "Your original bill is attached. End the job when the work is complete to review payment.",
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondaryGrey, height: 1.35),
                    ),
                    const SizedBox(height: 24),

                    // End Job CTA Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => context.push('/jobs/$jobId/bill-payment'),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, size: 20),
                            SizedBox(width: 8),
                            Text("End job"),
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

  Widget _buildBillField(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondaryGrey)),
        Text(value, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: AppColors.textPrimaryDark)),
      ],
    );
  }
}