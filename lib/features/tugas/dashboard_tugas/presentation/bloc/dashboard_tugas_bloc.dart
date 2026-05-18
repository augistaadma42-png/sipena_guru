import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_daftar_tugas_usecase.dart';
import '../../domain/usecases/get_materi_terbaru_usecase.dart';
import 'dashboard_tugas_event.dart';
import 'dashboard_tugas_state.dart';

class DashboardTugasBloc extends Bloc<DashboardTugasEvent, DashboardTugasState> {
  final GetMateriTerbaruUsecase getMateriTerbaru;
  final GetDaftarTugasUsecase getDaftarTugas;

  DashboardTugasBloc({
    required this.getMateriTerbaru,
    required this.getDaftarTugas,
  }) : super(DashboardTugasInitial()) {
    on<LoadDashboardTugasEvent>(_onLoadDashboard);
    on<RefreshDashboardEvent>(_onRefreshDashboard);
  }

  Future<void> _onLoadDashboard(
    LoadDashboardTugasEvent event,
    Emitter<DashboardTugasState> emit,
  ) async {
    emit(DashboardTugasLoading());
    try {
      final materi = await getMateriTerbaru();
      final tugas = await getDaftarTugas();

      if (materi.isEmpty && tugas.isEmpty) {
        emit(DashboardTugasEmpty());
      } else {
        emit(DashboardTugasLoaded(materiList: materi, tugasList: tugas));
      }
    } catch (e) {
      emit(DashboardTugasError(e.toString()));
    }
  }

  Future<void> _onRefreshDashboard(
    RefreshDashboardEvent event,
    Emitter<DashboardTugasState> emit,
  ) async {
    add(LoadDashboardTugasEvent());
  }
}
