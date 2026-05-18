import '../entities/materi_entity.dart';
import '../repositories/dashboard_tugas_repository.dart';

class GetMateriTerbaruUsecase {
  final DashboardTugasRepository repository;

  GetMateriTerbaruUsecase(this.repository);

  Future<List<MateriEntity>> call() async {
    return await repository.getMateriTerbaru();
  }
}
