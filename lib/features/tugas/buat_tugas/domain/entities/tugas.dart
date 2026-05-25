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
  final DateTime createdAt;
  // [CHANGE 4] Field materi terkait dari dropdown filter
  final String materiTerkait;

  const Tugas({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.kelas,
    required this.jenisNilai,
    required this.mapel,
    required this.siswa,
    this.tenggat,
    required this.createdAt,
    this.materiTerkait = '',
  });
}
