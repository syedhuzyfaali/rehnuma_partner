import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header_bar.dart';

class BillPaymentScreen extends StatefulWidget {
  final String jobId;

  const BillPaymentScreen({super.key, required this.jobId});

  @override
  State<BillPaymentScreen> createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {
  String _selectedPaymentMethod = "Cash";

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
                    Text("Review bill & payment", style: AppTextStyles.screenTitle),
                    const SizedBox(height: 4),
                    Text("Work ended. Confirm payment to finish the job.", style: AppTextStyles.bodyMedium),
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
                            "Ayesha Khan · Request #${widget.jobId}",
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryBlue),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Uploaded Bill Breakdown Card
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
                          _buildField("Technician", "James Wilson"),
                          const SizedBox(height: 6),
                          _buildField("Requester", "Alex"),
                          const SizedBox(height: 6),
                          _buildField("Contact no.", "07700 900000"),
                          const SizedBox(height: 6),
                          _buildField("Date", "20 Oct 2026"),
                          const SizedBox(height: 6),
                          _buildField("Time of work", "10:00–11:00 · 1 hr"),
                          const Divider(height: 20, color: AppColors.borderLight),
                          _buildField("Equipment fee", "£20.00"),
                          const SizedBox(height: 6),
                          _buildField("Labour fee", "£60.00"),
                          const SizedBox(height: 6),
                          _buildField("Platform fee", "£5.00"),
                          const Divider(height: 20, color: AppColors.borderLight),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total amount to pay", style: AppTextStyles.labelSemibold.copyWith(fontSize: 16)),
                              Text("£85.00", style: AppTextStyles.itemTitle.copyWith(fontSize: 22, fontWeight: FontWeight.w800)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Payment Method Radio
                    Text("Payment method", style: AppTextStyles.sectionTitle.copyWith(fontSize: 18)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7FAFD),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.primaryBlue, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryBlue,
                            ),
                            child: const Center(
                              child: Icon(Icons.circle, size: 8, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text("Cash", style: AppTextStyles.labelSemibold.copyWith(fontSize: 15)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Cash Status Notice Container
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
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF4FE),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.schedule, size: 13, color: AppColors.primaryBlue),
                                const SizedBox(width: 5),
                                Text(
                                  "CASH NOT CONFIRMED",
                                  style: AppTextStyles.badgeText.copyWith(color: AppColors.textPrimaryBlue, fontSize: 10.5),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Uploaded bill total", style: AppTextStyles.bodyMedium),
                              Text("£85.00", style: AppTextStyles.itemTitle.copyWith(fontSize: 20, fontWeight: FontWeight.w800)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Only verify after you have received the cash. This payment has not been confirmed yet.",
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondaryGrey, height: 1.35),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Verify Cash Received CTA Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => context.push('/jobs/${widget.jobId}/payment-success'),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.verified_outlined, size: 18),
                            SizedBox(width: 8),
                            Text("Verify cash received"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        "Handyman confirmation is required for cash payments.",
                        style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
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

  Widget _buildField(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondaryGrey)),
        Text(value, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: AppColors.textPrimaryDark)),
      ],
    );
  }
}