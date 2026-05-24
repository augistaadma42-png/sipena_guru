import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/assignment_submission_entity.dart';
import '../../domain/usecases/get_assignment_recap_usecase.dart';
import 'rekap_pengumpulan_event.dart';
import 'rekap_pengumpulan_state.dart';

class RekapPengumpulanBloc
    extends Bloc<RekapPengumpulanEvent, RekapPengumpulanState> {
  final GetAssignmentRecapUsecase getAssignmentRecap;

  RekapPengumpulanBloc({required this.getAssignmentRecap})
    : super(RekapPengumpulanInitial()) {
    on<LoadRekapPengumpulanEvent>(_onLoad);
    on<FilterSubmissionEvent>(_onFilter);
    on<SearchStudentEvent>(_onSearch);
    on<DownloadAllEvent>(_onDownloadAll);
  }

  Future<void> _onLoad(
    LoadRekapPengumpulanEvent event,
    Emitter<RekapPengumpulanState> emit,
  ) async {
    emit(RekapPengumpulanLoading());
    try {
      final recap = await getAssignmentRecap(event.tugasId);

      if (recap.submissions.isEmpty) {
        emit(RekapPengumpulanEmpty());
        return;
      }

      // Default tampilkan siswa yang mengumpulkan tepat waktu
      final filtered = _applyFilter(
        recap.submissions,
        selectedFilter: RekapSubmissionFilter.submitted,
        query: '',
      );

      emit(
        RekapPengumpulanLoaded(
          recap: recap,
          filteredSubmissions: filtered,
          selectedFilter: RekapSubmissionFilter.submitted,
        ),
      );
    } catch (e) {
      emit(RekapPengumpulanError(e.toString()));
    }
  }

  void _onFilter(
    FilterSubmissionEvent event,
    Emitter<RekapPengumpulanState> emit,
  ) {
    final current = state;
    if (current is! RekapPengumpulanLoaded) return;

    final filtered = _applyFilter(
      current.recap.submissions,
      selectedFilter: event.selectedFilter,
      query: current.searchQuery,
    );

    emit(
      current.copyWith(
        filteredSubmissions: filtered,
        selectedFilter: event.selectedFilter,
      ),
    );
  }

  void _onSearch(
    SearchStudentEvent event,
    Emitter<RekapPengumpulanState> emit,
  ) {
    final current = state;
    if (current is! RekapPengumpulanLoaded) return;

    final filtered = _applyFilter(
      current.recap.submissions,
      selectedFilter: current.selectedFilter,
      query: event.query,
    );

    emit(
      current.copyWith(filteredSubmissions: filtered, searchQuery: event.query),
    );
  }

  Future<void> _onDownloadAll(
    DownloadAllEvent event,
    Emitter<RekapPengumpulanState> emit,
  ) async {
    debugPrint('[RekapBloc] Download all triggered');
    // Simulasi download — nanti diganti dengan aksi real
  }

  /// Helper: terapkan filter tab + search sekaligus
  List<AssignmentSubmissionEntity> _applyFilter(
    List<AssignmentSubmissionEntity> all, {
    required RekapSubmissionFilter selectedFilter,
    required String query,
  }) {
    return all.where((s) {
      late final bool matchTab;

      switch (selectedFilter) {
        case RekapSubmissionFilter.submitted:
          matchTab = s.isSubmitted && !s.isLate;
          break;
        case RekapSubmissionFilter.late:
          matchTab = s.isSubmitted && s.isLate;
          break;
        case RekapSubmissionFilter.pending:
          matchTab = !s.isSubmitted;
          break;
      }

      final matchQuery =
          query.isEmpty ||
          s.studentName.toLowerCase().contains(query.toLowerCase());
      return matchTab && matchQuery;
    }).toList();
  }
}
