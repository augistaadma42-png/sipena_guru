import 'package:equatable/equatable.dart';

class TugasEntity extends Equatable {
  final String id;
  final String kelas;
  final String title;
  final String subtitle;
  final String deadline;
  final int totalAnggota;
  final String sisaHari;
  final bool isUrgent;

  const TugasEntity({
    required this.id,
    required this.kelas,
    required this.title,
    required this.subtitle,
    required this.deadline,
    required this.totalAnggota,
    required this.sisaHari,
    required this.isUrgent,
  });

  @override
  List<Object?> get props => [
        id,
        kelas,
        title,
        subtitle,
        deadline,
        totalAnggota,
        sisaHari,
        isUrgent,
      ];
}
