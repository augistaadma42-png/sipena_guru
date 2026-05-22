import '../entities/jurnal_entity.dart';
import '../../data/models/jurnal_model.dart';

abstract class JurnalRepository {
  Future<List<JurnalEntity>> getJurnalTerbaru();
  Future<List<JurnalEntity>> getRekapJurnal(String? filterKelas, DateTime? filterTanggal);
  Future<void> simpanJurnal(JurnalModel jurnal);
}
