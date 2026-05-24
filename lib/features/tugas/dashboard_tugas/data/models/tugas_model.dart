import '../../domain/entities/tugas_entity.dart';

class TugasModel extends TugasEntity {
  const TugasModel({
    required super.id,
    required super.kelas,
    required super.title,
    required super.subtitle,
    required super.deadline,
    required super.totalAnggota,
    super.submittedCount = 0,
    super.gradedCount = 0,
    required super.createdAt,
    required super.sisaHari,
    required super.isUrgent,
    super.isGraded,
    super.jenisNilai,
    super.mapel,
    super.siswa,
    super.lampiranCount,
    super.judulMateri,
    super.lampiranNames,
  });

  factory TugasModel.fromJson(Map<String, dynamic> json) {
    return TugasModel(
      id: json['id'] as String,
      kelas: json['kelas'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      deadline: json['deadline'] as String,
      totalAnggota: json['totalAnggota'] as int,
      submittedCount: json['submittedCount'] as int? ?? 0,
      gradedCount: json['gradedCount'] as int? ?? 0,
      createdAt: json['createdAt'] as String? ?? '',
      sisaHari: json['sisaHari'] as String,
      isUrgent: json['isUrgent'] as bool,
      isGraded: json['isGraded'] as bool? ?? false,
      jenisNilai: json['jenisNilai'] as String? ?? 'Tugas',
      mapel: json['mapel'] as String? ?? '',
      siswa: json['siswa'] as String? ?? 'Semua pelajar',
      lampiranCount: json['lampiranCount'] as int? ?? 0,
      judulMateri: json['judulMateri'] as String?,
      lampiranNames: List<String>.from(
        (json['lampiranNames'] as List<dynamic>?) ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kelas': kelas,
      'title': title,
      'subtitle': subtitle,
      'deadline': deadline,
      'totalAnggota': totalAnggota,
      'sisaHari': sisaHari,
      'isUrgent': isUrgent,
      'jenisNilai': jenisNilai,
      'mapel': mapel,
      'siswa': siswa,
      'submittedCount': submittedCount,
      'gradedCount': gradedCount,
      'createdAt': createdAt,
      'isGraded': isGraded,
      'lampiranCount': lampiranCount,
      'judulMateri': judulMateri,
      'lampiranNames': lampiranNames,
    };
  }
}
