import '../entities/leave_request_entity.dart';
import '../repositories/absen_repository.dart';

class GetLeaveRequestsUsecase {
  final AbsenRepository repository;

  GetLeaveRequestsUsecase(this.repository);

  Future<List<LeaveRequestEntity>> call() async {
    return await repository.getLeaveRequests();
  }
}
