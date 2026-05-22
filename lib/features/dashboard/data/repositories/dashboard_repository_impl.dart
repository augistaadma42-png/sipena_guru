import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/entities/aktivitas_entity.dart';
import '../../domain/entities/task_summary_entity.dart';
import '../../domain/entities/attendance_overview_entity.dart';
import '../datasources/dashboard_local_datasource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalDatasource localDatasource;

  DashboardRepositoryImpl({required this.localDatasource});

  @override
  Future<List<AktivitasEntity>> getAktivitasTerbaru() async {
    return await localDatasource.getAktivitasTerbaru();
  }

  @override
  Future<List<TaskSummaryEntity>> getTaskSummary() async {
    return await localDatasource.getTaskSummary();
  }

  @override
  Future<List<AttendanceOverviewEntity>> getAttendanceOverview() async {
    return await localDatasource.getAttendanceOverview();
  }
}
