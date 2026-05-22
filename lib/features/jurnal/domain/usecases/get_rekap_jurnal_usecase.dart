import '../entities/jurnal_entity.dart';
import '../repositories/jurnal_repository.dart';

class GetRekapJurnalUsecase {
  final JurnalRepository repository;

  GetRekapJurnalUsecase(this.repository);

  Future<List<JurnalEntity>> call(String? filterKelas, DateTime? filterTanggal) async {
    return await repository.getRekapJurnal(filterKelas, filterTanggal);
  }
}
