import '../../domain/entities/student_nilai_entity.dart';
import '../../domain/repositories/laporan_repository.dart';
import '../datasources/laporan_local_datasource.dart';

/// Implementasi repository menggunakan datasource lokal
class LaporanRepositoryImpl implements LaporanRepository {
  final LaporanLocalDatasource localDatasource;

  const LaporanRepositoryImpl({required this.localDatasource});

  @override
  Future<List<StudentNilaiEntity>> getStudentNilai({
    required int page,
    required int perPage,
  }) async {
    final models = await localDatasource.getStudentNilai(
      page: page,
      perPage: perPage,
    );
    // Konversi model ke entity
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<int> getTotalSiswa() async {
    return localDatasource.getTotalSiswa();
  }
}