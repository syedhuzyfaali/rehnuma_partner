import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../../../jobs/presentation/controllers/job_controller.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late TextEditingController _firstNameCtrl;
  late TextEditingController _middleNameCtrl;
  late TextEditingController _lastNameCtrl;
  late TextEditingController _cnicCtrl;
  late TextEditingController _contactCtrl;
  late TextEditingController _bioCtrl;
  late Set<String> _selectedSkills;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider);
    _firstNameCtrl = TextEditingController(text: profile.firstName);
    _middleNameCtrl = TextEditingController(text: profile.middleName ?? "");
    _lastNameCtrl = TextEditingController(text: profile.lastName);
    _cnicCtrl = TextEditingController(text: profile.cnic);
    _contactCtrl = TextEditingController(text: profile.contactNumber);
    _bioCtrl = TextEditingController(text: profile.bio);
    _selectedSkills = profile.skills.toSet();
  }

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

  void _onSave() {
    ref.read(profileProvider.notifier).updateProfile(
      firstName: _firstNameCtrl.text.trim(),
      middleName: _middleNameCtrl.text.trim().isEmpty ? null : _middleNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      cnic: _cnicCtrl.text.trim(),
      contactNumber: _contactCtrl.text.trim(),
      bio: _bioCtrl.text.trim(),
      skills: _selectedSkills.toList(),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile changes saved successfully!")),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);

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
                    Text("My profile", style: AppTextStyles.screenTitle),
                    const SizedBox(height: 6),
                    Text(
                      "Keep your details up to date so clients know who’s coming to help.",
                      style: AppTextStyles.bodyLarge,
                    ),
                    const SizedBox(height: 20),

                    // Profile Picture Box
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7FAFD),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderLight, width: 1),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.network(
                              profile.avatarUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) => Container(
                                width: 60,
                                height: 60,
                                color: const Color(0xFFD6E9FA),
                                child: const Icon(Icons.person, color: AppColors.primaryBlue, size: 30),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Change profile picture",
                                  style: AppTextStyles.labelSemibold.copyWith(
                                    color: AppColors.primaryBlue,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text("JPG or PNG · up to 5 MB", style: AppTextStyles.bodySmall),
                              ],
                            ),
                          ),
                          const Icon(Icons.upload_outlined, color: AppColors.primaryBlue, size: 24),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Verified Handyman Ali Raza badge
                    Row(
                      children: [
                        const Icon(Icons.verified, color: AppColors.primaryBlue, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          "Verified handyman · ${profile.fullName}",
                          style: AppTextStyles.labelSemibold.copyWith(
                            color: AppColors.primaryBlue,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Fields
                    Text("First Name", style: AppTextStyles.labelSemibold),
                    const SizedBox(height: 8),
                    TextField(controller: _firstNameCtrl),
                    const SizedBox(height: 16),

                    Text("Middle Name (Optional)", style: AppTextStyles.labelSemibold),
                    const SizedBox(height: 8),
                    TextField(controller: _middleNameCtrl),
                    const SizedBox(height: 16),

                    Text("Last Name", style: AppTextStyles.labelSemibold),
                    const SizedBox(height: 8),
                    TextField(controller: _lastNameCtrl),
                    const SizedBox(height: 16),

                    Text("CNIC No.", style: AppTextStyles.labelSemibold),
                    const SizedBox(height: 8),
                    TextField(controller: _cnicCtrl),
                    const SizedBox(height: 16),

                    Text("Contact No.", style: AppTextStyles.labelSemibold),
                    const SizedBox(height: 8),
                    TextField(controller: _contactCtrl),
                    const SizedBox(height: 16),

                    // Bio
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
                            ),
                          ),
                          const Divider(height: 16, color: AppColors.borderLight),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Can't type? Speak your bio.", style: AppTextStyles.bodySmall),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEDF6FF),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.mic_none, size: 18, color: AppColors.primaryBlue),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Skills
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Your skills", style: AppTextStyles.labelSemibold),
                        Text("Swipe to explore →", style: AppTextStyles.bodySmall),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 88,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _buildProfileSkillCard("Plumbing", Icons.build, _selectedSkills.contains("Plumbing")),
                          const SizedBox(width: 12),
                          _buildProfileSkillCard("Electrical", Icons.bolt, _selectedSkills.contains("Electrical")),
                          const SizedBox(width: 12),
                          _buildProfileSkillCard("Carpentry", Icons.handyman, _selectedSkills.contains("Carpentry")),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      "Changes to your name or CNIC will be reviewed by our admin team. Your other updates appear right away.",
                      style: AppTextStyles.bodySmall.copyWith(height: 1.4),
                    ),
                    const SizedBox(height: 20),

                    // Save Changes Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _onSave,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, size: 20),
                            SizedBox(width: 8),
                            Text("Save changes"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        "Demo account · All personal details are fictional",
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

  Widget _buildProfileSkillCard(String skill, IconData icon, bool isSelected) {
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