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

      // Default tampilkan siswa yang sudah mengumpulkan
      final filtered = recap.submissions
          .where((s) => s.isSubmitted)
          .toList();

      emit(RekapPengumpulanLoaded(
        recap: recap,
        filteredSubmissions: filtered,
        showSubmitted: true,
      ));
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
      showSubmitted: event.showSubmitted,
      query: current.searchQuery,
    );

    emit(current.copyWith(
      filteredSubmissions: filtered,
      showSubmitted: event.showSubmitted,
    ));
  }

  void _onSearch(
    SearchStudentEvent event,
    Emitter<RekapPengumpulanState> emit,
  ) {
    final current = state;
    if (current is! RekapPengumpulanLoaded) return;

    final filtered = _applyFilter(
      current.recap.submissions,
      showSubmitted: current.showSubmitted,
      query: event.query,
    );

    emit(current.copyWith(
      filteredSubmissions: filtered,
      searchQuery: event.query,
    ));
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
    required bool showSubmitted,
    required String query,
  }) {
    return all.where((s) {
      final matchTab = s.isSubmitted == showSubmitted;
      final matchQuery = query.isEmpty ||
          s.studentName.toLowerCase().contains(query.toLowerCase());
      return matchTab && matchQuery;
    }).toList();
  }
}
