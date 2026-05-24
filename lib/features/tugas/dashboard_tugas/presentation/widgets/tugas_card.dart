import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';
import '../../domain/entities/tugas_entity.dart';
import '../../../detail_tugas/presentation/pages/rekap_pengumpulan_tugas_page.dart';
import '../../../buat_tugas/presentation/pages/buat_tugas_page.dart';

class TugasCard extends StatelessWidget {
  final TugasEntity tugas;

  const TugasCard({super.key, required this.tugas});

  @override
  Widget build(BuildContext context) {
    final isMateri = tugas.jenisNilai == 'Materi';
    final isExpired = _isTaskExpired(tugas.deadline);
    final statusLabel = isExpired ? 'Kadaluarsa' : 'Aktif';
    final statusColor = isExpired ? Colors.red.shade600 : Colors.green.shade700;
    
    // Calculate grading status
    final isFullyGraded = tugas.gradedCount == tugas.totalAnggota;
    final isPartiallyGraded = tugas.gradedCount > 0 && tugas.gradedCount < tugas.totalAnggota;
    
    final gradingStatusLabel = isFullyGraded 
        ? 'Sudah dinilai: ${tugas.gradedCount}/${tugas.totalAnggota} '
        : isPartiallyGraded
            ? 'Sudah dinilai: ${tugas.gradedCount}/${tugas.totalAnggota}'
            : 'Belum dinilai';
    
    final gradingStatusColor = isFullyGraded
        ? Colors.green.shade700
        : isPartiallyGraded
            ? Colors.orange.shade700
            : Colors.red.shade600;

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RekapPengumpulanTugasPage(
            tugasId: tugas.id,
            tugasTitle: tugas.title,
            tugasSubtitle: tugas.subtitle,
            lampiranCount: tugas.lampiranCount,
            lampiranNames: tugas.lampiranNames,
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: tugas.isUrgent
                ? const Color.fromARGB(250, 237, 78, 9).withOpacity(0.25)
                : AppColors.borderLight,
          ),
          boxShadow: [
            BoxShadow(
              color: tugas.isUrgent
                  ? Colors.red.withOpacity(0.06)
                  : Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Baris 1: badge status + badge kelas + badge grading + deadline + menu
                  Row(
                    children: [
                      // Badge status tugas (Aktif / Kadaluarsa)
                      _Badge(
                        label: statusLabel,
                        bgColor: statusColor.withOpacity(0.1),
                        textColor: statusColor,
                      ),
                      // [CHANGE 2] Badge kelas dihapus
                      const Spacer(),
                      // Sisa hari
                      _DeadlinePill(
                        sisaHari: tugas.sisaHari,
                        isUrgent: tugas.isUrgent,
                      ),
                      const SizedBox(width: 4),
                      _PopupMenu(tugas: tugas),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // [CHANGE 5] Info materi tampil di atas judul untuk semua tugas yang punya materi terkait
                  if (tugas.judulMateri != null &&
                      tugas.judulMateri!.isNotEmpty) ...[
                    Row(
                      children: [
                        const Icon(
                          Icons.menu_book_rounded,
                          size: 13,
                          color: AppColors.secondaryOrange,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Materi: ${tugas.judulMateri!}',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryOrange,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],

                  // ── Judul Tugas
                  Text(
                    tugas.title,
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Dibuat: ${_formatToDDMMYY(tugas.createdAt)}',
                    style: AppTextStyles.labelStyle.copyWith(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ── Deskripsi / petunjuk
                  if (tugas.subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      tugas.subtitle,
                      style: AppTextStyles.cardSubtitle.copyWith(
                        fontSize: 13,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  const SizedBox(height: 12),

                  // ── Info row: mapel + siswa
                  Wrap(
                    spacing: 12,
                    runSpacing: 4,
                    children: [
                      if (tugas.mapel.isNotEmpty)
                        _InfoChip(
                          icon: Icons.subject_rounded,
                          label: tugas.mapel,
                        ),
                      _InfoChip(
                        icon: Icons.people_outline_rounded,
                        label: tugas.siswa,
                      ),
                    ],
                  ),

                  // ── Lampiran row (hanya jika ada)
                  if (tugas.lampiranCount > 0) ...[
                    const SizedBox(height: 8),
                    _LampiranRow(count: tugas.lampiranCount),
                  ],

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1, color: AppColors.borderLight),
                  ),

                  // ── Footer: progress pengumpulan siswa + deadline tanggal ─────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.people_alt_rounded,
                            size: 13,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${tugas.submittedCount}/${tugas.totalAnggota} siswa',
                            style: AppTextStyles.labelStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 13,
                            color: tugas.isUrgent
                                ? Colors.red.shade400
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Deadline: ${_formatToDDMMYY(tugas.deadline)}',
                            style: AppTextStyles.labelStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: tugas.isUrgent
                                  ? Colors.red.shade400
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // ── Grading status (di bawah progress siswa) ──
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        isFullyGraded
                            ? Icons.check_circle_outline_rounded
                            : isPartiallyGraded
                                ? Icons.rate_review_outlined
                                : Icons.unpublished_outlined,
                        size: 13,
                        color: gradingStatusColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        gradingStatusLabel,
                        style: AppTextStyles.labelStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: gradingStatusColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatToDDMMYY(String input) {
    try {
      final trimmed = input.trim();
      if (trimmed.isEmpty) return '';

      // Try patterns like '25 Okt' or '25 Okt 2026'
      final parts = trimmed.split(RegExp(r'\s+'));
      final monthMap = {
        'jan': 1,
        'feb': 2,
        'mar': 3,
        'apr': 4,
        'mei': 5,
        'jun': 6,
        'jul': 7,
        'agu': 8,
        'agt': 8,
        'sep': 9,
        'okt': 10,
        'nov': 11,
        'des': 12,
      };

      int day = 1;
      int month = DateTime.now().month;
      int year = DateTime.now().year;

      // If starts with a number -> day present
      final firstNum = int.tryParse(parts[0]);
      if (firstNum != null) {
        day = firstNum;
        if (parts.length >= 2) {
          final key = parts[1].toLowerCase().replaceAll('.', '');
          month = monthMap[key] ?? month;
        }
        if (parts.length >= 3) {
          final y = int.tryParse(parts[2]);
          if (y != null) year = y;
        }
      } else {
        // e.g. 'Okt 2026' or 'Okt'
        final key = parts[0].toLowerCase().replaceAll('.', '');
        month = monthMap[key] ?? month;
        if (parts.length >= 2) {
          final y = int.tryParse(parts[1]);
          if (y != null) year = y;
        }
      }

      final two = (int n) => n.toString().padLeft(2, '0');
      final yy = (year % 100).toString().padLeft(2, '0');
      return '${two(day)}/${two(month)}/$yy';
    } catch (_) {
      return input;
    }
  }
}

// ── Sub-widgets ──────────────────────────────────────────────────────────────

class _Badge extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;

  const _Badge({
    required this.label,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: textColor,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

bool _isTaskExpired(String deadlineStr) {
  final deadline = _parseDeadline(deadlineStr);
  if (deadline == null) return false;
  final deadlineEndOfDay = DateTime(
    deadline.year,
    deadline.month,
    deadline.day,
    23,
    59,
    59,
  );
  return DateTime.now().isAfter(deadlineEndOfDay);
}

DateTime? _parseDeadline(String deadlineStr) {
  final parts = deadlineStr.trim().split(' ');
  if (parts.length < 2) return null;

  final day = int.tryParse(parts[0]);
  if (day == null) return null;

  final monthMap = {
    'jan': 1,
    'feb': 2,
    'mar': 3,
    'apr': 4,
    'mei': 5,
    'jun': 6,
    'jul': 7,
    'agu': 8,
    'agt': 8,
    'sep': 9,
    'okt': 10,
    'nov': 11,
    'des': 12,
  };

  final monthKey = parts[1].toLowerCase().replaceAll('.', '');
  final month = monthMap[monthKey];
  if (month == null) return null;

  final now = DateTime.now();
  return DateTime(now.year, month, day);
}

class _DeadlinePill extends StatelessWidget {
  final String sisaHari;
  final bool isUrgent;

  const _DeadlinePill({required this.sisaHari, required this.isUrgent});

  @override
  Widget build(BuildContext context) {
    final color = isUrgent ? Colors.red.shade400 : AppColors.textSecondary;
    final bg = isUrgent
        ? Colors.red.withOpacity(0.08)
        : AppColors.backgroundLight;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUrgent
              ? Colors.red.withOpacity(0.25)
              : AppColors.borderLight,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time_rounded, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            sisaHari,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _LampiranRow extends StatelessWidget {
  final int count;

  const _LampiranRow({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.attach_file_rounded,
            size: 13,
            color: AppColors.primaryBlue,
          ),
          const SizedBox(width: 5),
          Text(
            '$count lampiran',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}

class _PopupMenu extends StatelessWidget {
  final TugasEntity tugas;

  const _PopupMenu({required this.tugas});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert,
        size: 20,
        color: AppColors.textSecondary,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) {
        if (value == 'edit') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BuatTugasPage(tugasToEdit: tugas),
            ),
          );
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 16, color: AppColors.primaryBlue),
              const SizedBox(width: 10),
              const Text('Edit Tugas'),
            ],
          ),
        ),
      ],
    );
  }
}
