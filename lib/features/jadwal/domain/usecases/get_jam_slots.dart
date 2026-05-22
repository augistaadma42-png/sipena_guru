import '../entities/jam_slot_entity.dart';
import '../repositories/jadwal_repository.dart';

class GetJamSlotsUsecase {
  final JadwalRepository repository;

  GetJamSlotsUsecase(this.repository);

  Future<List<JamSlotEntity>> call() async {
    return await repository.getJamSlots();
  }
}
