import '../../domain/entities/riwayat_absensi_entity.dart';

class RiwayatAbsensiModel extends RiwayatAbsensiEntity {
  const RiwayatAbsensiModel({
    required super.id,
    required super.tanggal,
    required super.hari,
    required super.kelas,
    required super.mapel,
    required super.jamMulai,
    required super.jamSelesai,
    required super.jamKe,
    required super.jumlahHadir,
    required super.totalSiswa,
    required super.lengkap,
  });
}
