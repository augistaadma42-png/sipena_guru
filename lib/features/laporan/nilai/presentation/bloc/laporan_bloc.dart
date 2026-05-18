import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_student_nilai_usecase.dart';
import 'laporan_event.dart';
import 'laporan_state.dart';

/// BLoC untuk mengelola state Laporan Nilai Akhir
class LaporanBloc extends Bloc<LaporanEvent, LaporanState> {
  final GetStudentNilaiUsecase getStudentNilaiUsecase;
  final GetTotalSiswaUsecase getTotalSiswaUsecase;

  static const int _perPage = 5;

  LaporanBloc({
    required this.getStudentNilaiUsecase,
    required this.getTotalSiswaUsecase,
  }) : super(const LaporanInitial()) {
    on<LoadLaporanEvent>(_onLoadLaporan);
    on<ChangePageEvent>(_onChangePage);
    on<ExportPdfEvent>(_onExportPdf);
  }

  /// Handler untuk LoadLaporanEvent
  Future<void> _onLoadLaporan(
    LoadLaporanEvent event,
    Emitter<LaporanState> emit,
  ) async {
    emit(const LaporanLoading());
    try {
      final totalSiswa = await getTotalSiswaUsecase.call();
      final students = await getStudentNilaiUsecase.call(
        const GetStudentNilaiParams(page: 1),
      );

      emit(LaporanLoaded(
        students: students,
        currentPage: 1,
        totalSiswa: totalSiswa,
        perPage: _perPage,
      ));
    } catch (e) {
      emit(LaporanError('Gagal memuat data: ${e.toString()}'));
    }
  }

  /// Handler untuk ChangePageEvent
  Future<void> _onChangePage(
    ChangePageEvent event,
    Emitter<LaporanState> emit,
  ) async {
    final currentState = state;
    if (currentState is! LaporanLoaded) return;

    // Tampilkan loading ringan dengan state sebelumnya
    emit(const LaporanLoading());

    try {
      final students = await getStudentNilaiUsecase.call(
        GetStudentNilaiParams(page: event.page),
      );

      emit(currentState.copyWith(
        students: students,
        currentPage: event.page,
      ));
    } catch (e) {
      emit(LaporanError('Gagal memuat halaman: ${e.toString()}'));
    }
  }

  /// Handler untuk ExportPdfEvent (dummy)
  Future<void> _onExportPdf(
    ExportPdfEvent event,
    Emitter<LaporanState> emit,
  ) async {
    // Dummy: tidak mengubah state, snackbar ditangani di UI
  }
}