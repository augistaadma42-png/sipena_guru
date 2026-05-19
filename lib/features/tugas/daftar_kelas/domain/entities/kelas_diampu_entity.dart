import 'package:equatable/equatable.dart';

class KelasDiampuEntity extends Equatable {
  final String id;
  final String namaKelas;
  final String namaMapel;

  const KelasDiampuEntity({
    required this.id,
    required this.namaKelas,
    required this.namaMapel,
  });

  @override
  List<Object?> get props => [id, namaKelas, namaMapel];
}
