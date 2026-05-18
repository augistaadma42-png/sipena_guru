import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

/// Tombol Export PDF full-width dengan warna orange
class ExportPdfButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ExportPdfButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryOrange,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon PDF
            Container(
              padding: const EdgeInsets.all(4),
              child: const Icon(
                Icons.picture_as_pdf_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Export PDF',
              style: AppTextStyles.buttonText,
            ),
          ],
        ),
      ),
    );
  }
}