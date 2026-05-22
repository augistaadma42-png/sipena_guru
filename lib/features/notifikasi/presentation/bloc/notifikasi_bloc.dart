import 'package:flutter_bloc/flutter_bloc.dart';
import 'notifikasi_event.dart';
import 'notifikasi_state.dart';
import '../../domain/usecases/get_notifikasi_usecase.dart';
import '../../domain/usecases/mark_all_as_read_usecase.dart';
import '../../domain/usecases/mark_as_read_usecase.dart';

class NotifikasiBloc extends Bloc<NotifikasiEvent, NotifikasiState> {
  final GetNotifikasiUsecase getNotifikasiUsecase;
  final MarkAsReadUsecase markAsReadUsecase;
  final MarkAllAsReadUsecase markAllAsReadUsecase;

  NotifikasiBloc({
    required this.getNotifikasiUsecase,
    required this.markAsReadUsecase,
    required this.markAllAsReadUsecase,
  }) : super(NotifikasiInitial()) {
    on<LoadNotifikasiEvent>((event, emit) async {
      emit(NotifikasiLoading());
      try {
        final data = await getNotifikasiUsecase();
        emit(NotifikasiLoaded(notifikasiList: data));
      } catch (e) {
        emit(NotifikasiError(message: e.toString()));
      }
    });

    on<MarkAsReadEvent>((event, emit) async {
      try {
        await markAsReadUsecase(event.id);
        final data = await getNotifikasiUsecase();
        emit(NotifikasiLoaded(notifikasiList: data));
      } catch (e) {
        emit(NotifikasiError(message: e.toString()));
      }
    });

    on<MarkAllAsReadEvent>((event, emit) async {
      try {
        await markAllAsReadUsecase();
        final data = await getNotifikasiUsecase();
        emit(NotifikasiLoaded(notifikasiList: data));
      } catch (e) {
        emit(NotifikasiError(message: e.toString()));
      }
    });
  }
}
