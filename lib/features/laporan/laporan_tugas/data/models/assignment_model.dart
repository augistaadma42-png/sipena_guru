import '../../domain/entities/assignment_entity.dart';
import 'student_assignment_model.dart';

/// Model data layer untuk tugas, mengextend entity
class AssignmentModel extends AssignmentEntity {
  const AssignmentModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.date,
    required super.priority,
    required super.unsubmittedCount,
    required super.students,
  });

  /// Factory dari Map (misal JSON API)
  factory AssignmentModel.fromMap(Map<String, dynamic> map) {
    final priorityStr = map['priority'] as String;
    return AssignmentModel(
      id: map['id'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      date: map['date'] as String,
      priority: priorityStr == 'high'
          ? AssignmentPriority.high
          : AssignmentPriority.regular,
      unsubmittedCount: map['unsubmittedCount'] as int,
      students: (map['students'] as List)
          .map((s) =>
              StudentAssignmentModel.fromMap(s as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'date': date,
      'priority': priority == AssignmentPriority.high ? 'high' : 'regular',
      'unsubmittedCount': unsubmittedCount,
      'students': students
          .map((s) => (s as StudentAssignmentModel).toMap())
          .toList(),
    };
  }
}
