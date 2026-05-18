import 'package:flutter/material.dart';

import 'package:fitur_guru/core/constants/text_styles.dart';
class AbsensiTableHeader extends StatelessWidget {
  const AbsensiTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF0D2E63),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              'Nama Siswa',
              style: AppTextStyles.cardTitle.copyWith(color: Colors.white),
            ),
          ),
          ...const [
            _HeadCell(label: 'H'),
            _HeadCell(label: 'I'),
            _HeadCell(label: 'S'),
            _HeadCell(label: 'D'),
            _HeadCell(label: 'A'),
          ],
        ],
      ),
    );
  }
}

class _HeadCell extends StatelessWidget {
  final String label;

  const _HeadCell({required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          label,
          style: AppTextStyles.cardTitle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}