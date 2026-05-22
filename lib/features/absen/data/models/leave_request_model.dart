import '../../domain/entities/leave_request_entity.dart';

class LeaveRequestModel extends LeaveRequestEntity {
  const LeaveRequestModel({
    required super.id,
    required super.studentName,
    required super.initials,
    required super.nisn,
    required super.className,
    required super.type,
    required super.date,
    required super.duration,
    required super.reason,
    required super.suratAda,
    required super.status,
  });

  LeaveRequestModel copyWith({String? status}) {
    return LeaveRequestModel(
      id: id,
      studentName: studentName,
      initials: initials,
      nisn: nisn,
      className: className,
      type: type,
      date: date,
      duration: duration,
      reason: reason,
      suratAda: suratAda,
      status: status ?? this.status,
    );
  }
}
