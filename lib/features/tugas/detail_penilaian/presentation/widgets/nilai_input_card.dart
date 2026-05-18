import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';
import 'custom_nilai_field.dart';

class NilaiInputCard extends StatelessWidget {
  final int currentNilai;
  final ValueChanged<int> onNilaiChanged;
  const NilaiInputCard({super.key, required this.currentNilai,
      required this.onNilaiChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(
          color: Color(0x0D000000), blurRadius: 16, offset: Offset(0, 4))],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Beri Nilai (0 - 100)', style: AppTextStyles.sectionTitle),
          const SizedBox(height: 14),
          CustomNilaiField(initialValue: currentNilai, onChanged: onNilaiChanged),
        ],
      ),
    );
  }
}