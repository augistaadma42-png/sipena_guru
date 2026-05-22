import '../../domain/entities/notifikasi_entity.dart';
import '../../domain/repositories/notifikasi_repository.dart';
import '../datasources/notifikasi_local_datasource.dart';

class NotifikasiRepositoryImpl implements NotifikasiRepository {
  final NotifikasiLocalDatasource localDatasource;

  NotifikasiRepositoryImpl({required this.localDatasource});

  @override
  Future<List<NotifikasiEntity>> getNotifikasi() async {
    return await localDatasource.getNotifikasi();
  }

  @override
  Future<void> markAsRead(String id) async {
    return await localDatasource.markAsRead(id);
  }

  @override
  Future<void> markAllAsRead() async {
    return await localDatasource.markAllAsRead();
  }
}
