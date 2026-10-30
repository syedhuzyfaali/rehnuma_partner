import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../controllers/job_controller.dart';
import '../widgets/live_osm_map_widget.dart';
import '../../domain/job_model.dart';

class OnWayScreen extends ConsumerStatefulWidget {
  final String jobId;

  const OnWayScreen({super.key, required this.jobId});

  @override
  ConsumerState<OnWayScreen> createState() => _OnWayScreenState();
}

class _OnWayScreenState extends ConsumerState<OnWayScreen> {
  late final List<TextEditingController> _otpControllers;
  String? _liveTurnInstruction;

  @override
  void initState() {
    super.initState();
    final activeJob = ref.read(activeJobProvider);
    final otpStr = activeJob?.arrivalOtp ?? "5914";

    _otpControllers = List.generate(
      4,
          (i) => TextEditingController(
        text: i < otpStr.length ? otpStr[i] : '',
      ),
    );
  }

  @override
  void dispose() {
    for (final c in _otpControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onVerifyOtp(JobRequest job) {
    final enteredOtp = _otpControllers.map((c) => c.text.trim()).join();
    if (enteredOtp.length == 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Arrival OTP verified! Job started.")),
      );
      context.push('/jobs/${job.id}/in-progress');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the complete 4-digit code.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final incomingRequests = ref.watch(incomingJobsProvider);
    final activeJob = ref.watch(activeJobProvider) ??
        incomingRequests.firstWhere(
              (j) => j.id == widget.jobId,
          orElse: () => incomingRequests.first,
        );

    final startCoord = LatLng(activeJob.handymanLatitude, activeJob.handymanLongitude);
    final destCoord = LatLng(activeJob.clientLatitude, activeJob.clientLongitude);

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
                    Text("On your way", style: AppTextStyles.screenTitle),
                    const SizedBox(height: 4),
                    Text("${activeJob.title} · Request #${activeJob.id}", style: AppTextStyles.bodyMedium),
                    const SizedBox(height: 18),

                    // Turn-by-turn guidance banner
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0072C6),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.turn_right_rounded, color: AppColors.surfaceWhite, size: 28),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _liveTurnInstruction ?? activeJob.turnInstruction,
                                  style: AppTextStyles.itemTitle.copyWith(
                                    color: AppColors.surfaceWhite,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  activeJob.clientLocation,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.surfaceWhite.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 🗺️ EMBEDDED LIVE OPENSTREETMAP
                    LiveOsmMapWidget(
                      startPoint: startCoord,
                      destinationPoint: destCoord,
                      etaText: activeJob.etaText,
                      distanceText: activeJob.distanceText,
                      onInstructionUpdated: (instruction) {
                        setState(() {
                          _liveTurnInstruction = instruction;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Client Information Card with quick call/chat triggers
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
                                  Text(activeJob.clientName, style: AppTextStyles.itemTitle.copyWith(fontSize: 17)),
                                  const SizedBox(height: 2),
                                  Text(
                                    "Arrive in ${activeJob.etaText} · ${activeJob.distanceText} away",
                                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondaryGrey),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => context.push('/jobs/${activeJob.id}/chat'),
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEDF6FF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(Icons.chat_bubble_outline, size: 20, color: AppColors.primaryBlue),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () => context.push('/jobs/${activeJob.id}/call'),
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEDF6FF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(Icons.phone_outlined, size: 20, color: AppColors.primaryBlue),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            activeJob.clientLocation,
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimaryDark),
                          ),
                          const SizedBox(height: 16),
                          const Divider(height: 1, color: AppColors.borderLight),
                          const SizedBox(height: 16),

                          // Arrival OTP Section
                          Text("Arrival OTP", style: AppTextStyles.labelSemibold),
                          const SizedBox(height: 4),
                          Text(
                            "Confirm the code with ${activeJob.clientName} when you arrive. Verify before starting work.",
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondaryGrey),
                          ),
                          const SizedBox(height: 16),

                          // 4 OTP Digit Display Boxes
                          // 4 OTP Boxes
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(4, (index) {
                              return Container(
                                width: 62,
                                height: 62,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF7FAFD),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: AppColors.primaryBlue, width: 1.5),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Center(
                                    child: TextField(
                                      controller: _otpControllers[index],
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1, // Restricts input to 1 character per box
                                      style: AppTextStyles.screenTitle.copyWith(
                                        fontSize: 22,
                                        color: const Color(0xFF0072C6),
                                      ),
                                      decoration: const InputDecoration(
                                        counterText: "", // Hides the character limit counter text
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 18),

                          // Verify Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => _onVerifyOtp(activeJob),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.verified_outlined, size: 18),
                                  SizedBox(width: 8),
                                  Text("Verify"),
                                ],
                              ),
                            ),
                          ),
                        ],
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
}