import 'package:flutter/material.dart';

import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

/// FAB pill ekspor PDF (dummy).
class InputNilaiExportPdfButton extends StatelessWidget {
  final VoidCallback onPressed;

  const InputNilaiExportPdfButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      shadowColor: AppColors.secondaryOrange.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(999),
      color: AppColors.secondaryOrange,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.picture_as_pdf_outlined, color: Colors.white, size: 22),
              const SizedBox(width: 8),
              Text('Simpan PDF', style: AppTextStyles.buttonText),
            ],
          ),
        ),
      ),
    );
  }
}
