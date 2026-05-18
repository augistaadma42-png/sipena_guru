import 'package:equatable/equatable.dart';

/// Entity domain untuk data nilai siswa
class StudentNilaiEntity extends Equatable {
  final String id;
  final String nama;
  final String kelas;
  final String tanggalInput;

  const StudentNilaiEntity({
    required this.id,
    required this.nama,
    required this.kelas,
    required this.tanggalInput,
  });

  @override
  List<Object?> get props => [id, nama, kelas, tanggalInput];
}