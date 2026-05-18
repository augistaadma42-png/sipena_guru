import '../entities/materi_entity.dart';
import '../entities/tugas_entity.dart';

abstract class DashboardTugasRepository {
  Future<List<MateriEntity>> getMateriTerbaru();
  Future<List<TugasEntity>> getDaftarTugas();
}
