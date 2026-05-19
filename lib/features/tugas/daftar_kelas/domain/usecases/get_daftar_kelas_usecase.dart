import '../entities/kelas_diampu_entity.dart';
import '../repositories/daftar_kelas_repository.dart';

class GetDaftarKelasUsecase {
  final DaftarKelasRepository repository;

  GetDaftarKelasUsecase(this.repository);

  Future<List<KelasDiampuEntity>> call() async {
    return await repository.getDaftarKelas();
  }
}
