import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../controllers/job_controller.dart';
import '../../domain/job_model.dart';

class PastRequestDetailScreen extends ConsumerWidget {
  final String jobId;

  const PastRequestDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastRequests = ref.watch(pastJobsProvider);
    final job = pastRequests.firstWhere(
          (j) => j.id == jobId,
      orElse: () => pastRequests.first,
    );

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
                    // Completed status pill
                    Row(
                      children: [
                        const Icon(Icons.check_circle_outline, color: AppColors.statusGreen, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          "Completed",
                          style: AppTextStyles.badgeText.copyWith(
                            color: AppColors.statusGreen,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Job Title & Client
                    Text(
                      job.title,
                      style: AppTextStyles.screenTitle.copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Client: ${job.clientName}",
                      style: AppTextStyles.bodyLarge.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 18),

                    // Resolution Info Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDF6FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.primaryBlue),
                              const SizedBox(width: 10),
                              Text("Resolved ${job.timeAgoText}", style: AppTextStyles.bodyMedium),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on_outlined, size: 18, color: AppColors.primaryBlue),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(job.clientLocation, style: AppTextStyles.bodyMedium),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Rating & Feedback Card
                    Text("Rating & feedback", style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F7FF),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFD8E9F8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ...List.generate(
                                5,
                                    (i) => const Icon(Icons.star, size: 20, color: AppColors.primaryBlue),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "5.0 / 5",
                                style: AppTextStyles.labelSemibold.copyWith(
                                  color: AppColors.textPrimaryDark,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "“${job.clientFeedback ?? 'Ali arrived on time, replaced the tap neatly and checked for leaks. Very polite and professional.'}”",
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontStyle: FontStyle.normal,
                              color: AppColors.textPrimaryDark,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${job.clientName} · ${job.bill?.date ?? '18 Oct 2026'}",
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Receipt & Bill breakdown
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Receipt & bill", style: AppTextStyles.itemTitle),
                                  const SizedBox(height: 2),
                                  Text(
                                    "${job.bill?.invoiceNumber ?? 'INV-1031'} · ${job.bill?.date ?? '18 Oct 2026'}",
                                    style: AppTextStyles.bodySmall,
                                  ),
                                ],
                              ),
                              const Icon(Icons.receipt_long_outlined, color: AppColors.primaryBlue, size: 28),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(height: 1, color: AppColors.borderLight),
                          const SizedBox(height: 14),

                          _buildInvoiceRow("Labour · tap replacement", "1,500"),
                          const SizedBox(height: 10),
                          _buildInvoiceRow("Basin mixer tap × 1", "2,200"),
                          const SizedBox(height: 10),
                          _buildInvoiceRow("Seal tape & washers", "300"),
                          const SizedBox(height: 14),

                          const Divider(height: 1, color: AppColors.borderLight),
                          const SizedBox(height: 14),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total paid", style: AppTextStyles.labelSemibold.copyWith(fontSize: 16)),
                              Text(
                                "PKR 4,000",
                                style: AppTextStyles.itemTitle.copyWith(
                                  fontSize: 19,
                                  color: AppColors.primaryBlue,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.check, size: 14, color: AppColors.statusGreen),
                              const SizedBox(width: 4),
                              Text(
                                "Paid in cash · Balance PKR 0",
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.statusGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),

                          // Download Receipt CTA
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.borderLight, width: 1.2),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Downloading receipt PDF...")),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.download_outlined, size: 18, color: AppColors.primaryBlue),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Download receipt",
                                    style: AppTextStyles.labelSemibold.copyWith(color: AppColors.primaryBlue),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Saved Images & Videos Card
                    Text("Saved images & videos", style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 12),

                    _buildAttachmentTile(
                      icon: Icons.photo_outlined,
                      title: "Before & after · 2 images",
                      subtitle: "JPG · 3.2 MB",
                      onDownload: () {},
                    ),
                    const SizedBox(height: 10),
                    _buildAttachmentTile(
                      icon: Icons.videocam_outlined,
                      title: "Repair check · 1 video",
                      subtitle: "MP4 · 00:18 · 6.8 MB",
                      onDownload: () {},
                    ),
                    const SizedBox(height: 24),

                    // Delete Issue Action
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.dangerBorder, width: 1.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {
                          _showDeleteConfirmation(context, ref, job.id);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.delete_outline, color: AppColors.dangerBorder, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              "Delete issue",
                              style: AppTextStyles.labelSemibold.copyWith(color: AppColors.dangerBorder),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        "Permanently removes this issue from your history.",
                        style: AppTextStyles.bodySmall,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceRow(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.bodyMedium),
        Text(amount, style: AppTextStyles.labelSemibold),
      ],
    );
  }

  Widget _buildAttachmentTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onDownload,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight, width: 1.2),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.labelSemibold.copyWith(fontSize: 14)),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.download_outlined, color: AppColors.primaryBlue, size: 20),
            onPressed: onDownload,
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, String jobId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Record"),
        content: const Text("Are you sure you want to permanently delete this past request from your records?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              ref.read(pastJobsProvider.notifier).removeJob(jobId);
              Navigator.of(ctx).pop();
              context.pop();
            },
            child: const Text("Delete", style: TextStyle(color: AppColors.callRed)),
          ),
        ],
      ),
    );
  }
}