import '../entities/student_ranking_entity.dart';
import '../repositories/input_nilai_repository.dart';

class GetStudentRankingParams {
  final bool showAll;

  const GetStudentRankingParams({this.showAll = false});
}

class GetStudentRankingUsecase {
  final InputNilaiRepository repository;

  const GetStudentRankingUsecase(this.repository);

  Future<List<StudentRankingEntity>> call(GetStudentRankingParams params) {
    return repository.getStudentRankings(showAll: params.showAll);
  }
}
