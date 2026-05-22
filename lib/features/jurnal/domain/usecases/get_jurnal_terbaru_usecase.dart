import '../entities/jurnal_entity.dart';
import '../repositories/jurnal_repository.dart';

class GetJurnalTerbaruUsecase {
  final JurnalRepository repository;

  GetJurnalTerbaruUsecase(this.repository);

  Future<List<JurnalEntity>> call() async {
    return await repository.getJurnalTerbaru();
  }
}
