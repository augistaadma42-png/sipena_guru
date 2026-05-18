import '../models/class_statistics_model.dart';
import '../models/student_ranking_model.dart';

/// Sumber data lokal dummy untuk Input Nilai Siswa.
abstract class InputNilaiLocalDatasource {
  Future<ClassStatisticsModel> getClassStatistics();

  Future<List<StudentRankingModel>> getStudentRankings({required bool showAll});
}

class InputNilaiLocalDatasourceImpl implements InputNilaiLocalDatasource {
  static const List<StudentRankingModel> _topThree = [
    StudentRankingModel(
      id: '1',
      nama: 'Ahmad Z.',
      nis: '1029381',
      nilai: 98.2,
      ranking: 1,
    ),
    StudentRankingModel(
      id: '2',
      nama: 'Siti R.',
      nis: '1029382',
      nilai: 95.5,
      ranking: 2,
    ),
    StudentRankingModel(
      id: '3',
      nama: 'Budi S.',
      nis: '1029383',
      nilai: 92.8,
      ranking: 3,
    ),
  ];

  static const List<StudentRankingModel> _extended = [
    StudentRankingModel(
      id: '4',
      nama: 'Dewi L.',
      nis: '1029384',
      nilai: 91.0,
      ranking: 4,
    ),
    StudentRankingModel(
      id: '5',
      nama: 'Eko P.',
      nis: '1029385',
      nilai: 89.4,
      ranking: 5,
    ),
    StudentRankingModel(
      id: '6',
      nama: 'Fitri A.',
      nis: '1029386',
      nilai: 88.1,
      ranking: 6,
    ),
    StudentRankingModel(
      id: '7',
      nama: 'Gita M.',
      nis: '1029387',
      nilai: 86.5,
      ranking: 7,
    ),
    StudentRankingModel(
      id: '8',
      nama: 'Hadi K.',
      nis: '1029388',
      nilai: 85.0,
      ranking: 8,
    ),
  ];

  @override
  Future<ClassStatisticsModel> getClassStatistics() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return const ClassStatisticsModel(
      rataRata: 84.5,
      trendPercent: 2.4,
      totalSiswa: 32,
    );
  }

  @override
  Future<List<StudentRankingModel>> getStudentRankings({
    required bool showAll,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (showAll) {
      return [..._topThree, ..._extended];
    }
    return List<StudentRankingModel>.from(_topThree);
  }
}
