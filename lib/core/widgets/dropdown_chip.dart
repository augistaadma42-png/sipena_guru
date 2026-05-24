import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class DropdownChip extends StatelessWidget {
  final String value;
  final List<String> options;
  final ValueChanged<String?>? onChanged;
  // [CHANGE] Tambah parameter disabled untuk support state abu-abu
  final bool disabled;

  const DropdownChip({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: disabled
            ? AppColors.disabledGrey.withOpacity(0.08)
            : AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: disabled
              ? AppColors.disabledGrey.withOpacity(0.35)
              : AppColors.borderLight,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: disabled ? AppColors.disabledGrey : AppColors.textSecondary,
          ),
          style: GoogleFonts.inter(
            fontSize: 13,
            color: disabled ? AppColors.disabledGrey : AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
          items: options.map((opt) {
            return DropdownMenuItem<String>(
              value: opt,
              child: Text(opt),
            );
          }).toList(),
          // null = dropdown tidak bisa dibuka
          onChanged: disabled ? null : onChanged,
        ),
      ),
    ),
    );
  }
}
