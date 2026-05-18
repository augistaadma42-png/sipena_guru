import 'package:equatable/equatable.dart';
import 'student_assignment_entity.dart';

/// Priority level untuk tugas
enum AssignmentPriority { high, regular }

/// Entity utama untuk laporan tugas
class AssignmentEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String date;
  final AssignmentPriority priority;
  final int unsubmittedCount;
  final List<StudentAssignmentEntity> students;

  const AssignmentEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.priority,
    required this.unsubmittedCount,
    required this.students,
  });

  @override
  List<Object?> get props =>
      [id, title, subtitle, date, priority, unsubmittedCount, students];
}
