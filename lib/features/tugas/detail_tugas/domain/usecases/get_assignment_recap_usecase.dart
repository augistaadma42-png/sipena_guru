import '../entities/assignment_recap_entity.dart';
import '../repositories/rekap_pengumpulan_repository.dart';

/// Usecase untuk mengambil data rekap pengumpulan tugas berdasarkan ID
class GetAssignmentRecapUsecase {
  final RekapPengumpulanRepository repository;

  GetAssignmentRecapUsecase(this.repository);

  Future<AssignmentRecapEntity> call(String tugasId) async {
    return await repository.getAssignmentRecap(tugasId);
  }
}
