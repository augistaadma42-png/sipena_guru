part of 'detail_penilaian_bloc.dart';

abstract class DetailPenilaianState {
  const DetailPenilaianState();
}

class DetailPenilaianInitial   extends DetailPenilaianState { const DetailPenilaianInitial(); }
class DetailPenilaianLoading   extends DetailPenilaianState { const DetailPenilaianLoading(); }
class DetailPenilaianSubmitting extends DetailPenilaianState { const DetailPenilaianSubmitting(); }
class DetailPenilaianSubmitSuccess extends DetailPenilaianState { const DetailPenilaianSubmitSuccess(); }

class DetailPenilaianLoaded extends DetailPenilaianState {
  final DetailPenilaianEntity entity;
  final int currentNilai;
  final String currentFeedback;

  const DetailPenilaianLoaded({
    required this.entity,
    required this.currentNilai,
    required this.currentFeedback,
  });

  DetailPenilaianLoaded copyWith({
    DetailPenilaianEntity? entity,
    int? currentNilai,
    String? currentFeedback,
  }) {
    return DetailPenilaianLoaded(
      entity: entity ?? this.entity,
      currentNilai: currentNilai ?? this.currentNilai,
      currentFeedback: currentFeedback ?? this.currentFeedback,
    );
  }
}

class DetailPenilaianError extends DetailPenilaianState {
  final String message;
  const DetailPenilaianError(this.message);
}