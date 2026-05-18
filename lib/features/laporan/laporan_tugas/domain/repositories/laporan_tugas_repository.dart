import '../entities/assignment_entity.dart';

/// Kontrak repository untuk laporan tugas
abstract class LaporanTugasRepository {
  /// Ambil daftar laporan tugas berdasarkan filter
  Future<List<AssignmentEntity>> getAssignmentReport({
    required String bulan,
    required String kelas,
    required String mataPelajaran,
  });
}
