import 'package:equatable/equatable.dart';
import '../../domain/entities/riwayat_absensi_entity.dart';
import '../../domain/entities/student_attendance_entity.dart';
import '../../domain/entities/leave_request_entity.dart';

abstract class AbsenState extends Equatable {
  const AbsenState();

  @override
  List<Object?> get props => [];
}

class AbsenInitial extends AbsenState {}

class AbsenLoading extends AbsenState {}

class RiwayatAbsensiLoaded extends AbsenState {
  final List<RiwayatAbsensiEntity> riwayatList;

  const RiwayatAbsensiLoaded({required this.riwayatList});

  @override
  List<Object?> get props => [riwayatList];
}

class StudentAttendanceLoaded extends AbsenState {
  final List<StudentAttendanceEntity> studentList;

  const StudentAttendanceLoaded({required this.studentList});

  @override
  List<Object?> get props => [studentList];
}

class LeaveRequestsLoaded extends AbsenState {
  final List<LeaveRequestEntity> leaveRequests;

  const LeaveRequestsLoaded({required this.leaveRequests});

  @override
  List<Object?> get props => [leaveRequests];
}

class AbsenError extends AbsenState {
  final String message;

  const AbsenError({required this.message});

  @override
  List<Object?> get props => [message];
}
