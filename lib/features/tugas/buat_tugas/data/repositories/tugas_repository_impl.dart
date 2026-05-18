import '../../domain/entities/tugas.dart';
import '../../domain/repositories/tugas_repository.dart';

class TugasRepositoryImpl implements TugasRepository {
  // In-memory store — hanya untuk frontend demo
  final List<Tugas> _tugasList = [];

  @override
  Future<void> createTugas(Tugas tugas) async {
    // Simulasi delay network
    await Future.delayed(const Duration(milliseconds: 300));
    _tugasList.add(tugas);
    // ignore: avoid_print
    print('[TugasRepositoryImpl] Tugas disimpan (dummy): ${tugas.judul}');
  }

  @override
  Future<List<Tugas>> getTugasList() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(_tugasList);
  }
}
