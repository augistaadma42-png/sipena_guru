import 'package:equatable/equatable.dart';
import '../../domain/entities/student_nilai_entity.dart';

/// Base class untuk semua state laporan
abstract class LaporanState extends Equatable {
  const LaporanState();

  @override
  List<Object?> get props => [];
}

/// State awal sebelum data dimuat
class LaporanInitial extends LaporanState {
  const LaporanInitial();
}

/// State saat data sedang dimuat
class LaporanLoading extends LaporanState {
  const LaporanLoading();
}

/// State saat data berhasil dimuat
class LaporanLoaded extends LaporanState {
  final List<StudentNilaiEntity> students;
  final int currentPage;
  final int totalSiswa;
  final int perPage;
  final String namaKelas;
  final String namaMapel;

  const LaporanLoaded({
    required this.students,
    required this.currentPage,
    required this.totalSiswa,
    this.perPage = 5,
    this.namaKelas = 'XII MIPA 4',
    this.namaMapel = 'Matematika Peminatan',
  });

  /// Total halaman berdasarkan total siswa
  int get totalPages => (totalSiswa / perPage).ceil();

  /// Apakah data kosong
  bool get isEmpty => students.isEmpty;

  @override
  List<Object?> get props =>
      [students, currentPage, totalSiswa, perPage, namaKelas, namaMapel];

  LaporanLoaded copyWith({
    List<StudentNilaiEntity>? students,
    int? currentPage,
    int? totalSiswa,
    int? perPage,
    String? namaKelas,
    String? namaMapel,
  }) {
    return LaporanLoaded(
      students: students ?? this.students,
      currentPage: currentPage ?? this.currentPage,
      totalSiswa: totalSiswa ?? this.totalSiswa,
      perPage: perPage ?? this.perPage,
      namaKelas: namaKelas ?? this.namaKelas,
      namaMapel: namaMapel ?? this.namaMapel,
    );
  }
}

/// State saat terjadi error
class LaporanError extends LaporanState {
  final String message;

  const LaporanError(this.message);

  @override
  List<Object?> get props => [message];
}