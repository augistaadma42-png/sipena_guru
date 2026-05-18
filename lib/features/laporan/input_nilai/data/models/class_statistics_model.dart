import '../../domain/entities/class_statistics_entity.dart';

class ClassStatisticsModel {
  final double rataRata;
  final double trendPercent;
  final int totalSiswa;

  const ClassStatisticsModel({
    required this.rataRata,
    required this.trendPercent,
    required this.totalSiswa,
  });

  ClassStatisticsEntity toEntity() => ClassStatisticsEntity(
        rataRata: rataRata,
        trendPercent: trendPercent,
        totalSiswa: totalSiswa,
      );
}
