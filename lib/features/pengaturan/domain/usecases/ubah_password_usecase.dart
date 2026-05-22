import '../repositories/pengaturan_repository.dart';

class UbahPasswordUsecase {
  final PengaturanRepository repository;

  UbahPasswordUsecase(this.repository);

  Future<void> call({
    required String passwordLama,
    required String passwordBaru,
  }) async {
    await repository.ubahPassword(
      passwordLama: passwordLama,
      passwordBaru: passwordBaru,
    );
  }
}
