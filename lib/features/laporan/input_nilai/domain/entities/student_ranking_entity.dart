import 'package:equatable/equatable.dart';

/// Entity peringkat siswa untuk halaman Input Nilai.
class StudentRankingEntity extends Equatable {
  final String id;
  final String nama;
  final String nis;
  final double nilai;
  final int ranking;

  const StudentRankingEntity({
    required this.id,
    required this.nama,
    required this.nis,
    required this.nilai,
    required this.ranking,
  });

  @override
  List<Object?> get props => [id, nama, nis, nilai, ranking];
}
