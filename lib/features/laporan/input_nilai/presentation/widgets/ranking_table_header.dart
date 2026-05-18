import 'package:flutter/material.dart';

import 'package:fitur_guru/core/constants/text_styles.dart';

class RankingTableHeader extends StatelessWidget {
  const RankingTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFFF1F5F9),
        borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 44,
            child: Text(
              'PERINGKAT',
              style: AppTextStyles.tableHeader.copyWith(
                fontSize: 10,
                letterSpacing: 0.6,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'NAMA',
              style: AppTextStyles.tableHeader.copyWith(
                fontSize: 10,
                letterSpacing: 0.6,
              ),
            ),
          ),
          SizedBox(
            width: 56,
            child: Text(
              'NILAI',
              textAlign: TextAlign.right,
              style: AppTextStyles.tableHeader.copyWith(
                fontSize: 10,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
