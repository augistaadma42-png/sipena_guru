import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';
import '../../domain/entities/detail_penilaian_entity.dart';
import 'avatar_siswa.dart';
import 'tugas_info_section.dart';

class SiswaProfileCard extends StatelessWidget {
  final DetailPenilaianEntity entity;
  const SiswaProfileCard({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(
          color: Color(0x0D000000), blurRadius: 16, offset: Offset(0, 4))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AvatarSiswa(nama: entity.studentName, radius: 38),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entity.studentName,
                          style: AppTextStyles.headerTitle.copyWith(fontSize: 18)),
                      const SizedBox(height: 4),
                      Text('NISN: ${entity.nisn}',
                          style: AppTextStyles.cardSubtitle.copyWith(fontSize: 13)),
                      const SizedBox(height: 10),
                      _KelasBadge(kelas: entity.kelas),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(color: AppColors.borderLight, height: 1),
            ),
            TugasInfoSection(
              tugasTitle: entity.tugasTitle,
              submittedAt: entity.submittedAt,
            ),
          ],
        ),
      ),
    );
  }
}

class _KelasBadge extends StatelessWidget {
  final String kelas;
  const _KelasBadge({required this.kelas});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.lightBlueBg, borderRadius: BorderRadius.circular(20)),
      child: Text(kelas,
        style: AppTextStyles.labelStyle.copyWith(
          color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
    );
  }
}