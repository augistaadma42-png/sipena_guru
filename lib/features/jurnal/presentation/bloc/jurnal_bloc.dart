import 'package:flutter_bloc/flutter_bloc.dart';
import 'jurnal_event.dart';
import 'jurnal_state.dart';
import '../../domain/usecases/get_jurnal_terbaru_usecase.dart';
import '../../domain/usecases/get_rekap_jurnal_usecase.dart';

class JurnalBloc extends Bloc<JurnalEvent, JurnalState> {
  final GetJurnalTerbaruUsecase getJurnalTerbaruUsecase;
  final GetRekapJurnalUsecase getRekapJurnalUsecase;

  JurnalBloc({
    required this.getJurnalTerbaruUsecase,
    required this.getRekapJurnalUsecase,
  }) : super(JurnalInitial()) {
    on<LoadJurnalTerbaruEvent>((event, emit) async {
      emit(JurnalLoading());
      try {
        final data = await getJurnalTerbaruUsecase();
        emit(JurnalTerbaruLoaded(jurnalList: data));
      } catch (e) {
        emit(JurnalError(message: e.toString()));
      }
    });

    on<LoadRekapJurnalEvent>((event, emit) async {
      emit(JurnalLoading());
      try {
        final data = await getRekapJurnalUsecase(event.filterKelas, event.filterTanggal);
        emit(RekapJurnalLoaded(rekapList: data));
      } catch (e) {
        emit(JurnalError(message: e.toString()));
      }
    });
  }
}
