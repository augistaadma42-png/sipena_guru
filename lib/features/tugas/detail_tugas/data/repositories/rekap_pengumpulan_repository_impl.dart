import '../../domain/entities/assignment_recap_entity.dart';
import '../../domain/repositories/rekap_pengumpulan_repository.dart';
import '../datasources/rekap_pengumpulan_local_datasource.dart';

class RekapPengumpulanRepositoryImpl implements RekapPengumpulanRepository {
  final RekapPengumpulanLocalDatasource localDatasource;

  RekapPengumpulanRepositoryImpl({required this.localDatasource});

  @override
  Future<AssignmentRecapEntity> getAssignmentRecap(String tugasId) async {
    return await localDatasource.getAssignmentRecap(tugasId);
  }
}
