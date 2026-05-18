import '../../domain/entities/student_ranking_entity.dart';

class StudentRankingModel {
  final String id;
  final String nama;
  final String nis;
  final double nilai;
  final int ranking;

  const StudentRankingModel({
    required this.id,
    required this.nama,
    required this.nis,
    required this.nilai,
    required this.ranking,
  });

  StudentRankingEntity toEntity() => StudentRankingEntity(
        id: id,
        nama: nama,
        nis: nis,
        nilai: nilai,
        ranking: ranking,
      );
}
