import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';
import '../../domain/entities/tugas_entity.dart';
import '../../../detail_tugas/presentation/pages/rekap_pengumpulan_tugas_page.dart';
import 'tugas_badge.dart';
import 'deadline_widget.dart';
import 'anggota_avatar_group.dart';

class TugasCard extends StatelessWidget {
  final TugasEntity tugas;

  const TugasCard({super.key, required this.tugas});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RekapPengumpulanTugasPage(
              tugasId: tugas.id,
              tugasTitle: tugas.title,
              tugasSubtitle: tugas.subtitle,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TugasBadge(
                  label: tugas.kelas,
                  isBlue: !tugas.isUrgent,
                ),
                DeadlineWidget(
                  sisaHari: tugas.sisaHari,
                  isUrgent: tugas.isUrgent,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              tugas.title,
              style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              tugas.subtitle,
              style: AppTextStyles.cardSubtitle.copyWith(fontSize: 14),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(height: 1, color: AppColors.borderLight),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnggotaAvatarGroup(totalAnggota: tugas.totalAnggota),
                Text(
                  'Deadline: ${tugas.deadline}',
                  style: AppTextStyles.labelStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
