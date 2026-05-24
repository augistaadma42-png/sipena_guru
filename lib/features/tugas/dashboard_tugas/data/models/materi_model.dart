import '../../domain/entities/materi_entity.dart';

class MateriModel extends MateriEntity {
  const MateriModel({
    required super.id,
    required super.title,
    required super.category,
    required super.totalMateri,
    required super.tanggal,
    super.kelas,
    super.lampiranCount,
    super.deskripsi,
    super.lampiranNames,
  });

  factory MateriModel.fromJson(Map<String, dynamic> json) {
    return MateriModel(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      totalMateri: json['totalMateri'] as int,
      tanggal: json['tanggal'] as String,
      kelas: json['kelas'] as String? ?? '',
      lampiranCount: json['lampiranCount'] as int? ?? 0,
      deskripsi: json['deskripsi'] as String? ?? '',
      lampiranNames: List<String>.from(
        (json['lampiranNames'] as List<dynamic>?) ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'totalMateri': totalMateri,
      'tanggal': tanggal,
      'kelas': kelas,
      'lampiranCount': lampiranCount,
      'deskripsi': deskripsi,
      'lampiranNames': lampiranNames,
    };
  }
}
