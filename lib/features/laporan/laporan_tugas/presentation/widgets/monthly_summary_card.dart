import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/colors.dart';
import 'progress_bar_widget.dart';
import 'summary_stat_item.dart';
import 'unduh_rekap_button.dart';

/// Card navy besar — ringkasan bulanan dengan progress & statistik
class MonthlySummaryCard extends StatelessWidget {
  final int totalTugas;
  final int belumSelesai;
  final double completionPercentage; // 0.0 - 1.0
  final VoidCallback? onUnduhRekap;

  const MonthlySummaryCard({
    super.key,
    required this.totalTugas,
    required this.belumSelesai,
    required this.completionPercentage,
    this.onUnduhRekap,
  });

  @override
  Widget build(BuildContext context) {
    final percentLabel =
        '${(completionPercentage * 100).round()}%';

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B3C73), Color(0xFF0F2451)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Label orange "RINGKASAN BULAN INI" ──
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.secondaryOrange.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'RINGKASAN BULAN INI',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.secondaryOrange,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // ── Title persentase ──
          Text(
            '$percentLabel Penyelesaian Tugas Keseluruhan',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 16),

          // ── Progress bar ──
          ProgressBarWidget(
            percentage: completionPercentage,
            height: 8,
          ),
          const SizedBox(height: 20),

          // ── Footer: stats kiri + tombol kanan ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Total tugas
              SummaryStatItem(
                value: totalTugas.toString().padLeft(2, '0'),
                label: 'TOTAL TUGAS',
              ),
              const SizedBox(width: 24),
              // Belum selesai
              SummaryStatItem(
                value: belumSelesai.toString().padLeft(2, '0'),
                label: 'BELUM SELESAI',
              ),
              const Spacer(),
              // Tombol unduh rekap
              UnduhRekapButton(onTap: onUnduhRekap),
            ],
          ),
        ],
      ),
    );
  }
}
