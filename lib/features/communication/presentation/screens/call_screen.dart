import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header_bar.dart';

class CallScreen extends StatefulWidget {
  final String jobId;

  const CallScreen({super.key, required this.jobId});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  int _secondsElapsed = 154; // Starts at 02:34
  late Timer _timer;
  bool _isMuted = false;
  bool _isSpeakerOn = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _secondsElapsed++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatCallDuration(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    children: [
                      // Header Titles
                      Text("Call client", style: AppTextStyles.screenTitle),
                      const SizedBox(height: 4),
                      Text("Leaking kitchen tap · Request #${widget.jobId}", style: AppTextStyles.bodyMedium),
                      const Spacer(flex: 1),

                      // Circular Avatar with Concentric Halo Rings
                      SizedBox(
                        width: 170,
                        height: 170,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFE2EAF4), width: 1.5),
                              ),
                            ),
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFC8E1FA), width: 2.0),
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 110,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE2EFFC),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "MB",
                                  style: AppTextStyles.screenTitle.copyWith(
                                    color: const Color(0xFF0072C6),
                                    fontSize: 34,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Client Name and Location
                      Text("Maryam Bibi", style: AppTextStyles.screenTitle.copyWith(fontSize: 28)),
                      const SizedBox(height: 6),
                      Text("Gulberg III, Lahore", style: AppTextStyles.bodyLarge),
                      const SizedBox(height: 12),

                      // Status connected timer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.statusGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Connected · ${_formatCallDuration(_secondsElapsed)}",
                            style: AppTextStyles.labelSemibold.copyWith(
                              color: const Color(0xFF0072C6),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(flex: 2),

                      // Call Controls (Mute, Speaker, Keypad)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildControlAction(
                            icon: _isMuted ? Icons.mic_off : Icons.mic_none,
                            label: "Mute",
                            isActive: _isMuted,
                            onTap: () {
                              setState(() {
                                _isMuted = !_isMuted;
                              });
                            },
                          ),
                          _buildControlAction(
                            icon: Icons.volume_up,
                            label: "Speaker",
                            isActive: _isSpeakerOn,
                            onTap: () {
                              setState(() {
                                _isSpeakerOn = !_isSpeakerOn;
                              });
                            },
                          ),
                          _buildControlAction(
                            icon: Icons.dialpad,
                            label: "Keypad",
                            isActive: false,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Keypad opened")),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),

                      // End Call Button
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE04F5F),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.call_end, color: AppColors.surfaceWhite, size: 30),
                            ),
                            const SizedBox(height: 8),
                            Text("End call", style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondaryGrey)),
                          ],
                        ),
                      ),
                      const Spacer(flex: 1),

                      // Privacy Note
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.verified_user_outlined, size: 16, color: AppColors.textSecondaryGrey),
                          const SizedBox(width: 6),
                          Text("Your phone number stays private.", style: AppTextStyles.bodySmall),
                        ],
                      ),
                      const SizedBox(height: 12),
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

  Widget _buildControlAction({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFEDF6FF) : const Color(0xFFF7FAFD),
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? AppColors.primaryBlue : AppColors.borderLight,
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              color: isActive ? AppColors.primaryBlue : AppColors.textPrimaryDark,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: isActive ? AppColors.primaryBlue : AppColors.textSecondaryGrey,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}