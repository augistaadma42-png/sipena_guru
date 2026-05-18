import '../../domain/entities/student_nilai_entity.dart';

/// Model data layer yang extends entity domain
class StudentNilaiModel extends StudentNilaiEntity {
  const StudentNilaiModel({
    required super.id,
    required super.nama,
    required super.kelas,
    required super.tanggalInput,
  });

  /// Factory dari JSON (siap untuk integrasi API nanti)
  factory StudentNilaiModel.fromJson(Map<String, dynamic> json) {
    return StudentNilaiModel(
      id: json['id'] as String,
      nama: json['nama'] as String,
      kelas: json['kelas'] as String,
      tanggalInput: json['tanggal_input'] as String,
    );
  }

  /// Konversi ke JSON (siap untuk integrasi API nanti)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'kelas': kelas,
      'tanggal_input': tanggalInput,
    };
  }

  /// Konversi ke entity domain
  StudentNilaiEntity toEntity() {
    return StudentNilaiEntity(
      id: id,
      nama: nama,
      kelas: kelas,
      tanggalInput: tanggalInput,
    );
  }
}