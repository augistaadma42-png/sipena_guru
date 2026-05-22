import 'package:equatable/equatable.dart';

abstract class JurnalEvent extends Equatable {
  const JurnalEvent();

  @override
  List<Object?> get props => [];
}

class LoadJurnalTerbaruEvent extends JurnalEvent {}

class LoadRekapJurnalEvent extends JurnalEvent {
  final String? filterKelas;
  final DateTime? filterTanggal;

  const LoadRekapJurnalEvent({this.filterKelas, this.filterTanggal});

  @override
  List<Object?> get props => [filterKelas, filterTanggal];
}
