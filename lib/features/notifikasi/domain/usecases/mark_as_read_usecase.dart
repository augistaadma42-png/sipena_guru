import '../repositories/notifikasi_repository.dart';

class MarkAsReadUsecase {
  final NotifikasiRepository repository;

  MarkAsReadUsecase(this.repository);

  Future<void> call(String id) async {
    return await repository.markAsRead(id);
  }
}
