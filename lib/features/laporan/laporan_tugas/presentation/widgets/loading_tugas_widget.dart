import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';

/// Loading widget saat data sedang dimuat
class LoadingTugasWidget extends StatelessWidget {
  const LoadingTugasWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 60),
        child: CircularProgressIndicator(
          color: AppColors.primaryBlue,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
