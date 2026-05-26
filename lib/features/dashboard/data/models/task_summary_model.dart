import '../../domain/entities/task_summary_entity.dart';

class TaskSummaryModel extends TaskSummaryEntity {
  const TaskSummaryModel({
    required super.title,
    required super.subtitle,
    required super.countText,
    required super.dateText,
    required super.kelas,
    required super.mataPelajaran,
  });
}
