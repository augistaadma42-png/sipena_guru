import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_jadwal_pelajaran.dart';
import '../../domain/usecases/get_jam_slots.dart';
import 'jadwal_event.dart';
import 'jadwal_state.dart';

class JadwalBloc extends Bloc<JadwalEvent, JadwalState> {
  final GetJamSlotsUsecase getJamSlotsUsecase;
  final GetJadwalPelajaranUsecase getJadwalPelajaranUsecase;

  JadwalBloc({
    required this.getJamSlotsUsecase,
    required this.getJadwalPelajaranUsecase,
  }) : super(JadwalInitial()) {
    on<LoadJadwalEvent>(_onLoadJadwal);
  }

  Future<void> _onLoadJadwal(
    LoadJadwalEvent event,
    Emitter<JadwalState> emit,
  ) async {
    emit(JadwalLoading());
    try {
      final slots = await getJamSlotsUsecase();
      final jadwalData = await getJadwalPelajaranUsecase();
      emit(JadwalLoaded(slots: slots, jadwalData: jadwalData));
    } catch (e) {
      emit(JadwalError(message: e.toString()));
    }
  }
}
