import '../entities/notifikasi_entity.dart';
import '../repositories/notifikasi_repository.dart';

class GetNotifikasiUsecase {
  final NotifikasiRepository repository;

  GetNotifikasiUsecase(this.repository);

  Future<List<NotifikasiEntity>> call() async {
    return await repository.getNotifikasi();
  }
}
