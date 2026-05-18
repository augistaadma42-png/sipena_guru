import 'package:flutter/material.dart';

import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

class ExportPdfButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ExportPdfButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.62,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.secondaryOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          shadowColor: AppColors.secondaryOrange.withValues(alpha: 0.38),
        ).copyWith(
          shadowColor:
              WidgetStatePropertyAll(AppColors.secondaryOrange.withValues(alpha: 0.35)),
          elevation: const WidgetStatePropertyAll(8),
        ),
        icon: const Icon(Icons.picture_as_pdf_outlined, color: Colors.white),
        label: Text('Simpan PDF', style: AppTextStyles.buttonText),
      ),
    );
  }
}