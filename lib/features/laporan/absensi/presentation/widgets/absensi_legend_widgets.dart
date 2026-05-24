import 'package:flutter/material.dart';

import 'custom_status_badge.dart';

class AbsensiLegendWidget extends StatelessWidget {
  const AbsensiLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          CustomStatusBadge(
            code: 'H',
            label: 'Hadir',
            bgColor: Color(0xFFE6F4EA),
            textColor: Color(0xFF137333),
          ),
          SizedBox(width: 14),
          CustomStatusBadge(
            code: 'I',
            label: 'Izin',
            bgColor: Color(0xFFE8F0FE),
            textColor: Color(0xFF1A73E8),
          ),
          SizedBox(width: 14),
          CustomStatusBadge(
            code: 'S',
            label: 'Sakit',
            bgColor: Color(0xFFFEF7E0),
            textColor: Color(0xFFB06000),
          ),
          SizedBox(width: 14),
          CustomStatusBadge(
            code: 'D',
            label: 'Disp.',
            bgColor: Color(0xFFF3E8FF),
            textColor: Color(0xFF7C3AED),
          ),
          SizedBox(width: 14),
          CustomStatusBadge(
            code: 'A',
            label: 'Alfa',
            bgColor: Color(0xFFFCE8E6),
            textColor: Color(0xFFC5221F),
          ),
        ],
      ),
    );
  }
}