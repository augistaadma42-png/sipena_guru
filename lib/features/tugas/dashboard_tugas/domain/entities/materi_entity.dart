import 'package:equatable/equatable.dart';

class MateriEntity extends Equatable {
  final String id;
  final String title;
  final String category;
  final int totalMateri;
  final String tanggal;

  const MateriEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.totalMateri,
    required this.tanggal,
  });

  @override
  List<Object?> get props => [id, title, category, totalMateri, tanggal];
}
