import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header_bar.dart';

class JobMediaScreen extends StatefulWidget {
  final String jobId;

  const JobMediaScreen({super.key, required this.jobId});

  @override
  State<JobMediaScreen> createState() => _JobMediaScreenState();
}

class _JobMediaScreenState extends State<JobMediaScreen> {
  bool _isPlayingVideo = false;

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
                    Text("See what needs fixing", style: AppTextStyles.screenTitle),
                    const SizedBox(height: 6),
                    Text("Client uploads · Today, 9:35 AM", style: AppTextStyles.bodyMedium),
                    const SizedBox(height: 18),

                    // Job context banner
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

                    // Section Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("All media", style: AppTextStyles.sectionTitle),
                        Text("2 photos · 1 video", style: AppTextStyles.bodySmall),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Photos 2-Column Grid
                    Row(
                      children: [
                        Expanded(
                          child: _buildMediaPhotoCard(
                            title: "Kitchen tap",
                            sizeInfo: "JPG · 1.8 MB",
                            imageUrl: "https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&q=80&w=400",
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _buildMediaPhotoCard(
                            title: "Leak close-up",
                            sizeInfo: "JPG · 1.2 MB",
                            imageUrl: "https://images.unsplash.com/photo-1585704032915-c3400ca199e7?auto=format&fit=crop&q=80&w=400",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Video Card
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.borderLight, width: 1.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: Container(
                                  height: 180,
                                  width: double.infinity,
                                  color: Colors.grey[200],
                                  child: Image.network(
                                    "https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&q=80&w=800",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Video badge top left
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.75),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "VIDEO · 00:24",
                                    style: AppTextStyles.badgeText.copyWith(
                                      color: AppColors.surfaceWhite,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                              // Play Button
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isPlayingVideo = !_isPlayingVideo;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(_isPlayingVideo ? "Playing video preview..." : "Video paused"),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 54,
                                  height: 54,
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceWhite.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    _isPlayingVideo ? Icons.pause : Icons.play_arrow,
                                    color: AppColors.primaryBlue,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tap dripping while turned off", style: AppTextStyles.itemTitle),
                                const SizedBox(height: 4),
                                Text("MP4 · 00:24 · 8.4 MB", style: AppTextStyles.bodySmall),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  height: 44,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFEDF6FF),
                                      foregroundColor: AppColors.primaryBlue,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Downloading video file...")),
                                      );
                                    },
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.download_outlined, size: 18),
                                        SizedBox(width: 8),
                                        Text("Download"),
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
                    const SizedBox(height: 20),

                    // Advisory Info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline, size: 20, color: AppColors.primaryBlue),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Review all uploads before sending an offer. Downloads are saved to your device.",
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondaryGrey, height: 1.35),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Back CTA
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.borderLight, width: 1.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () => context.pop(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.arrow_back, size: 18, color: AppColors.primaryBlue),
                            const SizedBox(width: 8),
                            Text("Back to requests", style: AppTextStyles.labelSemibold.copyWith(color: AppColors.primaryBlue)),
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

  Widget _buildMediaPhotoCard({
    required String title,
    required String sizeInfo,
    required String imageUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                child: Container(
                  height: 130,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "PHOTO",
                    style: AppTextStyles.badgeText.copyWith(color: AppColors.surfaceWhite, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.itemTitle.copyWith(fontSize: 14)),
                const SizedBox(height: 2),
                Text(sizeInfo, style: AppTextStyles.bodySmall),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 38,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEDF6FF),
                      foregroundColor: AppColors.primaryBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Downloading $title...")),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.download_outlined, size: 16),
                        SizedBox(width: 4),
                        Text("Download", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}