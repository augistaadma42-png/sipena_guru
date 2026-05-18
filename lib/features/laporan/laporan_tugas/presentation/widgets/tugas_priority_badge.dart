import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../domain/entities/assignment_entity.dart';

/// Badge prioritas tugas (HIGH PRIORITY / REGULAR)
class TugasPriorityBadge extends StatelessWidget {
  final AssignmentPriority priority;

  const TugasPriorityBadge({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    final isHigh = priority == AssignmentPriority.high;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isHigh
            ? const Color(0xFFFFE4E4) // merah soft
            : const Color(0xFFEEEEEE), // abu soft
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isHigh ? 'HIGH PRIORITY' : 'REGULAR',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: isHigh
              ? const Color(0xFFDC2626)
              : AppColors.textSecondary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
