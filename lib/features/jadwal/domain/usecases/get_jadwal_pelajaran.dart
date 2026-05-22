import '../entities/jadwal_slot_entity.dart';
import '../repositories/jadwal_repository.dart';

class GetJadwalPelajaranUsecase {
  final JadwalRepository repository;

  GetJadwalPelajaranUsecase(this.repository);

  Future<List<JadwalSlotEntity>> call() async {
    return await repository.getJadwalPelajaran();
  }
}
