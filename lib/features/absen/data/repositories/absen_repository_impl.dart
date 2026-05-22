import '../../domain/entities/riwayat_absensi_entity.dart';
import '../../domain/entities/student_attendance_entity.dart';
import '../../domain/entities/leave_request_entity.dart';
import '../../domain/repositories/absen_repository.dart';
import '../datasources/absen_local_datasource.dart';

class AbsenRepositoryImpl implements AbsenRepository {
  final AbsenLocalDatasource localDatasource;

  AbsenRepositoryImpl({required this.localDatasource});

  @override
  Future<List<RiwayatAbsensiEntity>> getRiwayatAbsensi(DateTime? date, String? kelas) async {
    return await localDatasource.getRiwayatAbsensi(date, kelas);
  }

  @override
  Future<List<StudentAttendanceEntity>> getStudentAttendance(String kelas) async {
    return await localDatasource.getStudentAttendance(kelas);
  }

  @override
  Future<List<LeaveRequestEntity>> getLeaveRequests() async {
    return await localDatasource.getLeaveRequests();
  }

  @override
  Future<void> updateLeaveRequestStatus(String id, String status) async {
    return await localDatasource.updateLeaveRequestStatus(id, status);
  }
}
