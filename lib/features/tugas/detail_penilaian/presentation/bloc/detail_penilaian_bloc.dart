import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/detail_penilaian_entity.dart';
import '../../domain/usecase/get_detail_penilaian_usecase.dart';
import '../../domain/usecase/submit_penilaian_usecase.dart';

part 'detail_penilaian_event.dart';
part 'detail_penilaian_state.dart';

class DetailPenilaianBloc
    extends Bloc<DetailPenilaianEvent, DetailPenilaianState> {
  final GetDetailPenilaianUsecase _getDetailPenilaian;
  final SubmitPenilaianUsecase _submitPenilaian;

  String _siswaId = '';
  String _tugasId = '';

  DetailPenilaianBloc({
    required GetDetailPenilaianUsecase getDetailPenilaian,
    required SubmitPenilaianUsecase submitPenilaian,
  })  : _getDetailPenilaian = getDetailPenilaian,
        _submitPenilaian = submitPenilaian,
        super(const DetailPenilaianInitial()) {
    on<LoadDetailPenilaianEvent>(_onLoad);
    on<UpdateNilaiEvent>(_onUpdateNilai);
    on<UpdateFeedbackEvent>(_onUpdateFeedback);
    on<SubmitPenilaianEvent>(_onSubmit);
  }

  Future<void> _onLoad(LoadDetailPenilaianEvent event,
      Emitter<DetailPenilaianState> emit) async {
    emit(const DetailPenilaianLoading());
    try {
      _siswaId = event.siswaId;
      _tugasId = event.tugasId;
      final entity = await _getDetailPenilaian(
        siswaId: _siswaId, tugasId: _tugasId,
      );
      emit(DetailPenilaianLoaded(
        entity: entity,
        currentNilai: entity.currentScore,
        currentFeedback: entity.feedback,
      ));
    } catch (e) {
      emit(DetailPenilaianError(e.toString()));
    }
  }

  void _onUpdateNilai(UpdateNilaiEvent event,
      Emitter<DetailPenilaianState> emit) {
    if (state is DetailPenilaianLoaded) {
      final s = state as DetailPenilaianLoaded;
      emit(s.copyWith(currentNilai: event.nilai.clamp(0, 100)));
    }
  }

  void _onUpdateFeedback(UpdateFeedbackEvent event,
      Emitter<DetailPenilaianState> emit) {
    if (state is DetailPenilaianLoaded) {
      final s = state as DetailPenilaianLoaded;
      emit(s.copyWith(currentFeedback: event.feedback));
    }
  }

  Future<void> _onSubmit(SubmitPenilaianEvent event,
      Emitter<DetailPenilaianState> emit) async {
    if (state is! DetailPenilaianLoaded) return;
    final current = state as DetailPenilaianLoaded;
    emit(const DetailPenilaianSubmitting());
    try {
      await _submitPenilaian(
        siswaId: _siswaId, tugasId: _tugasId,
        score: current.currentNilai, feedback: current.currentFeedback,
      );
      emit(const DetailPenilaianSubmitSuccess());
      // Kembali ke loaded agar UI tetap tampil
      emit(current.copyWith(
        entity: current.entity.copyWith(
          currentScore: current.currentNilai,
          feedback: current.currentFeedback,
          isSubmitted: true,
        ),
      ));
    } catch (e) {
      emit(DetailPenilaianError(e.toString()));
    }
  }
}