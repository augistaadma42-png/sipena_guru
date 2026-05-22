import 'package:equatable/equatable.dart';

abstract class AbsenEvent extends Equatable {
  const AbsenEvent();

  @override
  List<Object?> get props => [];
}

class LoadRiwayatAbsensiEvent extends AbsenEvent {
  final DateTime? date;
  final String? kelas;

  const LoadRiwayatAbsensiEvent({this.date, this.kelas});

  @override
  List<Object?> get props => [date, kelas];
}

class LoadStudentAttendanceEvent extends AbsenEvent {
  final String kelas;

  const LoadStudentAttendanceEvent({required this.kelas});

  @override
  List<Object?> get props => [kelas];
}

class LoadLeaveRequestsEvent extends AbsenEvent {}

class UpdateLeaveRequestStatusEvent extends AbsenEvent {
  final String id;
  final String status;

  const UpdateLeaveRequestStatusEvent({required this.id, required this.status});

  @override
  List<Object?> get props => [id, status];
}
