import '../../domain/entities/assignment_recap_entity.dart';
import 'assignment_submission_model.dart';

/// Model data layer untuk rekap tugas, extends entity domain
class AssignmentRecapModel extends AssignmentRecapEntity {
  const AssignmentRecapModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.totalStudents,
    required super.submittedCount,
    required super.pendingCount,
    required super.completionPercentage,
    required super.lateStudentsCount,
    required super.submissions,
  });

  factory AssignmentRecapModel.fromJson(Map<String, dynamic> json) {
    final submissionList = (json['submissions'] as List<dynamic>)
        .map((e) =>
            AssignmentSubmissionModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return AssignmentRecapModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      totalStudents: json['totalStudents'] as int,
      submittedCount: json['submittedCount'] as int,
      pendingCount: json['pendingCount'] as int,
      completionPercentage: (json['completionPercentage'] as num).toDouble(),
      lateStudentsCount: json['lateStudentsCount'] as int,
      submissions: submissionList,
    );
  }
}
