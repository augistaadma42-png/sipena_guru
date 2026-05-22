import '../entities/pengaturan_profile_entity.dart';
import '../repositories/pengaturan_repository.dart';

class GetProfileUsecase {
  final PengaturanRepository repository;

  GetProfileUsecase(this.repository);

  Future<PengaturanProfileEntity> call() async {
    return await repository.getProfile();
  }
}
