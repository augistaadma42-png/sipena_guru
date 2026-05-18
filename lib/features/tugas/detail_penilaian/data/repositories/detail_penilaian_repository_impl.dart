import '../../domain/entities/detail_penilaian_entity.dart';
import '../../domain/repositories/detail_penilaian_repository.dart';
import '../datasources/detail_penilaian_local_datasource.dart';

class DetailPenilaianRepositoryImpl implements DetailPenilaianRepository {
  final DetailPenilaianLocalDatasource _datasource;
  const DetailPenilaianRepositoryImpl(this._datasource);

  @override
  Future<DetailPenilaianEntity> getDetailPenilaian({
    required String siswaId, required String tugasId,
  }) async {
    final model = await _datasource.getDetailPenilaian(
      siswaId: siswaId, tugasId: tugasId,
    );
    return model;
  }

  @override
  Future<void> submitPenilaian({
    required String siswaId, required String tugasId,
    required int score,      required String feedback,
  }) async {
    await _datasource.submitPenilaian(
      siswaId: siswaId, tugasId: tugasId,
      score: score, feedback: feedback,
    );
  }
}