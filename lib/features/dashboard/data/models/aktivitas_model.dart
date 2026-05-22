import '../../domain/entities/aktivitas_entity.dart';

class AktivitasModel extends AktivitasEntity {
  const AktivitasModel({
    required super.tanggal,
    required super.jam,
    required super.deskripsi,
    required super.jenis,
    required super.icon,
  });
}
