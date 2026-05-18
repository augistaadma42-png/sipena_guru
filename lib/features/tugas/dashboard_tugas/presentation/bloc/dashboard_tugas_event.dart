import 'package:equatable/equatable.dart';

abstract class DashboardTugasEvent extends Equatable {
  const DashboardTugasEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboardTugasEvent extends DashboardTugasEvent {}

class RefreshDashboardEvent extends DashboardTugasEvent {}

class AddTugasEvent extends DashboardTugasEvent {}
