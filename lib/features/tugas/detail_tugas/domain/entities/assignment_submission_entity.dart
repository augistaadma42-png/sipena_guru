import 'package:equatable/equatable.dart';

/// Entity untuk data pengumpulan tugas per siswa
class AssignmentSubmissionEntity extends Equatable {
  final String id;
  final String studentName;
  final String avatar;
  final String? submittedAt; // null jika belum mengumpulkan
  final String? fileName;   // null jika belum mengumpulkan
  final int? score;          // null jika belum dinilai
  final bool isSubmitted;

  const AssignmentSubmissionEntity({
    required this.id,
    required this.studentName,
    required this.avatar,
    this.submittedAt,
    this.fileName,
    this.score,
    required this.isSubmitted,
  });

  @override
  List<Object?> get props => [
        id,
        studentName,
        avatar,
        submittedAt,
        fileName,
        score,
        isSubmitted,
      ];
}
