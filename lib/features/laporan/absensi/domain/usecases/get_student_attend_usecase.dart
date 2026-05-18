import '../entities/student_attendance_entity.dart';
import '../repositories/laporan_absensi_repository.dart';

class GetStudentAttendanceParams {
  final String monthKey;
  final int page;
  final int perPage;

  const GetStudentAttendanceParams({
    required this.monthKey,
    required this.page,
    required this.perPage,
  });
}

class GetTotalStudentsParams {
  final String monthKey;

  const GetTotalStudentsParams({required this.monthKey});
}

/// Usecase untuk mengambil data absensi siswa per bulan.
class GetStudentAttendanceUsecase {
  final LaporanAbsensiRepository repository;

  const GetStudentAttendanceUsecase(this.repository);

  Future<List<StudentAttendanceEntity>> call(GetStudentAttendanceParams params) {
    return repository.getStudentAttendance(
      monthKey: params.monthKey,
      page: params.page,
      perPage: params.perPage,
    );
  }
}

/// Usecase untuk mengambil total siswa.
class GetTotalStudentsUsecase {
  final LaporanAbsensiRepository repository;

  const GetTotalStudentsUsecase(this.repository);

  Future<int> call(GetTotalStudentsParams params) {
    return repository.getTotalStudents(monthKey: params.monthKey);
  }
}