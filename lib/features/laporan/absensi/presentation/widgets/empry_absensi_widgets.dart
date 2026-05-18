import 'package:flutter/material.dart';

import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';
class EmptyAbsensiWidget extends StatelessWidget {
  const EmptyAbsensiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Icon(
            Icons.inbox_rounded,
            size: 46,
            color: AppColors.disabledGrey,
          ),
          const SizedBox(height: 10),
          Text(
            'Belum ada data absensi untuk periode ini.',
            textAlign: TextAlign.center,
            style: AppTextStyles.cardSubtitle,
          ),
        ],
      ),
    );
  }
}