import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String countText;
  final String dateText;
  final Color countColor;
  final VoidCallback? onTap;

  const TaskItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.countText,
    required this.dateText,
    required this.countColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.cardTitle,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.cardSubtitle,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                countText,
                style: AppTextStyles.labelStyle.copyWith(
                  color: countColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dateText,
                style: AppTextStyles.labelStyle.copyWith(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}

class TaskSummarySection extends StatelessWidget {
  final VoidCallback? onCheckNowTap;
  final VoidCallback? onSeeAllTap;
  final Function(String taskName)? onTaskTap;

  const TaskSummarySection({
    Key? key,
    this.onCheckNowTap,
    this.onSeeAllTap,
    this.onTaskTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ringkasan Tugas Siswa',
          style: AppTextStyles.sectionTitle,
        ),
        const SizedBox(height: 16),
        // Tugas Belum Dinilai Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tugas Belum Dinilai',
                    style: AppTextStyles.cardTitle.copyWith(color: AppColors.primaryBlue),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '9',
                    style: AppTextStyles.headerTitle.copyWith(
                      fontSize: 32,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: onCheckNowTap,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryOrange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Periksa Sekarang',
                            style: AppTextStyles.labelStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.lightBlueBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.assignment_late_outlined,
                  color: AppColors.primaryBlue,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // List Tugas
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Siswa Belum Kumpul',
                        style: AppTextStyles.cardTitle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '15 siswa dari 5 tugas',
                        style: AppTextStyles.labelStyle.copyWith(
                          color: AppColors.secondaryOrange,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.lightOrangeBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.person_off_outlined,
                      color: AppColors.secondaryOrange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: AppColors.borderLight, height: 1),
              TaskItem(
                title: 'Tugas Matematika',
                subtitle: 'XI-RPL 1',
                countText: '30/38 Siswa',
                dateText: '30 Apr 2026',
                countColor: AppColors.secondaryOrange,
                onTap: () => onTaskTap?.call('Tugas Matematika'),
              ),
              const Divider(color: AppColors.borderLight, height: 1),
              TaskItem(
                title: 'Latihan Soal',
                subtitle: 'X-RPL 1',
                countText: '25/32 Siswa',
                dateText: '30 Apr 2026',
                countColor: AppColors.secondaryOrange,
                onTap: () => onTaskTap?.call('Latihan Soal'),
              ),
              const Divider(color: AppColors.borderLight, height: 1),
              TaskItem(
                title: 'Kuis Harian',
                subtitle: 'XI-MP 4',
                countText: '12/40 Siswa',
                dateText: '29 Apr 2026',
                countColor: AppColors.secondaryOrange,
                onTap: () => onTaskTap?.call('Kuis Harian'),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: onSeeAllTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    child: Text(
                      'Lihat Semua →',
                      style: AppTextStyles.labelStyle.copyWith(
                        color: AppColors.secondaryOrange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
