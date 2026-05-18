import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';

class DeadlineWidget extends StatelessWidget {
  final String sisaHari;
  final bool isUrgent;

  const DeadlineWidget({
    super.key,
    required this.sisaHari,
    required this.isUrgent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time_rounded,
          size: 14,
          color: isUrgent ? Colors.red : AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          sisaHari,
          style: AppTextStyles.labelStyle.copyWith(
            color: isUrgent ? Colors.red : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
