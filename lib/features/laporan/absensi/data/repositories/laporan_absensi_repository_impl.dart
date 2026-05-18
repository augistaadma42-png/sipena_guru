import '../../domain/entities/student_attendance_entity.dart';
import '../../domain/repositories/laporan_absensi_repository.dart';
import '../datasources/laporan_absensi_local_datasource.dart';

class LaporanAbsensiRepositoryImpl implements LaporanAbsensiRepository {
  final LaporanAbsensiLocalDatasource localDatasource;

  const LaporanAbsensiRepositoryImpl({required this.localDatasource});

  @override
  Future<List<StudentAttendanceEntity>> getStudentAttendance({
    required String monthKey,
    required int page,
    required int perPage,
  }) async {
    return localDatasource.getStudentAttendance(
      monthKey: monthKey,
      page: page,
      perPage: perPage,
    );
  }

  @override
  Future<int> getTotalStudents({required String monthKey}) {
    return localDatasource.getTotalStudents(monthKey: monthKey);
  }
}