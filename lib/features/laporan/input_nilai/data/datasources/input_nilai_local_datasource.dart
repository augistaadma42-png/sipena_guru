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
      nama: 'Ananda Aryani',
      nis: '0057282',
      nilai: 98.2,
      ranking: 1,
    ),
    StudentRankingModel(
      id: '2',
      nama: 'Ahmad Fauzan',
      nis: '0057281',
      nilai: 95.5,
      ranking: 2,
    ),
    StudentRankingModel(
      id: '3',
      nama: 'Candra Aditama',
      nis: '0057285',
      nilai: 92.8,
      ranking: 3,
    ),
  ];

  static const List<StudentRankingModel> _extended = [
    StudentRankingModel(
      id: '4',
      nama: 'Bunga Pertiwi',
      nis: '0057284',
      nilai: 91.0,
      ranking: 4,
    ),
    StudentRankingModel(
      id: '5',
      nama: 'Bagus Akbar',
      nis: '0057283',
      nilai: 89.4,
      ranking: 5,
    ),
    StudentRankingModel(
      id: '6',
      nama: 'Daffa Rizaldi',
      nis: '0057291',
      nilai: 88.1,
      ranking: 6,
    ),
    StudentRankingModel(
      id: '7',
      nama: 'Eka Putri Sari',
      nis: '0057292',
      nilai: 86.5,
      ranking: 7,
    ),
    StudentRankingModel(
      id: '8',
      nama: 'Gita Maharani',
      nis: '0057294',
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
      totalSiswa: 30,
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
