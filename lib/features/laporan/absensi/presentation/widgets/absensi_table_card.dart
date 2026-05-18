import 'package:flutter/material.dart';

import 'package:fitur_guru/core/constants/colors.dart';import '../../domain/entities/student_attendance_entity.dart';
import 'absensi_student_row.dart';
import 'absensi_table_header.dart';

class AbsensiTableCard extends StatelessWidget {
  final List<StudentAttendanceEntity> students;

  const AbsensiTableCard({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const AbsensiTableHeader(),
          ListView.separated(
            itemCount: students.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, index) => Divider(
              height: 1,
              thickness: 1,
              color: AppColors.borderLight,
            ),
            itemBuilder: (context, index) {
              return AbsensiStudentRow(student: students[index]);
            },
          ),
        ],
      ),
    );
  }
}