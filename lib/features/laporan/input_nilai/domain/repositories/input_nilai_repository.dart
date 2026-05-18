import '../entities/class_statistics_entity.dart';
import '../entities/student_ranking_entity.dart';

abstract class InputNilaiRepository {
  Future<ClassStatisticsEntity> getClassStatistics();

  Future<List<StudentRankingEntity>> getStudentRankings({required bool showAll});
}
