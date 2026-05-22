import '../../domain/entities/pengaturan_profile_entity.dart';
import '../../domain/repositories/pengaturan_repository.dart';
import '../datasources/pengaturan_local_datasource.dart';

class PengaturanRepositoryImpl implements PengaturanRepository {
  final PengaturanLocalDatasource localDatasource;

  PengaturanRepositoryImpl({required this.localDatasource});

  @override
  Future<PengaturanProfileEntity> getProfile() async {
    return await localDatasource.getProfile();
  }

  @override
  Future<void> ubahPassword({
    required String passwordLama,
    required String passwordBaru,
  }) async {
    await localDatasource.ubahPassword(
      passwordLama: passwordLama,
      passwordBaru: passwordBaru,
    );
  }
}
