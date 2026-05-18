// PURE DART — tanpa import Flutter
class Tugas {
  final String id;
  final String judul;
  final String deskripsi;
  final String kelas;
  final String jenisNilai;
  final String mapel;
  final String siswa;
  final DateTime? tenggat;
  final String topik;
  final DateTime createdAt;

  const Tugas({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.kelas,
    required this.jenisNilai,
    required this.mapel,
    required this.siswa,
    this.tenggat,
    required this.topik,
    required this.createdAt,
  });
}
