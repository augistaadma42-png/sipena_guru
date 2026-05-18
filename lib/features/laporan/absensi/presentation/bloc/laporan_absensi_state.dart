import 'package:equatable/equatable.dart';

import '../../domain/entities/student_attendance_entity.dart';

abstract class LaporanAbsensiState extends Equatable {
  const LaporanAbsensiState();

  @override
  List<Object?> get props => [];
}

class LaporanAbsensiInitial extends LaporanAbsensiState {
  const LaporanAbsensiInitial();
}

class LaporanAbsensiLoading extends LaporanAbsensiState {
  const LaporanAbsensiLoading();
}

class LaporanAbsensiLoaded extends LaporanAbsensiState {
  final List<StudentAttendanceEntity> students;
  final int currentPage;
  final int totalStudents;
  final int perPage;
  final String monthKey;
  final String monthLabel;
  final String classLabel;
  final String homeroomTeacher;

  const LaporanAbsensiLoaded({
    required this.students,
    required this.currentPage,
    required this.totalStudents,
    required this.perPage,
    required this.monthKey,
    required this.monthLabel,
    required this.classLabel,
    required this.homeroomTeacher,
  });

  int get totalPages => (totalStudents / perPage).ceil();

  int get totalHadir => students.fold(0, (sum, e) => sum + e.hadir);
  int get totalAlfa => students.fold(0, (sum, e) => sum + e.alfa);
  double get averageHadirPercent {
    if (students.isEmpty) return 0;
    final maxPossible = students.length * 22;
    return (totalHadir / maxPossible) * 100;
  }

  LaporanAbsensiLoaded copyWith({
    List<StudentAttendanceEntity>? students,
    int? currentPage,
    int? totalStudents,
    int? perPage,
    String? monthKey,
    String? monthLabel,
    String? classLabel,
    String? homeroomTeacher,
  }) {
    return LaporanAbsensiLoaded(
      students: students ?? this.students,
      currentPage: currentPage ?? this.currentPage,
      totalStudents: totalStudents ?? this.totalStudents,
      perPage: perPage ?? this.perPage,
      monthKey: monthKey ?? this.monthKey,
      monthLabel: monthLabel ?? this.monthLabel,
      classLabel: classLabel ?? this.classLabel,
      homeroomTeacher: homeroomTeacher ?? this.homeroomTeacher,
    );
  }

  @override
  List<Object?> get props => [
        students,
        currentPage,
        totalStudents,
        perPage,
        monthKey,
        monthLabel,
        classLabel,
        homeroomTeacher,
      ];
}

class LaporanAbsensiEmpty extends LaporanAbsensiState {
  final String monthLabel;

  const LaporanAbsensiEmpty({required this.monthLabel});

  @override
  List<Object?> get props => [monthLabel];
}

class LaporanAbsensiError extends LaporanAbsensiState {
  final String message;

  const LaporanAbsensiError(this.message);

  @override
  List<Object?> get props => [message];
}