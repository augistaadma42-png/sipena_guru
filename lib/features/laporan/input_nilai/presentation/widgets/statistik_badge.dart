import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Badge tren persentase pada kartu statistik (pill gelap).
class StatistikBadge extends StatelessWidget {
  final double trendPercent;

  const StatistikBadge({super.key, required this.trendPercent});

  @override
  Widget build(BuildContext context) {
    final sign = trendPercent >= 0 ? '+' : '';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF0F2744),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            trendPercent >= 0 ? Icons.trending_up : Icons.trending_down,
            size: 16,
            color: const Color(0xFF93C5FD),
          ),
          const SizedBox(width: 4),
          Text(
            '$sign${trendPercent.toStringAsFixed(1)}%',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFBFDBFE),
            ),
          ),
        ],
      ),
    );
  }
}
