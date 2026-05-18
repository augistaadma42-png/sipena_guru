import '../../domain/entities/tugas_entity.dart';

class TugasModel extends TugasEntity {
  const TugasModel({
    required super.id,
    required super.kelas,
    required super.title,
    required super.subtitle,
    required super.deadline,
    required super.totalAnggota,
    required super.sisaHari,
    required super.isUrgent,
  });

  factory TugasModel.fromJson(Map<String, dynamic> json) {
    return TugasModel(
      id: json['id'] as String,
      kelas: json['kelas'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      deadline: json['deadline'] as String,
      totalAnggota: json['totalAnggota'] as int,
      sisaHari: json['sisaHari'] as String,
      isUrgent: json['isUrgent'] as bool,
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
    };
  }
}
