import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fitur_guru/core/constants/colors.dart';

class LihatSemuaButton extends StatelessWidget {
  final bool expanded;
  final VoidCallback onPressed;

  const LihatSemuaButton({
    super.key,
    required this.expanded,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        size: 20,
        color: AppColors.primaryBlue,
      ),
      label: Text(
        expanded ? 'Sembunyikan' : 'Lihat Semua',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryBlue,
        ),
      ),
    );
  }
}
