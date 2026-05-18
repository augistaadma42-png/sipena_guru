import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/text_styles.dart';

/// Tombol "Lihat X Lainnya" dengan arrow bawah
class LihatLainnyaButton extends StatelessWidget {
  final int count;
  final VoidCallback? onTap;

  const LihatLainnyaButton({
    super.key,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lihat $count Lainnya',
              style: AppTextStyles.labelStyle.copyWith(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.primaryBlue,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
