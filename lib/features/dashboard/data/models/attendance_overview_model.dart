import '../../domain/entities/attendance_overview_entity.dart';

class AttendanceOverviewModel extends AttendanceOverviewEntity {
  const AttendanceOverviewModel({
    required super.time,
    required super.className,
    required super.room,
    required super.subject,
    required super.status,
    required super.statusText,
    super.filledCount,
    super.totalCount,
  });
}
