import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get splashTitle => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textWhite,
    height: 1.2,
  );

  static TextStyle get screenTitle => GoogleFonts.inter(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimaryDark,
    height: 1.25,
  );

  static TextStyle get sectionTitle => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle get itemTitle => GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryGrey,
    height: 1.4,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryGrey,
    height: 1.35,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );

  static TextStyle get labelSemibold => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle get buttonText => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
  );

  static TextStyle get badgeText => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );
}