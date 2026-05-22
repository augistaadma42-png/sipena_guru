import '../entities/task_summary_entity.dart';
import '../repositories/dashboard_repository.dart';

class GetTaskSummaryUsecase {
  final DashboardRepository repository;

  GetTaskSummaryUsecase(this.repository);

  Future<List<TaskSummaryEntity>> call() async {
    return await repository.getTaskSummary();
  }
}
