import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

/// Widget yang menampilkan informasi validasi laporan
class ValidationInfoWidget extends StatelessWidget {
  final String validationText;

  const ValidationInfoWidget({
    super.key,
    this.validationText =
        'Laporan ini telah divalidasi oleh sistem pada 27 Okt 2023.',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon info biru
        const Icon(
          Icons.info_outline_rounded,
          size: 18,
          color: AppColors.primaryBlue,
        ),
        const SizedBox(width: 8),
        // Teks validasi
        Expanded(
          child: Text(
            validationText,
            style: AppTextStyles.validationText,
          ),
        ),
      ],
    );
  }
}   