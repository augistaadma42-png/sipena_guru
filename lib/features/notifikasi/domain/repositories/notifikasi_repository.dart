import '../entities/notifikasi_entity.dart';

abstract class NotifikasiRepository {
  Future<List<NotifikasiEntity>> getNotifikasi();
  Future<void> markAsRead(String id);
  Future<void> markAllAsRead();
}
