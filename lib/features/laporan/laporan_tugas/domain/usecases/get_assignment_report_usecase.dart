import '../entities/assignment_entity.dart';
import '../repositories/laporan_tugas_repository.dart';

/// Use case untuk mengambil laporan tugas
class GetAssignmentReportUsecase {
  final LaporanTugasRepository repository;

  const GetAssignmentReportUsecase(this.repository);

  /// Eksekusi use case dengan parameter filter
  Future<List<AssignmentEntity>> call({
    required String bulan,
    required String kelas,
    required String mataPelajaran,
  }) {
    return repository.getAssignmentReport(
      bulan: bulan,
      kelas: kelas,
      mataPelajaran: mataPelajaran,
    );
  }
}
