import 'package:equatable/equatable.dart';

import '../../domain/entities/class_statistics_entity.dart';
import '../../domain/entities/student_ranking_entity.dart';

abstract class InputNilaiState extends Equatable {
  const InputNilaiState();

  @override
  List<Object?> get props => [];
}

class InputNilaiInitial extends InputNilaiState {
  const InputNilaiInitial();
}

class InputNilaiLoading extends InputNilaiState {
  const InputNilaiLoading();
}

class InputNilaiEmpty extends InputNilaiState {
  const InputNilaiEmpty();
}

class InputNilaiError extends InputNilaiState {
  final String message;

  const InputNilaiError(this.message);

  @override
  List<Object?> get props => [message];
}

class InputNilaiLoaded extends InputNilaiState {
  final ClassStatisticsEntity statistics;
  final List<StudentRankingEntity> rankings;
  final bool showAll;

  const InputNilaiLoaded({
    required this.statistics,
    required this.rankings,
    required this.showAll,
  });

  @override
  List<Object?> get props => [statistics, rankings, showAll];

  InputNilaiLoaded copyWith({
    ClassStatisticsEntity? statistics,
    List<StudentRankingEntity>? rankings,
    bool? showAll,
  }) {
    return InputNilaiLoaded(
      statistics: statistics ?? this.statistics,
      rankings: rankings ?? this.rankings,
      showAll: showAll ?? this.showAll,
    );
  }
}
