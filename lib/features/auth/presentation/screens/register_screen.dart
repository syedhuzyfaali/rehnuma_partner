import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_router.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../../../jobs/presentation/controllers/job_controller.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _firstNameCtrl = TextEditingController(text: "Ali");
  final _middleNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController(text: "Raza");
  final _cnicCtrl = TextEditingController(text: "35202-1234567-1");
  final _contactCtrl = TextEditingController(text: "+92 300 1234567");
  final _bioCtrl = TextEditingController();

  final List<String> _availableSkills = ["Plumbing", "Electrical", "Carpentry", "Painting", "Appliance"];
  final Set<String> _selectedSkills = {"Plumbing", "Electrical"};
  bool _isRecordingBio = false;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _middleNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _cnicCtrl.dispose();
    _contactCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  void _onRegister() {
    ref.read(profileProvider.notifier).updateProfile(
      firstName: _firstNameCtrl.text.trim(),
      middleName: _middleNameCtrl.text.trim().isEmpty ? null : _middleNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      cnic: _cnicCtrl.text.trim(),
      contactNumber: _contactCtrl.text.trim(),
      bio: _bioCtrl.text.trim().isEmpty
          ? "I repair taps, leaks and household wiring. 6 years of experience serving homes in Lahore."
          : _bioCtrl.text.trim(),
      skills: _selectedSkills.toList(),
    );
    context.push(AppRoutes.reviewPending);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerBlue,
      body: Column(
        children: [
          AppHeaderBar(
            showBackButton: true,
            onBackPress: () => context.go(AppRoutes.splash),
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Let’s get you started", style: AppTextStyles.screenTitle),
                      const SizedBox(height: 6),
                      Text(
                        "Join as a handyman. Turn your skills into work nearby.",
                        style: AppTextStyles.bodyLarge,
                      ),
                      const SizedBox(height: 24),

                      // Upload Profile Picture Box
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.cardLightBlue.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderLight, width: 1),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD8EDFF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.camera_alt_outlined, color: AppColors.primaryBlue, size: 26),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Upload profile picture",
                                    style: AppTextStyles.itemTitle.copyWith(fontSize: 15, color: AppColors.primaryBlue),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    "JPG or PNG · up to 5 MB",
                                    style: AppTextStyles.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.upload_outlined, color: AppColors.primaryBlue, size: 24),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // First Name
                      Text("First Name", style: AppTextStyles.labelSemibold),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _firstNameCtrl,
                        decoration: const InputDecoration(hintText: "First Name"),
                      ),
                      const SizedBox(height: 16),

                      // Middle Name (Optional)
                      Text("Middle Name (Optional)", style: AppTextStyles.labelSemibold),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _middleNameCtrl,
                        decoration: const InputDecoration(hintText: "Enter middle name"),
                      ),
                      const SizedBox(height: 16),

                      // Last Name
                      Text("Last Name", style: AppTextStyles.labelSemibold),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _lastNameCtrl,
                        decoration: const InputDecoration(hintText: "Last Name"),
                      ),
                      const SizedBox(height: 16),

                      // CNIC No.
                      Text("CNIC No.", style: AppTextStyles.labelSemibold),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _cnicCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: "35202-1234567-1"),
                      ),
                      const SizedBox(height: 16),

                      // Contact No.
                      Text("Contact No.", style: AppTextStyles.labelSemibold),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _contactCtrl,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(hintText: "+92 300 1234567"),
                      ),
                      const SizedBox(height: 16),

                      // Bio Field with voice dictation hint
                      Text("Bio", style: AppTextStyles.labelSemibold),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.inputBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderLight, width: 1.2),
                        ),
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: _bioCtrl,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                filled: false,
                                contentPadding: EdgeInsets.zero,
                                hintText: "Tell clients about your experience and the work you do.",
                              ),
                            ),
                            const Divider(height: 20, color: AppColors.borderLight),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _isRecordingBio ? "Listening..." : "Can't type? Speak your bio.",
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: _isRecordingBio ? AppColors.callRed : AppColors.textMuted,
                                    fontWeight: _isRecordingBio ? FontWeight.w600 : FontWeight.w500,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isRecordingBio = !_isRecordingBio;
                                      if (_isRecordingBio) {
                                        _bioCtrl.text = "I repair taps, leaks and household wiring. 6 years of experience serving homes in Lahore.";
                                      }
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: _isRecordingBio ? const Color(0xFFFFEAEA) : const Color(0xFFEDF6FF),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      _isRecordingBio ? Icons.mic : Icons.mic_none,
                                      size: 20,
                                      color: _isRecordingBio ? AppColors.callRed : AppColors.primaryBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Your Skills
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Your skills", style: AppTextStyles.labelSemibold),
                          Text("Swipe to explore →", style: AppTextStyles.bodySmall),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 90,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            _buildSkillCard("Plumbing", Icons.build, _selectedSkills.contains("Plumbing")),
                            const SizedBox(width: 12),
                            _buildSkillCard("Electrical", Icons.bolt, _selectedSkills.contains("Electrical")),
                            const SizedBox(width: 12),
                            _buildSkillCard("Carpentry", Icons.handyman, _selectedSkills.contains("Carpentry")),
                            const SizedBox(width: 12),
                            _buildSkillCard("Painting", Icons.format_paint, _selectedSkills.contains("Painting")),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 10,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.borderLight,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // CNIC Security notice
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.verified_user_outlined, color: AppColors.primaryBlue, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Your CNIC is only used by our admin team to verify your identity.",
                              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondaryGrey),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Register Action Button
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: _onRegister,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_forward, size: 20),
                              SizedBox(width: 8),
                              Text("Register"),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Center(
                        child: Text(
                          "By registering, you agree to our Terms of Service and Privacy Policy.",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          "Demo account · All personal details are fictional",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodySmall.copyWith(fontSize: 11, color: AppColors.textMuted),
                        ),
                      ),
                      const SizedBox(height: 24),
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

  Widget _buildSkillCard(String skill, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedSkills.remove(skill);
          } else {
            _selectedSkills.add(skill);
          }
        });
      },
      child: Container(
        width: 104,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0F7FF) : AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.borderLight,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 24),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    skill,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelSemibold.copyWith(
                      fontSize: 12,
                      color: isSelected ? AppColors.primaryBlue : AppColors.textPrimaryDark,
                    ),
                  ),
                ),
                if (isSelected) ...[
                  const SizedBox(width: 3),
                  const Icon(Icons.check, size: 13, color: AppColors.primaryBlue),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}