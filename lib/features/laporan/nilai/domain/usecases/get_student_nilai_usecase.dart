import '../entities/student_nilai_entity.dart';
import '../repositories/laporan_repository.dart';

/// Params untuk usecase GetStudentNilai
class GetStudentNilaiParams {
  final int page;
  final int perPage;

  const GetStudentNilaiParams({
    required this.page,
    this.perPage = 5,
  });
}

/// Usecase untuk mengambil daftar nilai siswa
class GetStudentNilaiUsecase {
  final LaporanRepository repository;

  const GetStudentNilaiUsecase(this.repository);

  Future<List<StudentNilaiEntity>> call(GetStudentNilaiParams params) async {
    return repository.getStudentNilai(
      page: params.page,
      perPage: params.perPage,
    );
  }
}

/// Usecase untuk mengambil total siswa
class GetTotalSiswaUsecase {
  final LaporanRepository repository;

  const GetTotalSiswaUsecase(this.repository);

  Future<int> call() async {
    return repository.getTotalSiswa();
  }
}