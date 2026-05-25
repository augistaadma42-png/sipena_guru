import '../../domain/entities/tugas.dart';

class TugasModel extends Tugas {
  const TugasModel({
    required super.id,
    required super.judul,
    required super.deskripsi,
    required super.kelas,
    required super.jenisNilai,
    required super.mapel,
    required super.siswa,
    super.tenggat,
    required super.createdAt,
  });

  factory TugasModel.fromJson(Map<String, dynamic> json) {
    return TugasModel(
      id: json['id'] as String,
      judul: json['judul'] as String,
      deskripsi: json['deskripsi'] as String,
      kelas: json['kelas'] as String,
      jenisNilai: json['jenisNilai'] as String,
      mapel: json['mapel'] as String,
      siswa: json['siswa'] as String,
      tenggat: json['tenggat'] != null
          ? DateTime.parse(json['tenggat'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'deskripsi': deskripsi,
      'kelas': kelas,
      'jenisNilai': jenisNilai,
      'mapel': mapel,
      'siswa': siswa,
      'tenggat': tenggat?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TugasModel.fromEntity(Tugas tugas) {
    return TugasModel(
      id: tugas.id,
      judul: tugas.judul,
      deskripsi: tugas.deskripsi,
      kelas: tugas.kelas,
      jenisNilai: tugas.jenisNilai,
      mapel: tugas.mapel,
      siswa: tugas.siswa,
      tenggat: tugas.tenggat,
      createdAt: tugas.createdAt,
    );
  }
}
