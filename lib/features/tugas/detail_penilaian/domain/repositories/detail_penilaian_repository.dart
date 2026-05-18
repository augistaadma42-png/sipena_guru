import '../entities/detail_penilaian_entity.dart';

/// Kontrak repository — domain tidak tahu implementasinya.
abstract class DetailPenilaianRepository {
  Future<DetailPenilaianEntity> getDetailPenilaian({
    required String siswaId,
    required String tugasId,
  });

  Future<void> submitPenilaian({
    required String siswaId,
    required String tugasId,
    required int score,
    required String feedback,
  });
}