import '../entities/attendance_overview_entity.dart';
import '../repositories/dashboard_repository.dart';

class GetAttendanceOverviewUsecase {
  final DashboardRepository repository;

  GetAttendanceOverviewUsecase(this.repository);

  Future<List<AttendanceOverviewEntity>> call() async {
    return await repository.getAttendanceOverview();
  }
}
