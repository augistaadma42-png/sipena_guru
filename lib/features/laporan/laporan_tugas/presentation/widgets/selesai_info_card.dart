import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/text_styles.dart';

/// Info card "X Siswa Sudah Mengumpulkan" dengan border dashed
class SelesaiInfoCard extends StatelessWidget {
  final int count;

  const SelesaiInfoCard({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.successGreen.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.successGreen.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_outline_rounded,
              color: AppColors.successGreen,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '$count Siswa Sudah Mengumpulkan',
            style: AppTextStyles.cardTitle.copyWith(
              color: AppColors.successGreen,
            ),
          ),
        ],
      ),
    );
  }
}
