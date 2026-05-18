/// Entity murni — tidak bergantung pada framework apapun.
class DetailPenilaianEntity {
  final String id;
  final String studentName;
  final String nisn;
  final String kelas;
  final String tugasTitle;
  final String submittedAt;
  final String attachmentFileName;
  final String attachmentPreviewUrl;
  final int currentScore;
  final String feedback;
  final bool isSubmitted;

  const DetailPenilaianEntity({
    required this.id,
    required this.studentName,
    required this.nisn,
    required this.kelas,
    required this.tugasTitle,
    required this.submittedAt,
    required this.attachmentFileName,
    required this.attachmentPreviewUrl,
    required this.currentScore,
    required this.feedback,
    required this.isSubmitted,
  });

  DetailPenilaianEntity copyWith({
    String? id, String? studentName, String? nisn, String? kelas,
    String? tugasTitle, String? submittedAt, String? attachmentFileName,
    String? attachmentPreviewUrl, int? currentScore, String? feedback,
    bool? isSubmitted,
  }) {
    return DetailPenilaianEntity(
      id: id ?? this.id,
      studentName: studentName ?? this.studentName,
      nisn: nisn ?? this.nisn,
      kelas: kelas ?? this.kelas,
      tugasTitle: tugasTitle ?? this.tugasTitle,
      submittedAt: submittedAt ?? this.submittedAt,
      attachmentFileName: attachmentFileName ?? this.attachmentFileName,
      attachmentPreviewUrl: attachmentPreviewUrl ?? this.attachmentPreviewUrl,
      currentScore: currentScore ?? this.currentScore,
      feedback: feedback ?? this.feedback,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }
}