import 'package:equatable/equatable.dart';

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

/// Event untuk filter tab (Diserahkan / Ditugaskan)
class FilterSubmissionEvent extends RekapPengumpulanEvent {
  final bool showSubmitted; // true = diserahkan, false = ditugaskan
  const FilterSubmissionEvent(this.showSubmitted);

  @override
  List<Object?> get props => [showSubmitted];
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
