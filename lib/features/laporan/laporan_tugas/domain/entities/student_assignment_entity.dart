import 'package:equatable/equatable.dart';

/// Entity untuk data siswa terkait tugas
class StudentAssignmentEntity extends Equatable {
  final String id;
  final String nama;
  final String initials;
  final bool submitted;

  const StudentAssignmentEntity({
    required this.id,
    required this.nama,
    required this.initials,
    required this.submitted,
  });

  @override
  List<Object?> get props => [id, nama, initials, submitted];
}
