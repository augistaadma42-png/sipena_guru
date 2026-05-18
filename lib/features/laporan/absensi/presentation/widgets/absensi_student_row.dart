import 'package:flutter/material.dart';

import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';import '../../domain/entities/student_attendance_entity.dart';

class AbsensiStudentRow extends StatelessWidget {
  final StudentAttendanceEntity student;

  const AbsensiStudentRow({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.nama,
                  style: AppTextStyles.cardTitle.copyWith(
                    color: AppColors.primaryBlue,
                    fontSize: 20,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'NIS: ${student.nis}',
                  style: AppTextStyles.cardSubtitle,
                ),
              ],
            ),
          ),
          _ValueCell(value: student.hadir),
          _ValueCell(value: student.izin),
          _ValueCell(value: student.sakit),
          _ValueCell(value: student.dispensasi),
          _ValueCell(value: student.alfa),
        ],
      ),
    );
  }
}

class _ValueCell extends StatelessWidget {
  final int value;

  const _ValueCell({required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          '$value',
          style: AppTextStyles.cardTitle.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}