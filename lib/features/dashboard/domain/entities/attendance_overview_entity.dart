enum AttendanceOverviewStatus { done, pending, locked }

class AttendanceOverviewEntity {
  final String time;
  final String className;
  final String room;
  final String subject;
  final AttendanceOverviewStatus status;
  final String statusText;
  final int? filledCount;
  final int? totalCount;

  const AttendanceOverviewEntity({
    required this.time,
    required this.className,
    required this.room,
    required this.subject,
    required this.status,
    required this.statusText,
    this.filledCount,
    this.totalCount,
  });
}
