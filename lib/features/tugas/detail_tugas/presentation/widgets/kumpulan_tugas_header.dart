import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';

/// Header kecil "Kumpulan Tugas Siswa" sebelum list
class KumpulanTugasHeader extends StatelessWidget {
  const KumpulanTugasHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              color: AppColors.secondaryOrange,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Kumpulan Tugas Siswa',
            style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
