import 'package:flutter/material.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../domain/entities/student_assignment_entity.dart';
import 'student_avatar_badge.dart';

/// Tile satu baris siswa yang belum mengumpulkan
class TugasStudentTile extends StatelessWidget {
  final StudentAssignmentEntity student;

  const TugasStudentTile({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Avatar inisial siswa
          StudentAvatarBadge(initials: student.initials),
          const SizedBox(width: 12),
          // Nama siswa
          Expanded(
            child: Text(
              student.nama,
              style: AppTextStyles.cardTitle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Icon warning belum kumpul
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEEEE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.remove_circle_outline_rounded,
              color: Color(0xFFDC2626),
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
