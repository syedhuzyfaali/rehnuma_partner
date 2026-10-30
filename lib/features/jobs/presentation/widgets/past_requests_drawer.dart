import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_router.dart';
import '../controllers/job_controller.dart';
import '../../domain/job_model.dart';

class PastRequestsDrawer extends ConsumerWidget {
  const PastRequestsDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastRequests = ref.watch(pastJobsProvider);
    final profile = ref.watch(profileProvider);

    return Drawer(
      backgroundColor: AppColors.surfaceWhite,
      surfaceTintColor: Colors.transparent,
      width: MediaQuery.of(context).size.width * 0.88,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Drawer Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Past requests", style: AppTextStyles.screenTitle.copyWith(fontSize: 24)),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDF6FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "${pastRequests.length}",
                              style: AppTextStyles.labelSemibold.copyWith(
                                color: AppColors.primaryBlue,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: AppColors.textPrimaryDark),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text("Good work, all in one place.", style: AppTextStyles.bodyMedium),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.borderLight),

            // Past Requests Scrollable List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                itemCount: pastRequests.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final job = pastRequests[index];
                  return _buildPastJobTile(context, job);
                },
              ),
            ),

            const Divider(height: 1, color: AppColors.borderLight),

            // Bottom Profile & Logout Footer
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Signed in as ${profile.fullName}",
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondaryGrey),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.push(AppRoutes.profile);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_outline, size: 20),
                          SizedBox(width: 8),
                          Text("View Profile"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.borderLight, width: 1.2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.go(AppRoutes.splash);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout, size: 18, color: AppColors.primaryBlue),
                          const SizedBox(width: 8),
                          Text(
                            "Log out",
                            style: AppTextStyles.labelSemibold.copyWith(color: AppColors.primaryBlue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPastJobTile(BuildContext context, JobRequest job) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        context.push('/past-requests/${job.id}');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  job.clientName,
                  style: AppTextStyles.labelSemibold.copyWith(
                    color: AppColors.primaryBlue,
                    fontSize: 14,
                  ),
                ),
                const Icon(Icons.chevron_right, size: 20, color: AppColors.primaryBlue),
              ],
            ),
            const SizedBox(height: 6),
            Text(job.title, style: AppTextStyles.itemTitle.copyWith(fontSize: 16)),
            const SizedBox(height: 6),
            Text(job.timeAgoText, style: AppTextStyles.bodySmall),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.check, size: 14, color: AppColors.statusGreen),
                const SizedBox(width: 4),
                Text(
                  "Completed",
                  style: AppTextStyles.badgeText.copyWith(
                    color: AppColors.statusGreen,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}