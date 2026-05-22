import 'package:equatable/equatable.dart';
import '../../domain/entities/jurnal_entity.dart';

abstract class JurnalState extends Equatable {
  const JurnalState();

  @override
  List<Object?> get props => [];
}

class JurnalInitial extends JurnalState {}

class JurnalLoading extends JurnalState {}

class JurnalTerbaruLoaded extends JurnalState {
  final List<JurnalEntity> jurnalList;

  const JurnalTerbaruLoaded({required this.jurnalList});

  @override
  List<Object?> get props => [jurnalList];
}

class RekapJurnalLoaded extends JurnalState {
  final List<JurnalEntity> rekapList;

  const RekapJurnalLoaded({required this.rekapList});

  @override
  List<Object?> get props => [rekapList];
}

class JurnalError extends JurnalState {
  final String message;

  const JurnalError({required this.message});

  @override
  List<Object?> get props => [message];
}
