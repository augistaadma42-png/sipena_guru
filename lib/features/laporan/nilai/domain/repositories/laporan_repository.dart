import '../entities/student_nilai_entity.dart';

/// Abstract repository untuk laporan nilai
abstract class LaporanRepository {
  /// Mengambil daftar nilai siswa berdasarkan halaman
  Future<List<StudentNilaiEntity>> getStudentNilai({
    required int page,
    required int perPage,
  });

  /// Mengambil total siswa
  Future<int> getTotalSiswa();
}