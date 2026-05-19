import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';

/// Progress bar linear untuk menampilkan persentase pengumpulan
class ProgressPengumpulanBar extends StatelessWidget {
  final double percentage; // 0.0 - 1.0

  const ProgressPengumpulanBar({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: AppTextStyles.labelStyle,
            ),
            Text(
              '${(percentage * 100).toInt()}%',
              style: AppTextStyles.labelStyle.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 8,
            backgroundColor: AppColors.borderLight,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.successGreen,
            ),
          ),
        ),
      ],
    );
  }
}
