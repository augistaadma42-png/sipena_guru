import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_assignment_report_usecase.dart';
import 'laporan_tugas_event.dart';
import 'laporan_tugas_state.dart';

/// BLoC utama untuk fitur Laporan Tugas
class LaporanTugasBloc extends Bloc<LaporanTugasEvent, LaporanTugasState> {
  final GetAssignmentReportUsecase getAssignmentReportUsecase;

  // Filter defaults
  static const String defaultBulan = 'Oktober 2023';
  static const String defaultKelas = 'XII IPA 1';
  static const String defaultMapel = 'Matematika Wajib';

  LaporanTugasBloc({required this.getAssignmentReportUsecase})
      : super(const LaporanTugasInitial()) {
    on<LoadAssignmentReportEvent>(_onLoad);
    on<FilterAssignmentEvent>(_onFilter);
    on<DownloadRecapEvent>(_onDownload);
    on<ExpandAssignmentEvent>(_onExpand);
  }

  /// Handler: muat laporan awal
  Future<void> _onLoad(
    LoadAssignmentReportEvent event,
    Emitter<LaporanTugasState> emit,
  ) async {
    emit(const LaporanTugasLoading());
    try {
      final result = await getAssignmentReportUsecase(
        bulan: event.bulan,
        kelas: event.kelas,
        mataPelajaran: event.mataPelajaran,
      );

      if (result.isEmpty) {
        emit(const LaporanTugasEmpty());
      } else {
        emit(LaporanTugasLoaded(
          assignments: result,
          selectedBulan: event.bulan,
          selectedKelas: event.kelas,
          selectedMataPelajaran: event.mataPelajaran,
        ));
      }
    } catch (e) {
      emit(LaporanTugasError(e.toString()));
    }
  }

  /// Handler: filter berubah, reload data
  Future<void> _onFilter(
    FilterAssignmentEvent event,
    Emitter<LaporanTugasState> emit,
  ) async {
    final current = state;
    final bulan = event.bulan ??
        (current is LaporanTugasLoaded ? current.selectedBulan : defaultBulan);
    final kelas = event.kelas ??
        (current is LaporanTugasLoaded ? current.selectedKelas : defaultKelas);
    final mapel = event.mataPelajaran ??
        (current is LaporanTugasLoaded
            ? current.selectedMataPelajaran
            : defaultMapel);

    emit(const LaporanTugasLoading());
    try {
      final result = await getAssignmentReportUsecase(
        bulan: bulan,
        kelas: kelas,
        mataPelajaran: mapel,
      );

      if (result.isEmpty) {
        emit(const LaporanTugasEmpty());
      } else {
        emit(LaporanTugasLoaded(
          assignments: result,
          selectedBulan: bulan,
          selectedKelas: kelas,
          selectedMataPelajaran: mapel,
        ));
      }
    } catch (e) {
      emit(LaporanTugasError(e.toString()));
    }
  }

  /// Handler: unduh rekap — hanya emit state notifikasi (snackbar di UI)
  void _onDownload(
    DownloadRecapEvent event,
    Emitter<LaporanTugasState> emit,
  ) {
    // State tetap loaded, UI menampilkan snackbar
    // No state change needed
  }

  /// Handler: toggle expand/collapse tugas card
  void _onExpand(
    ExpandAssignmentEvent event,
    Emitter<LaporanTugasState> emit,
  ) {
    final current = state;
    if (current is! LaporanTugasLoaded) return;

    final newExpanded = Set<String>.from(current.expandedIds);
    if (newExpanded.contains(event.assignmentId)) {
      newExpanded.remove(event.assignmentId);
    } else {
      newExpanded.add(event.assignmentId);
    }

    emit(current.copyWith(expandedIds: newExpanded));
  }
}
