import 'package:equatable/equatable.dart';
import '../../domain/entities/aktivitas_entity.dart';
import '../../domain/entities/task_summary_entity.dart';
import '../../domain/entities/attendance_overview_entity.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<AktivitasEntity> aktivitasList;
  final List<TaskSummaryEntity> taskSummaryList;
  final List<AttendanceOverviewEntity> attendanceOverviewList;

  const DashboardLoaded({
    required this.aktivitasList,
    required this.taskSummaryList,
    required this.attendanceOverviewList,
  });

  @override
  List<Object> get props => [aktivitasList, taskSummaryList, attendanceOverviewList];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError({required this.message});

  @override
  List<Object> get props => [message];
}
