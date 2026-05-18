import 'package:equatable/equatable.dart';

abstract class InputNilaiEvent extends Equatable {
  const InputNilaiEvent();

  @override
  List<Object?> get props => [];
}

class LoadRankingEvent extends InputNilaiEvent {
  const LoadRankingEvent();
}

class ToggleShowAllEvent extends InputNilaiEvent {
  const ToggleShowAllEvent();
}

class ExportPdfEvent extends InputNilaiEvent {
  const ExportPdfEvent();
}
