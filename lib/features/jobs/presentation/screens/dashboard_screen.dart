import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_router.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../../domain/media_item_model.dart';
import '../controllers/job_controller.dart';
import '../../domain/job_model.dart';
import '../widgets/past_requests_drawer.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<String, TextEditingController> _offerControllers = {};

  @override
  void dispose() {
    for (final controller in _offerControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _getController(JobRequest job) {
    return _offerControllers.putIfAbsent(
      job.id,
          () => TextEditingController(
        text: job.defaultOfferAmount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},',
        ),
      ),
    );
  }

  void _onSendOffer(JobRequest job) {
    ref.read(activeJobProvider.notifier).state = job;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Offer sent to ${job.clientName}! Heading over..."),
        duration: const Duration(seconds: 2),
      ),
    );
    context.push('/jobs/${job.id}/on-way');
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);
    final incomingRequests = ref.watch(incomingJobsProvider);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.headerBlue,
      drawer: const PastRequestsDrawer(),
      body: Column(
        children: [
          AppHeaderBar(
            showMenuButton: true,
            onMenuPress: () => _scaffoldKey.currentState?.openDrawer(),
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
                    // Salutation Header
                    Text(
                      "Assalamualaikum, ${profile.firstName}",
                      style: AppTextStyles.screenTitle.copyWith(fontSize: 28),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.check, size: 16, color: AppColors.primaryBlue),
                        const SizedBox(width: 4),
                        Text(
                          "Verified handyman",
                          style: AppTextStyles.labelSemibold.copyWith(
                            color: AppColors.primaryBlue,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Availability Toggle Card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDF6FF),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFD6E9FA), width: 1.2),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: profile.isAvailableForWork
                                  ? AppColors.statusGreen
                                  : AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profile.isAvailableForWork
                                      ? "You’re available for work"
                                      : "You are offline",
                                  style: AppTextStyles.labelSemibold.copyWith(fontSize: 14),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  profile.activeLocation,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondaryGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: 0.9,
                            child: Switch(
                              value: profile.isAvailableForWork,
                              activeColor: AppColors.surfaceWhite,
                              activeTrackColor: AppColors.primaryBlue,
                              inactiveThumbColor: AppColors.surfaceWhite,
                              inactiveTrackColor: AppColors.borderLight,
                              onChanged: (val) {
                                ref.read(profileProvider.notifier).toggleAvailability(val);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Section Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Incoming requests", style: AppTextStyles.sectionTitle),
                        Row(
                          children: [
                            const Icon(Icons.filter_list, size: 16, color: AppColors.primaryBlue),
                            const SizedBox(width: 4),
                            Text(
                              "Closest first",
                              style: AppTextStyles.labelSemibold.copyWith(
                                color: AppColors.primaryBlue,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Incoming Request Cards
                    ...incomingRequests.map((job) => _buildRequestCard(context, job)),

                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        "You’re all caught up · New requests appear here",
                        style: AppTextStyles.bodySmall,
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

  Widget _buildRequestCard(BuildContext context, JobRequest job) {
    final offerCtrl = _getController(job);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Client Name and Distance badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(job.clientName, style: AppTextStyles.itemTitle.copyWith(fontSize: 16)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF6FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, size: 13, color: AppColors.primaryBlue),
                    const SizedBox(width: 3),
                    Text(
                      job.distanceText,
                      style: AppTextStyles.badgeText.copyWith(
                        color: AppColors.primaryBlue,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Job Title
          Text(
            job.title,
            style: AppTextStyles.sectionTitle.copyWith(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),

          // Time ago
          Text(job.timeAgoText, style: AppTextStyles.bodySmall),
          const SizedBox(height: 12),

          // Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined, size: 18, color: AppColors.primaryBlue),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  job.clientLocation,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimaryDark),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Media attachments button row
          if (job.mediaItems.isNotEmpty) ...[
            Row(
              children: [
                InkWell(
                  onTap: () => context.push('/jobs/${job.id}/media'),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDF6FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.photo_library_outlined, size: 16, color: AppColors.primaryBlue),
                        const SizedBox(width: 6),
                        Text(
                          "Media",
                          style: AppTextStyles.labelSemibold.copyWith(
                            color: AppColors.primaryBlue,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "${job.mediaItems.where((m) => m.type == MediaType.photo).length} photos · ${job.mediaItems.where((m) => m.type == MediaType.video).length} video",
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 18),
          ],

          const Divider(height: 1, color: AppColors.borderLight),
          const SizedBox(height: 14),

          // Your Offer Amount Field
          Text("Your offer amount", style: AppTextStyles.labelSemibold.copyWith(fontSize: 13)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.inputBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderLight, width: 1.2),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Text(
                    "PKR",
                    style: AppTextStyles.labelSemibold.copyWith(
                      color: AppColors.textSecondaryGrey,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: offerCtrl,
                    keyboardType: TextInputType.number,
                    style: AppTextStyles.itemTitle.copyWith(fontSize: 16),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Send Offer CTA
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => _onSendOffer(job),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send_rounded, size: 17),
                  SizedBox(width: 8),
                  Text("Send offer"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}