import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';
import '../../domain/entities/assignment_submission_entity.dart';
import 'siswa_avatar.dart';
import 'nilai_badge.dart';
import 'file_tugas_widget.dart';
import 'popup_menu_tugas.dart';

/// Tile satu baris siswa dalam list pengumpulan tugas
class SiswaPengumpulanTile extends StatelessWidget {
  final AssignmentSubmissionEntity submission;
  final bool isTaskExpired;
  final VoidCallback? onTap;

  const SiswaPengumpulanTile({
    super.key,
    required this.submission,
    this.isTaskExpired = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              SiswaAvatar(
                studentName: submission.studentName,
              ),
              const SizedBox(width: 12),

              // Info siswa
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      submission.studentName,
                      style: AppTextStyles.cardTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Status submit — 
                    if (submission.isSubmitted && submission.submittedAt != null)
                      Text(
                        submission.isLate
                            ? 'Terlambat: ${submission.submittedAt}'
                            : 'Dikumpulkan: ${submission.submittedAt}',
                        style: AppTextStyles.cardSubtitle.copyWith(
                          color: submission.isLate ? Colors.orange : null,
                          fontWeight: submission.isLate
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      )
                    else
                      Text(
                        isTaskExpired
                            ? 'Tenggat Terlewati'
                            : 'Belum Mengumpulkan',
                        style: AppTextStyles.cardSubtitle.copyWith(
                          color: isTaskExpired
                              ? Colors.red.shade800
                              : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    const SizedBox(height: 4),
                    // File tugas
                    if (submission.fileName != null)
                      FileTugasWidget(fileName: submission.fileName!),
                  ],
                ),
              ),

              // Kanan: nilai + menu
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (submission.score != null)
                    NilaiBadge(score: submission.score!),
                  if (submission.isSubmitted)
                    PopupMenuTugas(
                      onBeriNilai: () {
                        if (onTap != null) {
                          onTap!();
                        } else {
                          _showSnackBar(context, 'Buka form penilaian...');
                        }
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
