import '../../domain/entities/jadwal_slot_entity.dart';
import '../../domain/entities/jam_slot_entity.dart';
import '../../domain/repositories/jadwal_repository.dart';
import '../datasources/jadwal_local_datasource.dart';

class JadwalRepositoryImpl implements JadwalRepository {
  final JadwalLocalDatasource localDatasource;

  JadwalRepositoryImpl({required this.localDatasource});

  @override
  Future<List<JamSlotEntity>> getJamSlots() async {
    return await localDatasource.getJamSlots();
  }

  @override
  Future<List<JadwalSlotEntity>> getJadwalPelajaran() async {
    return await localDatasource.getJadwalPelajaran();
  }
}
