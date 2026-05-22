import '../entities/riwayat_absensi_entity.dart';
import '../repositories/absen_repository.dart';

class GetRiwayatAbsensiUsecase {
  final AbsenRepository repository;

  GetRiwayatAbsensiUsecase(this.repository);

  Future<List<RiwayatAbsensiEntity>> call(DateTime? date, String? kelas) async {
    return await repository.getRiwayatAbsensi(date, kelas);
  }
}
