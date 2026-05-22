import '../../data/models/jurnal_model.dart';
import '../repositories/jurnal_repository.dart';

class SimpanJurnalUsecase {
  final JurnalRepository repository;

  SimpanJurnalUsecase(this.repository);

  Future<void> call(JurnalModel jurnal) async {
    return await repository.simpanJurnal(jurnal);
  }
}
