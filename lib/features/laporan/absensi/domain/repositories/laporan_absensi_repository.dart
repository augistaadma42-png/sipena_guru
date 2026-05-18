import '../entities/student_attendance_entity.dart';

/// Kontrak repository domain untuk laporan absensi.
abstract class LaporanAbsensiRepository {
  Future<List<StudentAttendanceEntity>> getStudentAttendance({
    required String monthKey,
    required int page,
    required int perPage,
  });

  Future<int> getTotalStudents({required String monthKey});
}