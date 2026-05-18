import '../entities/assignment_recap_entity.dart';

/// Interface repository untuk rekap pengumpulan tugas
abstract class RekapPengumpulanRepository {
  Future<AssignmentRecapEntity> getAssignmentRecap(String tugasId);
}
