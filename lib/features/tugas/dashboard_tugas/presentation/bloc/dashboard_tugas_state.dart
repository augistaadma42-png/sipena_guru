import 'package:equatable/equatable.dart';
import '../../domain/entities/materi_entity.dart';
import '../../domain/entities/tugas_entity.dart';

abstract class DashboardTugasState extends Equatable {
  const DashboardTugasState();

  @override
  List<Object?> get props => [];
}

class DashboardTugasInitial extends DashboardTugasState {}

class DashboardTugasLoading extends DashboardTugasState {}

class DashboardTugasLoaded extends DashboardTugasState {
  final List<MateriEntity> materiList;
  final List<TugasEntity> tugasList;

  const DashboardTugasLoaded({
    required this.materiList,
    required this.tugasList,
  });

  @override
  List<Object?> get props => [materiList, tugasList];
}

class DashboardTugasEmpty extends DashboardTugasState {}

class DashboardTugasError extends DashboardTugasState {
  final String message;

  const DashboardTugasError(this.message);

  @override
  List<Object?> get props => [message];
}
