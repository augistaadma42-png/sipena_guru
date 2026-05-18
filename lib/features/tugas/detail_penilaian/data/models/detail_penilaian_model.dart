import '../../domain/entities/detail_penilaian_entity.dart';

/// Model data — extend entity agar bisa (de)serialisasi JSON.
class DetailPenilaianModel extends DetailPenilaianEntity {
  const DetailPenilaianModel({
    required super.id,          required super.studentName,
    required super.nisn,        required super.kelas,
    required super.tugasTitle,  required super.submittedAt,
    required super.attachmentFileName,
    required super.attachmentPreviewUrl,
    required super.currentScore,
    required super.feedback,    required super.isSubmitted,
  });

  factory DetailPenilaianModel.fromJson(Map<String, dynamic> json) {
    return DetailPenilaianModel(
      id: json['id'] as String,
      studentName: json['student_name'] as String,
      nisn: json['nisn'] as String,
      kelas: json['kelas'] as String,
      tugasTitle: json['tugas_title'] as String,
      submittedAt: json['submitted_at'] as String,
      attachmentFileName: json['attachment_file_name'] as String,
      attachmentPreviewUrl: json['attachment_preview_url'] as String,
      currentScore: json['current_score'] as int? ?? 0,
      feedback: json['feedback'] as String? ?? '',
      isSubmitted: json['is_submitted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id, 'student_name': studentName, 'nisn': nisn, 'kelas': kelas,
    'tugas_title': tugasTitle, 'submitted_at': submittedAt,
    'attachment_file_name': attachmentFileName,
    'attachment_preview_url': attachmentPreviewUrl,
    'current_score': currentScore, 'feedback': feedback,
    'is_submitted': isSubmitted,
  };

  @override
  DetailPenilaianModel copyWith({
    String? id, String? studentName, String? nisn, String? kelas,
    String? tugasTitle, String? submittedAt, String? attachmentFileName,
    String? attachmentPreviewUrl, int? currentScore, String? feedback,
    bool? isSubmitted,
  }) {
    return DetailPenilaianModel(
      id: id ?? this.id, studentName: studentName ?? this.studentName,
      nisn: nisn ?? this.nisn, kelas: kelas ?? this.kelas,
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