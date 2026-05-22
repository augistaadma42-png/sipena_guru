import '../../domain/entities/pengaturan_profile_entity.dart';

class PengaturanProfileModel extends PengaturanProfileEntity {
  const PengaturanProfileModel({
    required super.nama,
    required super.nip,
    required super.email,
    required super.mapel,
    required super.jabatan,
  });

  factory PengaturanProfileModel.fromJson(Map<String, dynamic> json) {
    return PengaturanProfileModel(
      nama: json['nama'] as String,
      nip: json['nip'] as String,
      email: json['email'] as String,
      mapel: json['mapel'] as String,
      jabatan: json['jabatan'] as String,
    );
  }
}
