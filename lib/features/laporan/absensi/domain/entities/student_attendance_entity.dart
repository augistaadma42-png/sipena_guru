import 'package:equatable/equatable.dart';

/// Entity domain untuk data absensi per siswa.
class StudentAttendanceEntity extends Equatable {
  final String id;
  final String nama;
  final String nis;
  final int hadir;
  final int izin;
  final int sakit;
  final int dispensasi;
  final int alfa;

  const StudentAttendanceEntity({
    required this.id,
    required this.nama,
    required this.nis,
    required this.hadir,
    required this.izin,
    required this.sakit,
    required this.dispensasi,
    required this.alfa,
  });

  @override
  List<Object?> get props => [
        id,
        nama,
        nis,
        hadir,
        izin,
        sakit,
        dispensasi,
        alfa,
      ];
}