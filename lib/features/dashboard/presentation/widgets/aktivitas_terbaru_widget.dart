import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

import '../../domain/entities/aktivitas_entity.dart';

class AktivitasTerbaruWidget extends StatelessWidget {
  final VoidCallback? onLihatSemua;
  final List<AktivitasEntity> aktivitasList;

  const AktivitasTerbaruWidget({
    Key? key,
    this.onLihatSemua,
    required this.aktivitasList,
  }) : super(key: key);

  Color _jenisColor(String jenis) {
    switch (jenis) {
      case 'absensi':
        return AppColors.primaryBlue;
      case 'jurnal':
        return const Color(0xFF6A1B9A);
      case 'tugas':
        return AppColors.secondaryOrange;
      case 'nilai':
        return const Color(0xFF2E7D32);
      case 'pengajuan':
        return const Color(0xFF1565C0);
      default:
        return AppColors.textSecondary;
    }
  }

  Color _jenisBg(String jenis) {
    switch (jenis) {
      case 'absensi':
        return AppColors.primaryBlue.withOpacity(0.1);
      case 'jurnal':
        return const Color(0xFFF3E5F5);
      case 'tugas':
        return const Color(0xFFFFF3E0);
      case 'nilai':
        return const Color(0xFFE8F5E9);
      case 'pengajuan':
        return const Color(0xFFE3F2FD);
      default:
        return AppColors.backgroundLight;
    }
  }

  Widget _buildAktivitasItem({
    required String tanggal,
    required String jam,
    required String deskripsi,
    required String jenis,
    required IconData icon,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _jenisBg(jenis),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18, color: _jenisColor(jenis)),
            ),
            if (!isLast)
              Container(width: 2, height: 32, color: AppColors.borderLight),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deskripsi,
                  style: AppTextStyles.cardTitle.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 3),
                Text(
                  '$tanggal • $jam',
                  style: AppTextStyles.cardSubtitle.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayedActivities = aktivitasList.take(5).toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Aktivitas Terbaru', style: AppTextStyles.sectionTitle),
              GestureDetector(
                onTap: onLihatSemua,
                child: Text(
                  'Lihat Semua →',
                  style: AppTextStyles.labelStyle.copyWith(
                    color: AppColors.secondaryOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...displayedActivities.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return _buildAktivitasItem(
              tanggal: item.tanggal,
              jam: item.jam,
              deskripsi: item.deskripsi,
              jenis: item.jenis,
              icon: item.icon,
              isLast: index == displayedActivities.length - 1,
            );
          }).toList(),
        ],
      ),
    );
  }
}
