import 'package:equatable/equatable.dart';
import '../../domain/entities/assignment_entity.dart';

/// Semua state yang dapat diemit oleh LaporanTugasBloc
abstract class LaporanTugasState extends Equatable {
  const LaporanTugasState();

  @override
  List<Object?> get props => [];
}

/// State awal sebelum ada event
class LaporanTugasInitial extends LaporanTugasState {
  const LaporanTugasInitial();
}

/// State saat sedang loading data
class LaporanTugasLoading extends LaporanTugasState {
  const LaporanTugasLoading();
}

/// State saat data berhasil dimuat
class LaporanTugasLoaded extends LaporanTugasState {
  final List<AssignmentEntity> assignments;
  final String selectedBulan;
  final String selectedKelas;
  final String selectedMataPelajaran;
  final Set<String> expandedIds; // ID tugas yang sedang di-expand

  const LaporanTugasLoaded({
    required this.assignments,
    required this.selectedBulan,
    required this.selectedKelas,
    required this.selectedMataPelajaran,
    this.expandedIds = const {},
  });

  LaporanTugasLoaded copyWith({
    List<AssignmentEntity>? assignments,
    String? selectedBulan,
    String? selectedKelas,
    String? selectedMataPelajaran,
    Set<String>? expandedIds,
  }) {
    return LaporanTugasLoaded(
      assignments: assignments ?? this.assignments,
      selectedBulan: selectedBulan ?? this.selectedBulan,
      selectedKelas: selectedKelas ?? this.selectedKelas,
      selectedMataPelajaran:
          selectedMataPelajaran ?? this.selectedMataPelajaran,
      expandedIds: expandedIds ?? this.expandedIds,
    );
  }

  @override
  List<Object?> get props => [
        assignments,
        selectedBulan,
        selectedKelas,
        selectedMataPelajaran,
        expandedIds,
      ];
}

/// State saat tidak ada data ditemukan
class LaporanTugasEmpty extends LaporanTugasState {
  const LaporanTugasEmpty();
}

/// State saat terjadi error
class LaporanTugasError extends LaporanTugasState {
  final String message;

  const LaporanTugasError(this.message);

  @override
  List<Object?> get props => [message];
}
