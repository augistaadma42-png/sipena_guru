import '../repositories/notifikasi_repository.dart';

class MarkAllAsReadUsecase {
  final NotifikasiRepository repository;

  MarkAllAsReadUsecase(this.repository);

  Future<void> call() async {
    return await repository.markAllAsRead();
  }
}
