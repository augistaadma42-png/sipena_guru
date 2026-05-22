import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import '../../domain/usecases/get_aktivitas_terbaru_usecase.dart';
import '../../domain/usecases/get_task_summary_usecase.dart';
import '../../domain/usecases/get_attendance_overview_usecase.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetAktivitasTerbaruUsecase getAktivitasTerbaruUsecase;
  final GetTaskSummaryUsecase getTaskSummaryUsecase;
  final GetAttendanceOverviewUsecase getAttendanceOverviewUsecase;

  DashboardBloc({
    required this.getAktivitasTerbaruUsecase,
    required this.getTaskSummaryUsecase,
    required this.getAttendanceOverviewUsecase,
  }) : super(DashboardInitial()) {
    on<LoadDashboardDataEvent>((event, emit) async {
      emit(DashboardLoading());
      try {
        final aktivitas = await getAktivitasTerbaruUsecase();
        final taskSummary = await getTaskSummaryUsecase();
        final attendanceOverview = await getAttendanceOverviewUsecase();

        emit(DashboardLoaded(
          aktivitasList: aktivitas,
          taskSummaryList: taskSummary,
          attendanceOverviewList: attendanceOverview,
        ));
      } catch (e) {
        emit(DashboardError(message: e.toString()));
      }
    });
  }
}
