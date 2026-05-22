import '../entities/aktivitas_entity.dart';
import '../repositories/dashboard_repository.dart';

class GetAktivitasTerbaruUsecase {
  final DashboardRepository repository;

  GetAktivitasTerbaruUsecase(this.repository);

  Future<List<AktivitasEntity>> call() async {
    return await repository.getAktivitasTerbaru();
  }
}
