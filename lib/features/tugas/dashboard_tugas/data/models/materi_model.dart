import '../../domain/entities/materi_entity.dart';

class MateriModel extends MateriEntity {
  const MateriModel({
    required super.id,
    required super.title,
    required super.category,
    required super.totalMateri,
    required super.tanggal,
  });

  factory MateriModel.fromJson(Map<String, dynamic> json) {
    return MateriModel(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      totalMateri: json['totalMateri'] as int,
      tanggal: json['tanggal'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'totalMateri': totalMateri,
      'tanggal': tanggal,
    };
  }
}
