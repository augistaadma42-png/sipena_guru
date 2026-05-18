import 'package:equatable/equatable.dart';

/// Semua event yang dapat dikirim ke LaporanTugasBloc
abstract class LaporanTugasEvent extends Equatable {
  const LaporanTugasEvent();

  @override
  List<Object?> get props => [];
}

/// Event untuk memuat laporan tugas awal
class LoadAssignmentReportEvent extends LaporanTugasEvent {
  final String bulan;
  final String kelas;
  final String mataPelajaran;

  const LoadAssignmentReportEvent({
    required this.bulan,
    required this.kelas,
    required this.mataPelajaran,
  });

  @override
  List<Object?> get props => [bulan, kelas, mataPelajaran];
}

/// Event untuk memfilter laporan berdasarkan dropdown
class FilterAssignmentEvent extends LaporanTugasEvent {
  final String? bulan;
  final String? kelas;
  final String? mataPelajaran;

  const FilterAssignmentEvent({
    this.bulan,
    this.kelas,
    this.mataPelajaran,
  });

  @override
  List<Object?> get props => [bulan, kelas, mataPelajaran];
}

/// Event saat tombol unduh rekap ditekan
class DownloadRecapEvent extends LaporanTugasEvent {
  const DownloadRecapEvent();
}

/// Event untuk expand/collapse detail tugas
class ExpandAssignmentEvent extends LaporanTugasEvent {
  final String assignmentId;

  const ExpandAssignmentEvent(this.assignmentId);

  @override
  List<Object?> get props => [assignmentId];
}
