import '../repositories/detail_penilaian_repository.dart';

class SubmitPenilaianUsecase {
  final DetailPenilaianRepository _repository;
  const SubmitPenilaianUsecase(this._repository);

  Future<void> call({
    required String siswaId,
    required String tugasId,
    required int score,
    required String feedback,
  }) => _repository.submitPenilaian(
        siswaId: siswaId, tugasId: tugasId,
        score: score, feedback: feedback,
      );
}