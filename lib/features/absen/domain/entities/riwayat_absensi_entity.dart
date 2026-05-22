class RiwayatAbsensiEntity {
  final String id;
  final DateTime tanggal;
  final String hari;
  final String kelas;
  final String mapel;
  final String jamMulai;
  final String jamSelesai;
  final String jamKe;
  final int jumlahHadir;
  final int totalSiswa;
  final bool lengkap;

  const RiwayatAbsensiEntity({
    required this.id,
    required this.tanggal,
    required this.hari,
    required this.kelas,
    required this.mapel,
    required this.jamMulai,
    required this.jamSelesai,
    required this.jamKe,
    required this.jumlahHadir,
    required this.totalSiswa,
    required this.lengkap,
  });
}
