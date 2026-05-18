import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_class_statistics_usecase.dart';
import '../../domain/usecases/get_student_ranking_usecase.dart';
import 'input_nilai_event.dart';
import 'input_nilai_state.dart';

class InputNilaiBloc extends Bloc<InputNilaiEvent, InputNilaiState> {
  final GetClassStatisticsUsecase getClassStatisticsUsecase;
  final GetStudentRankingUsecase getStudentRankingUsecase;

  InputNilaiBloc({
    required this.getClassStatisticsUsecase,
    required this.getStudentRankingUsecase,
  }) : super(const InputNilaiInitial()) {
    on<LoadRankingEvent>(_onLoadRanking);
    on<ToggleShowAllEvent>(_onToggleShowAll);
    on<ExportPdfEvent>(_onExportPdf);
  }

  Future<void> _onLoadRanking(
    LoadRankingEvent event,
    Emitter<InputNilaiState> emit,
  ) async {
    emit(const InputNilaiLoading());
    try {
      final stats = await getClassStatisticsUsecase.call();
      final rankings = await getStudentRankingUsecase.call(
        const GetStudentRankingParams(showAll: false),
      );
      if (rankings.isEmpty) {
        emit(const InputNilaiEmpty());
        return;
      }
      emit(InputNilaiLoaded(
        statistics: stats,
        rankings: rankings,
        showAll: false,
      ));
    } catch (e) {
      emit(InputNilaiError('Gagal memuat data: ${e.toString()}'));
    }
  }

  Future<void> _onToggleShowAll(
    ToggleShowAllEvent event,
    Emitter<InputNilaiState> emit,
  ) async {
    final current = state;
    if (current is! InputNilaiLoaded) return;

    final nextShowAll = !current.showAll;
    emit(const InputNilaiLoading());
    try {
      final stats = await getClassStatisticsUsecase.call();
      final rankings = await getStudentRankingUsecase.call(
        GetStudentRankingParams(showAll: nextShowAll),
      );
      if (rankings.isEmpty) {
        emit(const InputNilaiEmpty());
        return;
      }
      emit(InputNilaiLoaded(
        statistics: stats,
        rankings: rankings,
        showAll: nextShowAll,
      ));
    } catch (e) {
      emit(InputNilaiError('Gagal memuat daftar: ${e.toString()}'));
    }
  }

  /// Placeholder: ekspor PDF nyata akan diintegrasikan nanti.
  Future<void> _onExportPdf(
    ExportPdfEvent event,
    Emitter<InputNilaiState> emit,
  ) async {}
}
