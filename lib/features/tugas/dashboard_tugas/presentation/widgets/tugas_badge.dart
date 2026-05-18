import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';

class TugasBadge extends StatelessWidget {
  final String label;
  final bool isBlue;

  const TugasBadge({
    super.key,
    required this.label,
    this.isBlue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isBlue ? AppColors.lightBlueBg : AppColors.lightOrangeBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelStyle.copyWith(
          color: isBlue ? AppColors.primaryBlue : AppColors.secondaryOrange,
          fontWeight: FontWeight.w700,
          fontSize: 10,
        ),
      ),
    );
  }
}
