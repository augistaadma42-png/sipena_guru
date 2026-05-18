import 'package:flutter/material.dart';

import 'package:fitur_guru/core/constants/text_styles.dart';import 'summary_stat_item.dart';

class AttendanceSummaryCard extends StatelessWidget {
  final String averageAttendance;
  final String totalAlfa;

  const AttendanceSummaryCard({
    super.key,
    required this.averageAttendance,
    required this.totalAlfa,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0E3574),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -38,
            bottom: -42,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.10),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ringkasan Kehadiran Kelas',
                style: AppTextStyles.sectionTitle.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  SummaryStatItem(
                    value: averageAttendance,
                    label: 'RATA-RATA HADIR',
                  ),
                  const SizedBox(width: 12),
                  SummaryStatItem(
                    value: totalAlfa,
                    label: 'TOTAL ALFA (BLN INI)',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}