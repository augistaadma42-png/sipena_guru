import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

class TugasInfoSection extends StatelessWidget {
  final String tugasTitle;
  final String submittedAt;
  const TugasInfoSection({
    super.key, required this.tugasTitle, required this.submittedAt});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoRow(label: 'Tugas', value: tugasTitle, isBold: true),
        const SizedBox(height: 6),
        _InfoRow(label: 'Dikirim pada', value: submittedAt),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  const _InfoRow({required this.label, required this.value, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 95,
          child: Text('$label :', style: AppTextStyles.labelStyle)),
        Expanded(
          child: Text(value,
            style: isBold
                ? AppTextStyles.cardTitle.copyWith(fontSize: 13)
                : AppTextStyles.cardSubtitle.copyWith(
                    color: AppColors.textPrimary, fontSize: 13)),
        ),
      ],
    );
  }
}