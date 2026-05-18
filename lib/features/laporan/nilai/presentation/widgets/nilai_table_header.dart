import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

/// Header tabel daftar nilai siswa
class NilaiTableHeader extends StatelessWidget {
  const NilaiTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.backgroundLight,
        border: Border(
          top: BorderSide(color: AppColors.borderLight),
          bottom: BorderSide(color: AppColors.borderLight),
        ),
      ),
      child: Row(
        children: [
          // Kolom NO
          SizedBox(
            width: 36,
            child: Text('NO', style: AppTextStyles.tableHeader),
          ),
          // Kolom NAMA SISWA
          Expanded(
            flex: 3,
            child: Text('NAMA\nSISWA', style: AppTextStyles.tableHeader),
          ),
          // Kolom KELAS
          Expanded(
            flex: 2,
            child: Text('KELAS', style: AppTextStyles.tableHeader),
          ),
          // Kolom NILAI
          Expanded(
            flex: 2,
            child: Text(
              'NILAI',
              style: AppTextStyles.tableHeader,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}