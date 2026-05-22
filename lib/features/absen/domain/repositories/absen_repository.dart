import '../entities/riwayat_absensi_entity.dart';
import '../entities/student_attendance_entity.dart';
import '../entities/leave_request_entity.dart';

abstract class AbsenRepository {
  Future<List<RiwayatAbsensiEntity>> getRiwayatAbsensi(DateTime? date, String? kelas);
  Future<List<StudentAttendanceEntity>> getStudentAttendance(String kelas);
  Future<List<LeaveRequestEntity>> getLeaveRequests();
  Future<void> updateLeaveRequestStatus(String id, String status);
}
