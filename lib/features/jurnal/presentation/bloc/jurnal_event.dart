import 'package:equatable/equatable.dart';

abstract class JurnalEvent extends Equatable {
  const JurnalEvent();

  @override
  List<Object?> get props => [];
}

class LoadJurnalTerbaruEvent extends JurnalEvent {}

class LoadRekapJurnalEvent extends JurnalEvent {
  final String? filterKelas;
  final int? filterBulan;
  final int? filterTahun;

  const LoadRekapJurnalEvent({
    this.filterKelas,
    this.filterBulan,
    this.filterTahun,
  });

  @override
  List<Object?> get props => [filterKelas, filterBulan, filterTahun];
}
