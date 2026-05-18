import '../../domain/entities/assignment_submission_entity.dart';

/// Model data layer untuk submission siswa, extends entity domain
class AssignmentSubmissionModel extends AssignmentSubmissionEntity {
  const AssignmentSubmissionModel({
    required super.id,
    required super.studentName,
    required super.avatar,
    super.submittedAt,
    super.fileName,
    super.score,
    required super.isSubmitted,
  });

  factory AssignmentSubmissionModel.fromJson(Map<String, dynamic> json) {
    return AssignmentSubmissionModel(
      id: json['id'] as String,
      studentName: json['studentName'] as String,
      avatar: json['avatar'] as String,
      submittedAt: json['submittedAt'] as String?,
      fileName: json['fileName'] as String?,
      score: json['score'] as int?,
      isSubmitted: json['isSubmitted'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'studentName': studentName,
        'avatar': avatar,
        'submittedAt': submittedAt,
        'fileName': fileName,
        'score': score,
        'isSubmitted': isSubmitted,
      };
}
