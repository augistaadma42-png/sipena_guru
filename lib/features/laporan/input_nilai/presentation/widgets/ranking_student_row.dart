import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/features/laporan/input_nilai/domain/entities/student_ranking_entity.dart';

import 'ranking_badge.dart';

class RankingStudentRow extends StatelessWidget {
  final StudentRankingEntity student;

  const RankingStudentRow({super.key, required this.student});

  Color get _scoreColor {
    if (student.ranking == 1) return const Color(0xFFC2410C);
    return AppColors.primaryBlue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RankingBadge(rank: student.ranking),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.nama,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'NIS: ${student.nis}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            student.nilai.toStringAsFixed(1),
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: _scoreColor,
            ),
          ),
        ],
      ),
    );
  }
}
