import '../../domain/entities/notifikasi_entity.dart';

class NotifikasiModel extends NotifikasiEntity {
  const NotifikasiModel({
    required super.id,
    required super.judul,
    required super.isi,
    required super.jenis,
    required super.waktu,
    required super.dibaca,
  });

  NotifikasiModel copyWith({bool? dibaca}) {
    return NotifikasiModel(
      id: id,
      judul: judul,
      isi: isi,
      jenis: jenis,
      waktu: waktu,
      dibaca: dibaca ?? this.dibaca,
    );
  }
}
