import '../repositories/absen_repository.dart';

class UpdateLeaveRequestStatusUsecase {
  final AbsenRepository repository;

  UpdateLeaveRequestStatusUsecase(this.repository);

  Future<void> call(String id, String status) async {
    return await repository.updateLeaveRequestStatus(id, status);
  }
}
