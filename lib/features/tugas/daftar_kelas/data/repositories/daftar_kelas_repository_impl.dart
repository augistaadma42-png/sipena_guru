import '../../domain/entities/kelas_diampu_entity.dart';
import '../../domain/repositories/daftar_kelas_repository.dart';
import '../datasources/daftar_kelas_local_datasource.dart';

class DaftarKelasRepositoryImpl implements DaftarKelasRepository {
  final DaftarKelasLocalDatasource localDatasource;

  DaftarKelasRepositoryImpl({required this.localDatasource});

  @override
  Future<List<KelasDiampuEntity>> getDaftarKelas() async {
    try {
      final models = await localDatasource.getDaftarKelas();
      return models;
    } catch (e) {
      throw Exception('Failed to load daftar kelas: $e');
    }
  }
}
