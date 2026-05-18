import '../../domain/entities/assignment_entity.dart';
import '../../domain/repositories/laporan_tugas_repository.dart';
import '../datasources/laporan_tugas_local_datasource.dart';

/// Implementasi konkret dari LaporanTugasRepository
class LaporanTugasRepositoryImpl implements LaporanTugasRepository {
  final LaporanTugasLocalDatasource localDatasource;

  const LaporanTugasRepositoryImpl({required this.localDatasource});

  @override
  Future<List<AssignmentEntity>> getAssignmentReport({
    required String bulan,
    required String kelas,
    required String mataPelajaran,
  }) async {
    // Nantinya bisa diganti dengan remote datasource
    return localDatasource.getAssignmentReport(
      bulan: bulan,
      kelas: kelas,
      mataPelajaran: mataPelajaran,
    );
  }
}
