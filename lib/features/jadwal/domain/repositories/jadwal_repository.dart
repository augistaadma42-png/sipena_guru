import '../entities/jadwal_slot_entity.dart';
import '../entities/jam_slot_entity.dart';

abstract class JadwalRepository {
  Future<List<JamSlotEntity>> getJamSlots();
  Future<List<JadwalSlotEntity>> getJadwalPelajaran();
}
