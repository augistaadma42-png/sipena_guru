part of 'detail_penilaian_bloc.dart';

abstract class DetailPenilaianEvent {
  const DetailPenilaianEvent();
}

/// Muat data berdasarkan siswaId + tugasId
class LoadDetailPenilaianEvent extends DetailPenilaianEvent {
  final String siswaId;
  final String tugasId;
  const LoadDetailPenilaianEvent({required this.siswaId, required this.tugasId});
}

/// Update nilai secara realtime saat guru mengetik
class UpdateNilaiEvent extends DetailPenilaianEvent {
  final int nilai;
  const UpdateNilaiEvent(this.nilai);
}

/// Update feedback secara realtime
class UpdateFeedbackEvent extends DetailPenilaianEvent {
  final String feedback;
  const UpdateFeedbackEvent(this.feedback);
}

/// Simpan penilaian ke datasource
class SubmitPenilaianEvent extends DetailPenilaianEvent {
  const SubmitPenilaianEvent();
}