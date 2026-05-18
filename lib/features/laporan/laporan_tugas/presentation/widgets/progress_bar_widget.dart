import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';

/// Progress bar orange di atas background navy semi-transparan
class ProgressBarWidget extends StatelessWidget {
  final double percentage; // 0.0 - 1.0
  final double height;

  const ProgressBarWidget({
    super.key,
    required this.percentage,
    this.height = 8,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: LinearProgressIndicator(
        value: percentage.clamp(0.0, 1.0),
        minHeight: height,
        backgroundColor: Colors.white.withValues(alpha: 0.15),
        valueColor:
            const AlwaysStoppedAnimation<Color>(AppColors.secondaryOrange),
      ),
    );
  }
}
