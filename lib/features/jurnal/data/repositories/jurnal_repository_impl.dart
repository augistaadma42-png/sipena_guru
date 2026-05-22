import '../../domain/entities/jurnal_entity.dart';
import '../../domain/repositories/jurnal_repository.dart';
import '../datasources/jurnal_local_datasource.dart';
import '../models/jurnal_model.dart';

class JurnalRepositoryImpl implements JurnalRepository {
  final JurnalLocalDatasource localDatasource;

  JurnalRepositoryImpl({required this.localDatasource});

  @override
  Future<List<JurnalEntity>> getJurnalTerbaru() async {
    return await localDatasource.getJurnalTerbaru();
  }

  @override
  Future<List<JurnalEntity>> getRekapJurnal(String? filterKelas, DateTime? filterTanggal) async {
    return await localDatasource.getRekapJurnal(filterKelas, filterTanggal);
  }

  @override
  Future<void> simpanJurnal(JurnalModel jurnal) async {
    return await localDatasource.simpanJurnal(jurnal);
  }
}
