import 'package:equatable/equatable.dart';

/// Base class untuk semua event laporan
abstract class LaporanEvent extends Equatable {
  const LaporanEvent();

  @override
  List<Object?> get props => [];
}

/// Event untuk memuat data laporan pertama kali
class LoadLaporanEvent extends LaporanEvent {
  const LoadLaporanEvent();
}

/// Event untuk berpindah halaman pagination
class ChangePageEvent extends LaporanEvent {
  final int page;

  const ChangePageEvent(this.page);

  @override
  List<Object?> get props => [page];
}

/// Event untuk export PDF (dummy)
class ExportPdfEvent extends LaporanEvent {
  const ExportPdfEvent();
}