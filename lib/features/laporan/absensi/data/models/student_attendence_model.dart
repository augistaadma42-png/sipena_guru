import '../../domain/entities/student_attendance_entity.dart';

/// Model data layer untuk absensi siswa.
class StudentAttendanceModel extends StudentAttendanceEntity {
  const StudentAttendanceModel({
    required super.id,
    required super.nama,
    required super.nis,
    required super.hadir,
    required super.izin,
    required super.sakit,
    required super.dispensasi,
    required super.alfa,
  });

  factory StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceModel(
      id: json['id'] as String,
      nama: json['nama'] as String,
      nis: json['nis'] as String,
      hadir: json['hadir'] as int,
      izin: json['izin'] as int,
      sakit: json['sakit'] as int,
      dispensasi: json['dispensasi'] as int,
      alfa: json['alfa'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'nis': nis,
      'hadir': hadir,
      'izin': izin,
      'sakit': sakit,
      'dispensasi': dispensasi,
      'alfa': alfa,
    };
  }
}