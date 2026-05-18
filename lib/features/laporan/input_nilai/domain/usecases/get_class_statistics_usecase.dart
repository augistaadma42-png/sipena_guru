import '../entities/class_statistics_entity.dart';
import '../repositories/input_nilai_repository.dart';

/// Mengambil agregat statistik kelas (rata-rata, tren, jumlah siswa).
class GetClassStatisticsUsecase {
  final InputNilaiRepository repository;

  const GetClassStatisticsUsecase(this.repository);

  Future<ClassStatisticsEntity> call() => repository.getClassStatistics();
}
