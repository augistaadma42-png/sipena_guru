import '../entities/aktivitas_entity.dart';
import '../entities/task_summary_entity.dart';
import '../entities/attendance_overview_entity.dart';

abstract class DashboardRepository {
  Future<List<AktivitasEntity>> getAktivitasTerbaru();
  Future<List<TaskSummaryEntity>> getTaskSummary();
  Future<List<AttendanceOverviewEntity>> getAttendanceOverview();
}
