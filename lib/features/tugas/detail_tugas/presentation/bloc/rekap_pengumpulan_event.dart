import 'package:equatable/equatable.dart';

/// Tipe filter tab pada rekap pengumpulan tugas
enum RekapSubmissionFilter { submitted, late, pending }

abstract class RekapPengumpulanEvent extends Equatable {
  const RekapPengumpulanEvent();

  @override
  List<Object?> get props => [];
}

/// Event untuk memuat data rekap berdasarkan ID tugas
class LoadRekapPengumpulanEvent extends RekapPengumpulanEvent {
  final String tugasId;
  const LoadRekapPengumpulanEvent(this.tugasId);

  @override
  List<Object?> get props => [tugasId];
}

/// Event untuk filter tab (Diserahkan / Terlambat / Ditugaskan)
class FilterSubmissionEvent extends RekapPengumpulanEvent {
  final RekapSubmissionFilter selectedFilter;
  const FilterSubmissionEvent(this.selectedFilter);

  @override
  List<Object?> get props => [selectedFilter];
}

/// Event untuk pencarian siswa
class SearchStudentEvent extends RekapPengumpulanEvent {
  final String query;
  const SearchStudentEvent(this.query);

  @override
  List<Object?> get props => [query];
}

/// Event untuk trigger download semua
class DownloadAllEvent extends RekapPengumpulanEvent {}
