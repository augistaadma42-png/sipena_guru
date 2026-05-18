import '../../domain/entities/student_assignment_entity.dart';

/// Model data layer untuk siswa, mengextend entity
class StudentAssignmentModel extends StudentAssignmentEntity {
  const StudentAssignmentModel({
    required super.id,
    required super.nama,
    required super.initials,
    required super.submitted,
  });

  /// Factory dari Map (misal JSON API)
  factory StudentAssignmentModel.fromMap(Map<String, dynamic> map) {
    return StudentAssignmentModel(
      id: map['id'] as String,
      nama: map['nama'] as String,
      initials: map['initials'] as String,
      submitted: map['submitted'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'initials': initials,
      'submitted': submitted,
    };
  }
}
