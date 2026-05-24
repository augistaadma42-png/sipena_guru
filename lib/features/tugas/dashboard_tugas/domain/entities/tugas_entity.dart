import 'package:equatable/equatable.dart';

class TugasEntity extends Equatable {
  final String id;
  final String kelas;
  final String title;
  final String subtitle;
  final String deadline;
  final int totalAnggota;
  final int submittedCount;
  final int gradedCount; // jumlah siswa yang sudah dinilai
  final String createdAt;
  final String sisaHari;
  final bool isUrgent;
  final bool isGraded;

  // Field tambahan — sinkron dengan form buat tugas
  final String jenisNilai; // 'Tugas' | 'Materi'
  final String mapel; // mata pelajaran
  final String siswa; // 'Semua pelajar' | 'Kelompok A' | dst
  final int lampiranCount; // jumlah lampiran yang dilampirkan
  final String? judulMateri; // diisi hanya jika jenisNilai == 'Materi'
  final List<String> lampiranNames; // nama-nama lampiran

  const TugasEntity({
    required this.id,
    required this.kelas,
    required this.title,
    required this.subtitle,
    required this.deadline,
    required this.totalAnggota,
    this.submittedCount = 0,
    this.gradedCount = 0,
    required this.createdAt,
    required this.sisaHari,
    required this.isUrgent,
    this.isGraded = false,
    this.jenisNilai = 'Tugas',
    this.mapel = '',
    this.siswa = 'Semua pelajar',
    this.lampiranCount = 0,
    this.judulMateri,
    this.lampiranNames = const [],
  });

  @override
  List<Object?> get props => [
    id,
    kelas,
    title,
    subtitle,
    deadline,
    totalAnggota,
    submittedCount,
    gradedCount,
    createdAt,
    sisaHari,
    isUrgent,
    isGraded,
    jenisNilai,
    mapel,
    siswa,
    lampiranCount,
    judulMateri,
    lampiranNames,
  ];
}
