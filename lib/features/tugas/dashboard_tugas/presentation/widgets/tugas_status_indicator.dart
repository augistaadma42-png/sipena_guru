import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';

class TugasStatusIndicator extends StatelessWidget {
  final bool isCompleted;

  const TugasStatusIndicator({super.key, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isCompleted ? AppColors.successGreen : AppColors.warningOrange,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}
