import 'package:equatable/equatable.dart';
import 'assignment_submission_entity.dart';

/// Entity utama rekap tugas per judul tugas
class AssignmentRecapEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final int totalStudents;
  final int submittedCount;
  final int pendingCount;
  final double completionPercentage;
  final int lateStudentsCount;
  final List<AssignmentSubmissionEntity> submissions;
  final bool isExpired;

  const AssignmentRecapEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.totalStudents,
    required this.submittedCount,
    required this.pendingCount,
    required this.completionPercentage,
    required this.lateStudentsCount,
    required this.submissions,
    this.isExpired = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        totalStudents,
        submittedCount,
        pendingCount,
        completionPercentage,
        lateStudentsCount,
        submissions,
        isExpired,
      ];
}
