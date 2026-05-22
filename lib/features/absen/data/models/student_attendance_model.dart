import '../../domain/entities/student_attendance_entity.dart';

class StudentAttendanceModel extends StudentAttendanceEntity {
  const StudentAttendanceModel({
    required super.id,
    required super.nisn,
    required super.name,
    required super.initials,
    required super.status,
  });
}
