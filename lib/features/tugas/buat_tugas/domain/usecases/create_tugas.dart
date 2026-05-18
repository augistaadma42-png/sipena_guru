// PURE DART — tanpa import Flutter
import '../entities/tugas.dart';
import '../repositories/tugas_repository.dart';

class CreateTugas {
  final TugasRepository repository;

  const CreateTugas(this.repository);

  Future<void> call(Tugas tugas) async {
    await repository.createTugas(tugas);
  }
}
