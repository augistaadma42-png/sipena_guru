import '../models/pengaturan_profile_model.dart';

abstract class PengaturanLocalDatasource {
  Future<PengaturanProfileModel> getProfile();
  Future<void> ubahPassword({
    required String passwordLama,
    required String passwordBaru,
  });
}

class PengaturanLocalDatasourceImpl implements PengaturanLocalDatasource {
  // Simulasi password yang tersimpan (akan diganti API nanti)
  String _passwordTersimpan = 'password123';

  @override
  Future<PengaturanProfileModel> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const PengaturanProfileModel(
      nama: 'Umi Kulsum, S.Pd.',
      nip: '198504152010012003',
      email: 'umikuslum@sipena.sch.id',
      mapel: 'Matematika',
      jabatan: 'Guru Mapel',
    );
  }

  @override
  Future<void> ubahPassword({
    required String passwordLama,
    required String passwordBaru,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    if (passwordLama != _passwordTersimpan) {
      throw Exception('Password lama tidak sesuai');
    }
    _passwordTersimpan = passwordBaru;
  }
}
