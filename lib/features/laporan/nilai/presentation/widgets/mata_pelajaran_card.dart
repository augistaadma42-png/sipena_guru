import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

/// Card yang menampilkan informasi mata pelajaran
class MataPelajaranCard extends StatelessWidget {
  final String labelMapel;
  final String namaMapel;

  const MataPelajaranCard({
    super.key,
    this.labelMapel = 'MATA PELAJARAN',
    this.namaMapel = 'Matematika Peminatan',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon container oranye muda
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.lightOrangeBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: AppColors.secondaryOrange,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          // Info teks
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                labelMapel,
                style: AppTextStyles.labelStyle.copyWith(
                  letterSpacing: 0.8,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                namaMapel,
                style: AppTextStyles.sectionTitle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}