import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/constants/colors.dart';

class InputJudul extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool isRequired;
  final bool enabled;

  const InputJudul({
    super.key,
    required this.controller,
    this.label = 'Judul',
    this.hintText = 'Masukkan judul tugas',
    this.isRequired = true,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: enabled ? 1.0 : 0.45,
      duration: const Duration(milliseconds: 200),
      child: Container(
        decoration: BoxDecoration(
          color: enabled ? Colors.white : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: enabled ? AppColors.borderLight : AppColors.disabledGrey,
          ),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: enabled
                        ? AppColors.textPrimary
                        : AppColors.disabledGrey,
                  ),
                ),
                if (isRequired && enabled) ...[
                  const SizedBox(width: 6),
                  Text(
                    '* WAJIB DIISI',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.red.shade400,
                    ),
                  ),
                ],
                if (!enabled) ...[
                  const SizedBox(width: 6),
                  Text(
                    '(tidak tersedia)',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.disabledGrey,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              enabled: enabled,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: enabled
                    ? AppColors.textPrimary
                    : AppColors.disabledGrey,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.disabledGrey,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
