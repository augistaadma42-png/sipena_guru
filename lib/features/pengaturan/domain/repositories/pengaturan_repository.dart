import '../entities/pengaturan_profile_entity.dart';

abstract class PengaturanRepository {
  Future<PengaturanProfileEntity> getProfile();
  Future<void> ubahPassword({
    required String passwordLama,
    required String passwordBaru,
  });
}
