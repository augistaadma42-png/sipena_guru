import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

enum AttendanceStatus { done, pending, locked }

class AttendanceCard extends StatelessWidget {
  final String time;
  final String className;
  final String room;
  final String subject;
  final AttendanceStatus status;
  final String statusText;
  final int? filledCount;
  final int? totalCount;
  final VoidCallback? onActionTap;

  const AttendanceCard({
    Key? key,
    required this.time,
    required this.className,
    required this.room,
    required this.subject,
    required this.status,
    required this.statusText,
    this.filledCount,
    this.totalCount,
    this.onActionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getLeftBorderColor() {
      switch (status) {
        case AttendanceStatus.done:
          return AppColors.primaryBlue;
        case AttendanceStatus.pending:
          return AppColors.secondaryOrange;
        case AttendanceStatus.locked:
          return Colors.transparent;
      }
    }

    Color getTimeBgColor() {
      switch (status) {
        case AttendanceStatus.done:
          return AppColors.primaryBlue;
        case AttendanceStatus.pending:
          return AppColors.secondaryOrange;
        case AttendanceStatus.locked:
          return AppColors.disabledGrey;
      }
    }

    Color getStatusTextColor() {
      switch (status) {
        case AttendanceStatus.done:
          return AppColors.successGreen;
        case AttendanceStatus.pending:
          return AppColors.warningOrange;
        case AttendanceStatus.locked:
          return AppColors.textSecondary;
      }
    }

    IconData getStatusIcon() {
      switch (status) {
        case AttendanceStatus.done:
          return Icons.check_circle_outline;
        case AttendanceStatus.pending:
          return Icons.access_time;
        case AttendanceStatus.locked:
          return Icons.lock_outline;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left border indicator removed (dipindahkan ke scrollbar)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Time Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: getTimeBgColor(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'JAM',
                            style: AppTextStyles.labelStyle.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            time,
                            style: AppTextStyles.labelStyle.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  '$className • $room',
                                  style: AppTextStyles.cardTitle,
                                ),
                              ),
                              if (status != AttendanceStatus.locked)
                                InkWell(
                                  onTap: onActionTap,
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.primaryBlue),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          status == AttendanceStatus.done ? 'Lihat' : 'Absen',
                                          style: AppTextStyles.labelStyle.copyWith(
                                            color: AppColors.primaryBlue,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          status == AttendanceStatus.done ? Icons.check_circle : Icons.arrow_forward,
                                          size: 14,
                                          color: AppColors.primaryBlue,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Mapel : $subject',
                            style: AppTextStyles.cardSubtitle,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                getStatusIcon(),
                                size: 16,
                                color: getStatusTextColor(),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                statusText,
                                style: AppTextStyles.labelStyle.copyWith(
                                  color: getStatusTextColor(),
                                ),
                              ),
                              if (filledCount != null && totalCount != null) ...[
                                const SizedBox(width: 4),
                                Text(
                                  '• $filledCount/$totalCount Siswa',
                                  style: AppTextStyles.labelStyle.copyWith(
                                    color: getStatusTextColor(),
                                  ),
                                ),
                              ],
                            ],
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
      ),
    );
  }
}
