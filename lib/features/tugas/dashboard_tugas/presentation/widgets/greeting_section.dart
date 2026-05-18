import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat pagi,',
            style: AppTextStyles.headerSubtitle.copyWith(
              color: AppColors.secondaryOrange,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Rian Syah, S.Pd',
            style: AppTextStyles.headerTitle.copyWith(
              color: AppColors.textPrimary,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}
