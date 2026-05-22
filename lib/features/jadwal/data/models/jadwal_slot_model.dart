import '../../domain/entities/jadwal_slot_entity.dart';

class JadwalSlotModel extends JadwalSlotEntity {
  const JadwalSlotModel({
    required super.hari,
    required super.jamKe,
    required super.mapel,
    required super.kelas,
    required super.ruang,
  });

  factory JadwalSlotModel.fromJson(Map<String, dynamic> json) {
    return JadwalSlotModel(
      hari: json['hari'] as String,
      jamKe: json['jamKe'] as int,
      mapel: json['mapel'] as String,
      kelas: json['kelas'] as String,
      ruang: json['ruang'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hari': hari,
      'jamKe': jamKe,
      'mapel': mapel,
      'kelas': kelas,
      'ruang': ruang,
    };
  }
}
