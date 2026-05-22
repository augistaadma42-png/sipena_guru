import '../entities/student_attendance_entity.dart';
import '../repositories/absen_repository.dart';

class GetStudentAttendanceUsecase {
  final AbsenRepository repository;

  GetStudentAttendanceUsecase(this.repository);

  Future<List<StudentAttendanceEntity>> call(String kelas) async {
    return await repository.getStudentAttendance(kelas);
  }
}
