class LeaveRequestEntity {
  final String id;
  final String studentName;
  final String initials;
  final String nisn;
  final String className;
  final String type; // 'Sakit' or 'Izin' or 'Dispen'
  final DateTime date;
  final String duration;
  final String reason;
  final bool suratAda;
  final String status; // 'pending', 'approved', 'rejected'

  const LeaveRequestEntity({
    required this.id,
    required this.studentName,
    required this.initials,
    required this.nisn,
    required this.className,
    required this.type,
    required this.date,
    required this.duration,
    required this.reason,
    required this.suratAda,
    required this.status,
  });
}
