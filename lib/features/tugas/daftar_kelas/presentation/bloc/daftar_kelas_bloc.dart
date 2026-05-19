import 'package:flutter_bloc/flutter_bloc.dart';
import 'daftar_kelas_event.dart';
import 'daftar_kelas_state.dart';
import '../../domain/usecases/get_daftar_kelas_usecase.dart';

class DaftarKelasBloc extends Bloc<DaftarKelasEvent, DaftarKelasState> {
  final GetDaftarKelasUsecase getDaftarKelas;

  DaftarKelasBloc({required this.getDaftarKelas}) : super(DaftarKelasInitial()) {
    on<LoadDaftarKelasEvent>((event, emit) async {
      emit(DaftarKelasLoading());
      try {
        final kelasList = await getDaftarKelas();
        emit(DaftarKelasLoaded(kelasList: kelasList));
      } catch (e) {
        emit(DaftarKelasError(message: e.toString()));
      }
    });
  }
}
