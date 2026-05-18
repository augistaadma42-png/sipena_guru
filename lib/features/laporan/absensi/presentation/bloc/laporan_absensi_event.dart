import 'package:equatable/equatable.dart';

abstract class LaporanAbsensiEvent extends Equatable {
  const LaporanAbsensiEvent();

  @override
  List<Object?> get props => [];
}

class LoadAttendanceEvent extends LaporanAbsensiEvent {
  const LoadAttendanceEvent();
}

class ChangeMonthEvent extends LaporanAbsensiEvent {
  final String monthKey;
  final String monthLabel;

  const ChangeMonthEvent({
    required this.monthKey,
    required this.monthLabel,
  });

  @override
  List<Object?> get props => [monthKey, monthLabel];
}

class ExportPdfEvent extends LaporanAbsensiEvent {
  const ExportPdfEvent();
}