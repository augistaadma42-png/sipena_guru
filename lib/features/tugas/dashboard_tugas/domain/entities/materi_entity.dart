import 'package:equatable/equatable.dart';

class MateriEntity extends Equatable {
  final String id;
  final String title;
  final String category; // mapel
  final int totalMateri;
  final String tanggal;
  final String kelas;
  final int lampiranCount;
  final String deskripsi;
  final List<String> lampiranNames;

  const MateriEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.totalMateri,
    required this.tanggal,
    this.kelas = '',
    this.lampiranCount = 0,
    this.deskripsi = '',
    this.lampiranNames = const [],
  });

  @override
  List<Object?> get props => [
    id,
    title,
    category,
    totalMateri,
    tanggal,
    kelas,
    lampiranCount,
    deskripsi,
    lampiranNames,
  ];
}
