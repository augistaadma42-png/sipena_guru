import '../../domain/entities/materi_entity.dart';
import '../../domain/entities/tugas_entity.dart';
import '../../domain/repositories/dashboard_tugas_repository.dart';
import '../datasources/dashboard_tugas_local_datasource.dart';

class DashboardTugasRepositoryImpl implements DashboardTugasRepository {
  final DashboardTugasLocalDatasource localDatasource;

  DashboardTugasRepositoryImpl({required this.localDatasource});

  @override
  Future<List<MateriEntity>> getMateriTerbaru() async {
    final result = await localDatasource.getMateriTerbaru();
    return result; // List<MateriModel> can be assigned to List<MateriEntity> if typed correctly
  }

  @override
  Future<List<TugasEntity>> getDaftarTugas() async {
    final result = await localDatasource.getDaftarTugas();
    return result;
  }
}
