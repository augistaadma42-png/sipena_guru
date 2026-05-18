import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';
import 'progress_pengumpulan_bar.dart';

/// Card statistik pengumpulan tugas (2 kartu berdampingan)
class StatistikPengumpulanCard extends StatelessWidget {
  final int totalStudents;
  final int submittedCount;
  final int pendingCount;
  final double completionPercentage;
  final int lateStudentsCount;

  const StatistikPengumpulanCard({
    super.key,
    required this.totalStudents,
    required this.submittedCount,
    required this.pendingCount,
    required this.completionPercentage,
    required this.lateStudentsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Row(
        children: [
          // Card 1: Diserahkan
          Expanded(
            child: _StatCard(
              title: 'Diserahkan',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$submittedCount',
                          style: AppTextStyles.headerTitle.copyWith(
                            fontSize: 28,
                          ),
                        ),
                        TextSpan(
                          text: ' / $totalStudents',
                          style: AppTextStyles.headerSubtitle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Siswa',
                    style: AppTextStyles.labelStyle,
                  ),
                  const SizedBox(height: 12),
                  ProgressPengumpulanBar(
                    percentage: completionPercentage / 100,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Card 2: Ditugaskan / Menunggu
          Expanded(
            child: _StatCard(
              title: 'Ditugaskan',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${pendingCount.toString().padLeft(2, '0')}',
                    style: AppTextStyles.headerTitle.copyWith(fontSize: 28),
                  ),
                  Text(
                    'Menunggu Pengumpulan',
                    style: AppTextStyles.labelStyle,
                  ),
                  const SizedBox(height: 12),
                  // Warning terlambat
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.red,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Tenggat terlewati untuk $lateStudentsCount siswa',
                            style: AppTextStyles.labelStyle.copyWith(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Card container reusable untuk statistik
class _StatCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _StatCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.labelStyle.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
