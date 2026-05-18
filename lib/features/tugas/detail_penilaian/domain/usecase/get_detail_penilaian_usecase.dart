import '../entities/detail_penilaian_entity.dart';
import '../repositories/detail_penilaian_repository.dart';

class GetDetailPenilaianUsecase {
  final DetailPenilaianRepository _repository;
  const GetDetailPenilaianUsecase(this._repository);

  Future<DetailPenilaianEntity> call({
    required String siswaId,
    required String tugasId,
  }) => _repository.getDetailPenilaian(siswaId: siswaId, tugasId: tugasId);
}