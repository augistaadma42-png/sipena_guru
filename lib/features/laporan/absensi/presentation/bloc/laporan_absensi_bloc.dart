import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_student_attend_usecase.dart';
import 'laporan_absensi_event.dart';
import 'laporan_absensi_state.dart';

class LaporanAbsensiBloc extends Bloc<LaporanAbsensiEvent, LaporanAbsensiState> {
  final GetStudentAttendanceUsecase getStudentAttendanceUsecase;
  final GetTotalStudentsUsecase getTotalStudentsUsecase;

  static const int _perPage = 5;

  LaporanAbsensiBloc({
    required this.getStudentAttendanceUsecase,
    required this.getTotalStudentsUsecase,
  }) : super(const LaporanAbsensiInitial()) {
    on<LoadAttendanceEvent>(_onLoadAttendance);
    on<ChangeMonthEvent>(_onChangeMonth);
    on<ExportPdfEvent>(_onExportPdf);
  }

  Future<void> _onLoadAttendance(
    LoadAttendanceEvent event,
    Emitter<LaporanAbsensiState> emit,
  ) async {
    emit(const LaporanAbsensiLoading());

    const monthKey = '2023-10';
    const monthLabel = 'Oktober 2023';

    await _fetchAttendance(
      emit: emit,
      monthKey: monthKey,
      monthLabel: monthLabel,
    );
  }

  Future<void> _onChangeMonth(
    ChangeMonthEvent event,
    Emitter<LaporanAbsensiState> emit,
  ) async {
    emit(const LaporanAbsensiLoading());

    await _fetchAttendance(
      emit: emit,
      monthKey: event.monthKey,
      monthLabel: event.monthLabel,
    );
  }

  Future<void> _fetchAttendance({
    required Emitter<LaporanAbsensiState> emit,
    required String monthKey,
    required String monthLabel,
  }) async {
    try {
      final totalStudents = await getTotalStudentsUsecase(
        GetTotalStudentsParams(monthKey: monthKey),
      );

      final students = await getStudentAttendanceUsecase(
        GetStudentAttendanceParams(
          monthKey: monthKey,
          page: 1,
          perPage: _perPage,
        ),
      );

      if (students.isEmpty || totalStudents == 0) {
        emit(LaporanAbsensiEmpty(monthLabel: monthLabel));
        return;
      }

      emit(
        LaporanAbsensiLoaded(
          students: students,
          currentPage: 1,
          totalStudents: totalStudents,
          perPage: _perPage,
          monthKey: monthKey,
          monthLabel: monthLabel,
          classLabel: 'Kelas XII - IPA 1',
          homeroomTeacher: 'Bp. Raharjo',
        ),
      );
    } catch (e) {
      emit(LaporanAbsensiError('Gagal memuat data absensi: ${e.toString()}'));
    }
  }

  Future<void> _onExportPdf(
    ExportPdfEvent event,
    Emitter<LaporanAbsensiState> emit,
  ) async {
    // Dummy event: efek UI ditangani di page via snackbar.
  }
}