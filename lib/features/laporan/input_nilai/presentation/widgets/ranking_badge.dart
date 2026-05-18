import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fitur_guru/core/constants/colors.dart';

/// Badge bulat nomor peringkat dengan gradasi orange per rank.
class RankingBadge extends StatelessWidget {
  final int rank;

  const RankingBadge({super.key, required this.rank});

  Color get _bg {
    switch (rank) {
      case 1:
        return const Color(0xFFC2410C);
      case 2:
        return AppColors.secondaryOrange;
      case 3:
        return const Color(0xFFFFB38A);
      default:
        return AppColors.disabledGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _bg,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: _bg.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        '$rank',
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }
}
