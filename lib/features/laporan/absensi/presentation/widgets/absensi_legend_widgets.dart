import 'package:flutter/material.dart';

import 'custom_status_badge.dart';

class AbsensiLegendWidget extends StatelessWidget {
  const AbsensiLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const CustomStatusBadge(
            code: 'H',
            label: 'Hadir',
            bgColor: Color(0xFFD1FAE5),
          ),
          const SizedBox(width: 8),
          const CustomStatusBadge(
            code: 'I',
            label: 'Izin',
            bgColor: Color(0xFFE0E7FF),
          ),
          const SizedBox(width: 8),
          const CustomStatusBadge(
            code: 'S',
            label: 'Sakit',
            bgColor: Color(0xFFFEF3C7),
          ),
          const SizedBox(width: 8),
          const CustomStatusBadge(
            code: 'D',
            label: 'Disp.',
            bgColor: Color(0xFFEDE9FE),
          ),
          const SizedBox(width: 8),
          const CustomStatusBadge(
            code: 'A',
            label: 'Alfa',
            bgColor: Color(0xFFFEE2E2),
          ),
        ],
      ),
    );
  }
}