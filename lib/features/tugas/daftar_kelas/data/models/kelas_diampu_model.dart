import '../../domain/entities/kelas_diampu_entity.dart';

class KelasDiampuModel extends KelasDiampuEntity {
  const KelasDiampuModel({
    required super.id,
    required super.namaKelas,
    required super.namaMapel,
  });

  factory KelasDiampuModel.fromJson(Map<String, dynamic> json) {
    return KelasDiampuModel(
      id: json['id'],
      namaKelas: json['nama_kelas'],
      namaMapel: json['nama_mapel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_kelas': namaKelas,
      'nama_mapel': namaMapel,
    };
  }
}
