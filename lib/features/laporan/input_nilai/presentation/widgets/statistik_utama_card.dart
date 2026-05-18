import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/features/laporan/input_nilai/domain/entities/class_statistics_entity.dart';

import 'statistik_badge.dart';
import 'statistik_chart_placeholder.dart';

/// Kartu navy statistik utama kelas.
class StatistikUtamaCard extends StatelessWidget {
  final ClassStatisticsEntity statistics;

  const StatistikUtamaCard({super.key, required this.statistics});

  @override
  Widget build(BuildContext context) {
    final horizontal = _horizontalPadding(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 22, 16, 20),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withValues(alpha: 0.28),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -4,
              top: 8,
              child: Opacity(
                opacity: 0.95,
                child: Transform.rotate(
                  angle: -0.05,
                  child: const StatistikChartPlaceholder(),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STATISTIK UTAMA',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                          color: const Color(0xFF93C5FD),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        statistics.rataRata.toStringAsFixed(1),
                        style: GoogleFonts.inter(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.05,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Rata-rata Nilai Kelas',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.82),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          StatistikBadge(trendPercent: statistics.trendPercent),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Text(
                              'Total ${statistics.totalSiswa} Siswa',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 88),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _horizontalPadding(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w > 600) return 32;
    return 16;
  }
}
