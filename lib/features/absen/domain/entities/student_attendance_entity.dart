class StudentAttendanceEntity {
  final String id;
  final String nisn;
  final String name;
  final String initials;
  final String status; // 'hadir', 'sakit', 'izin', 'alpha'

  const StudentAttendanceEntity({
    required this.id,
    required this.nisn,
    required this.name,
    required this.initials,
    required this.status,
  });

  StudentAttendanceEntity copyWith({String? status}) {
    return StudentAttendanceEntity(
      id: id,
      nisn: nisn,
      name: name,
      initials: initials,
      status: status ?? this.status,
    );
  }
}
