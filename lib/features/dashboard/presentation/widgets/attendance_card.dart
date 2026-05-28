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
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            // Atas
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // JAM
                Container(
                  width: 75,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 5,
                  ),
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
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        time,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.labelStyle.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$className • $room',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.cardTitle,
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Mapel : $subject',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.cardSubtitle,
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Icon(
                            getStatusIcon(),
                            size: 14,
                            color: getStatusTextColor(),
                          ),

                          const SizedBox(width: 4),

                          Expanded(
                            child: Text(
                              filledCount != null && totalCount != null
                                  ? '$statusText • $filledCount/$totalCount Siswa'
                                  : statusText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.labelStyle.copyWith(
                                color: getStatusTextColor(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // tombol full bawah
            if (status != AttendanceStatus.locked) ...[
              const SizedBox(height: 14),

              InkWell(
                onTap: onActionTap,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.08),
                    border: Border.all(color: AppColors.primaryBlue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        status == AttendanceStatus.done ? 'Lihat' : 'Absen',
                        style: AppTextStyles.labelStyle.copyWith(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(width: 6),

                      Icon(
                        status == AttendanceStatus.done
                            ? Icons.check_circle
                            : Icons.arrow_forward,
                        size: 16,
                        color: AppColors.primaryBlue,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


