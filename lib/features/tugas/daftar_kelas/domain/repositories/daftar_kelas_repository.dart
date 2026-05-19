import '../entities/kelas_diampu_entity.dart';

abstract class DaftarKelasRepository {
  Future<List<KelasDiampuEntity>> getDaftarKelas();
}
