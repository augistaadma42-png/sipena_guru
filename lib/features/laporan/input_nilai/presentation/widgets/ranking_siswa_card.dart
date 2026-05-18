import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';
import 'package:fitur_guru/features/laporan/input_nilai/domain/entities/student_ranking_entity.dart';

import 'lihat_semua_button.dart';
import 'ranking_student_row.dart';
import 'ranking_table_header.dart';

class RankingSiswaCard extends StatelessWidget {
  final List<StudentRankingEntity> rankings;
  final bool showAll;
  final VoidCallback onToggleShowAll;

  const RankingSiswaCard({
    super.key,
    required this.rankings,
    required this.showAll,
    required this.onToggleShowAll,
  });

  double _horizontalPadding(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w > 600) return 32;
    return 16;
  }

  @override
  Widget build(BuildContext context) {
    final h = _horizontalPadding(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: h),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Peringkat Siswa',
                      style: AppTextStyles.sectionTitle.copyWith(fontSize: 17),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Tertinggi',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.swap_vert_rounded,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: RankingTableHeader(),
            ),
            const SizedBox(height: 4),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: rankings.length,
              separatorBuilder: (_, _) => const Divider(
                height: 1,
                thickness: 1,
                color: AppColors.borderLight,
                indent: 16,
                endIndent: 16,
              ),
              itemBuilder: (context, index) {
                return RankingStudentRow(student: rankings[index]);
              },
            ),
            Center(
              child: LihatSemuaButton(
                expanded: showAll,
                onPressed: onToggleShowAll,
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
