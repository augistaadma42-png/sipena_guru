import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../domain/entities/assignment_entity.dart';
import 'tugas_priority_badge.dart';
import 'tugas_student_tile.dart';
import 'lihat_lainnya_button.dart';
import 'selesai_info_card.dart';

/// Konstanta: jumlah siswa yang ditampilkan sebelum "Lihat Lainnya"
const int _kVisibleStudents = 3;

/// Card utama satu tugas — menampilkan semua detail tugas
class TugasCard extends StatefulWidget {
  final AssignmentEntity assignment;
  final bool isExpanded;

  const TugasCard({
    super.key,
    required this.assignment,
    this.isExpanded = false,
  });

  @override
  State<TugasCard> createState() => _TugasCardState();
}

class _TugasCardState extends State<TugasCard> {
  late bool _showAll;

  @override
  void initState() {
    super.initState();
    _showAll = widget.isExpanded;
  }

  @override
  void didUpdateWidget(TugasCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      _showAll = widget.isExpanded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final students = widget.assignment.students;
    final hiddenCount = students.length - _kVisibleStudents;
    final visibleStudents =
        _showAll ? students : students.take(_kVisibleStudents).toList();

    // Estimasi siswa selesai (total 32 - belum kumpul)
    final submittedCount = 32 - widget.assignment.unsubmittedCount;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header: priority + tanggal ──
            Row(
              children: [
                TugasPriorityBadge(priority: widget.assignment.priority),
                const Spacer(),
                Text(
                  widget.assignment.date,
                  style: AppTextStyles.cardSubtitle,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Judul Tugas ──
            Text(
              widget.assignment.title,
              style: AppTextStyles.headerTitle.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 4),

            // ── Subtitle ──
            Text(
              widget.assignment.subtitle,
              style: AppTextStyles.cardSubtitle,
            ),
            const SizedBox(height: 16),

            // ── Divider tipis ──
            const Divider(color: AppColors.borderLight, height: 1),
            const SizedBox(height: 14),

            // ── Header "Belum Mengumpulkan" ──
            Row(
              children: [
                Text(
                  'Belum Mengumpulkan',
                  style: AppTextStyles.sectionTitle.copyWith(fontSize: 13),
                ),
                const SizedBox(width: 8),
                _UnsubmittedBadge(
                    count: widget.assignment.unsubmittedCount),
              ],
            ),
            const SizedBox(height: 10),

            // ── List siswa yang belum mengumpulkan ──
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: visibleStudents.length,
              separatorBuilder: (context, index) => const SizedBox(height: 6),
              itemBuilder: (context, index) =>
                  TugasStudentTile(student: visibleStudents[index]),
            ),

            // ── Lihat Lainnya ──
            if (!_showAll && hiddenCount > 0) ...[
              const SizedBox(height: 4),
              LihatLainnyaButton(
                count: hiddenCount,
                onTap: () => setState(() => _showAll = true),
              ),
            ],

            // ── Info siswa selesai (hanya untuk REGULAR) ──
            if (widget.assignment.priority == AssignmentPriority.regular) ...[
              const SizedBox(height: 12),
              SelesaiInfoCard(count: submittedCount),
            ],
          ],
        ),
      ),
    );
  }
}

/// Badge merah kecil dengan jumlah siswa belum kumpul
class _UnsubmittedBadge extends StatelessWidget {
  final int count;

  const _UnsubmittedBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE4E4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$count Siswa',
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xFFDC2626),
        ),
      ),
    );
  }
}
