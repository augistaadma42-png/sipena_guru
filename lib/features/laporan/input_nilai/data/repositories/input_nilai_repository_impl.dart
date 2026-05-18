import '../../domain/entities/class_statistics_entity.dart';
import '../../domain/entities/student_ranking_entity.dart';
import '../../domain/repositories/input_nilai_repository.dart';
import '../datasources/input_nilai_local_datasource.dart';

class InputNilaiRepositoryImpl implements InputNilaiRepository {
  final InputNilaiLocalDatasource localDatasource;

  const InputNilaiRepositoryImpl({required this.localDatasource});

  @override
  Future<ClassStatisticsEntity> getClassStatistics() async {
    final model = await localDatasource.getClassStatistics();
    return model.toEntity();
  }

  @override
  Future<List<StudentRankingEntity>> getStudentRankings({
    required bool showAll,
  }) async {
    final models = await localDatasource.getStudentRankings(showAll: showAll);
    return models.map((m) => m.toEntity()).toList();
  }
}
