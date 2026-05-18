import 'package:equatable/equatable.dart';

/// Ringkasan statistik kelas untuk kartu STATISTIK UTAMA.
class ClassStatisticsEntity extends Equatable {
  final double rataRata;
  /// Nilai positif menandakan kenaikan (ditampilkan sebagai +x%).
  final double trendPercent;
  final int totalSiswa;

  const ClassStatisticsEntity({
    required this.rataRata,
    required this.trendPercent,
    required this.totalSiswa,
  });

  @override
  List<Object?> get props => [rataRata, trendPercent, totalSiswa];
}
