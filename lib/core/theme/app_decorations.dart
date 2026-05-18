import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// Custom Widget Styles untuk aplikasi Sipena
class AppDecorations {
  AppDecorations._();
  
  // ============== CARD STYLES ==============
  
  /// Card default untuk menu dashboard
  static BoxDecoration get menuCard => BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: AppColors.borderLight),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.04),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );
  
  /// Card untuk data table row
  static BoxDecoration get tableCard => BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: AppColors.borderLight),
  );
  
  /// Card dengan gradient header
  static BoxDecoration gradientCard(Color primary, Color secondary) => BoxDecoration(
    gradient: LinearGradient(
      colors: [primary, secondary],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(12),
  );
  
  // ============== BUTTON STYLES ==============
  
  /// Primary button
  static BoxDecoration get primaryButton => BoxDecoration(
    color: AppColors.primaryBlue,
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Secondary button (outlined)
  static BoxDecoration get secondaryButton => BoxDecoration(
    border: Border.all(color: AppColors.primaryBlue),
    borderRadius: BorderRadius.circular(8),
  );
  
  /// FAB button
  static BoxDecoration get fabButton => BoxDecoration(
    color: AppColors.secondaryOrange,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppColors.secondaryOrange.withOpacity(0.4),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  );
  
  // ============== STATUS BADGES ==============
  
  /// Status hadir - hijau
  static BoxDecoration get statusHadir => BoxDecoration(
    color: AppColors.successGreen.withOpacity(0.15),
    borderRadius: BorderRadius.circular(20),
  );
  
  /// Status belum - oranye
  static BoxDecoration get statusBelum => BoxDecoration(
    color: AppColors.warningOrange.withOpacity(0.15),
    borderRadius: BorderRadius.circular(20),
  );
  
  /// Status tidak hadir - abu
  static BoxDecoration get statusTidakHadir => BoxDecoration(
    color: AppColors.disabledGrey.withOpacity(0.15),
    borderRadius: BorderRadius.circular(20),
  );
  
  // ============== INPUT STYLES ==============
  
  /// Text field default
  static BoxDecoration get textField => BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: AppColors.borderLight),
  );
  
  /// Text field focus
  static BoxDecoration get textFieldFocus => BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: AppColors.primaryBlue, width: 2),
  );
  
  // ============== AVATAR STYLES ==============
  
  /// Avatar lingkaran
  static BoxDecoration get avatarCircle => const BoxDecoration(
    shape: BoxShape.circle,
    color: AppColors.lightBlueBg,
  );
  
  /// Avatar dengan border
  static BoxDecoration avatarWithBorder(Color borderColor) => BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: borderColor, width: 2),
    color: AppColors.lightBlueBg,
  );
  
  // ============== CONTAINER STYLES ==============
  
  /// Container utama dengan shadow
  static BoxDecoration get mainContainer => BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 16,
        offset: const Offset(0, 4),
      ),
    ],
  );
  
  /// Container section
  static BoxDecoration get sectionContainer => BoxDecoration(
    color: AppColors.backgroundLight,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: AppColors.borderLight),
  );
  
  // ============== CHART COLORS ==============
  
  ///Colors untuk pie/bar charts
  static List<Color> get chartColors => [
    AppColors.primaryBlue,
    AppColors.secondaryOrange,
    AppColors.successGreen,
    AppColors.warningOrange,
    AppColors.disabledGrey,
    const Color(0xFF8B5CF6), // Purple
    const Color(0xFF06B6D4), // Cyan
    const Color(0xFFEC4899), // Pink
  ];
}