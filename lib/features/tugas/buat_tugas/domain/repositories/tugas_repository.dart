// PURE DART — tanpa import Flutter
import '../entities/tugas.dart';

abstract class TugasRepository {
  Future<void> createTugas(Tugas tugas);
  Future<List<Tugas>> getTugasList();
}
