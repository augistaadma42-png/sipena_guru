import '../entities/tugas_entity.dart';
import '../repositories/dashboard_tugas_repository.dart';

class GetDaftarTugasUsecase {
  final DashboardTugasRepository repository;

  GetDaftarTugasUsecase(this.repository);

  Future<List<TugasEntity>> call() async {
    return await repository.getDaftarTugas();
  }
}
