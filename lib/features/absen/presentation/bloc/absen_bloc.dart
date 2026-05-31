import 'package:flutter_bloc/flutter_bloc.dart';
import 'absen_event.dart';
import 'absen_state.dart';
import '../../domain/usecases/get_riwayat_absensi_usecase.dart';
import '../../domain/usecases/get_student_attendance_usecase.dart';
import '../../domain/usecases/get_leave_requests_usecase.dart';
import '../../domain/usecases/update_leave_request_status_usecase.dart';

class AbsenBloc extends Bloc<AbsenEvent, AbsenState> {
  final GetRiwayatAbsensiUsecase getRiwayatAbsensiUsecase;
  final GetStudentAttendanceUsecase getStudentAttendanceUsecase;
  final GetLeaveRequestsUsecase getLeaveRequestsUsecase;
  final UpdateLeaveRequestStatusUsecase updateLeaveRequestStatusUsecase;

  AbsenBloc({
    required this.getRiwayatAbsensiUsecase,
    required this.getStudentAttendanceUsecase,
    required this.getLeaveRequestsUsecase,
    required this.updateLeaveRequestStatusUsecase,
  }) : super(AbsenInitial()) {
    on<ResetAbsenEvent>((event, emit) {
      emit(AbsenInitial());
    });

    on<LoadRiwayatAbsensiEvent>((event, emit) async {
      emit(AbsenLoading());
      try {
        final data = await getRiwayatAbsensiUsecase(event.date, event.kelas);
        emit(RiwayatAbsensiLoaded(riwayatList: data));
      } catch (e) {
        emit(AbsenError(message: e.toString()));
      }
    });

    on<LoadStudentAttendanceEvent>((event, emit) async {
      emit(AbsenLoading());
      try {
        final data = await getStudentAttendanceUsecase(event.kelas);
        final loadedState = StudentAttendanceLoaded(studentList: data);
        emit(loadedState);
      } catch (e) {
        emit(AbsenError(message: e.toString()));
      }
    });

    on<LoadLeaveRequestsEvent>((event, emit) async {
      emit(AbsenLoading());
      try {
        final data = await getLeaveRequestsUsecase();
        emit(LeaveRequestsLoaded(leaveRequests: data));
      } catch (e) {
        emit(AbsenError(message: e.toString()));
      }
    });

    on<UpdateLeaveRequestStatusEvent>((event, emit) async {
      try {
        await updateLeaveRequestStatusUsecase(event.id, event.status);
        final data = await getLeaveRequestsUsecase();
        emit(LeaveRequestsLoaded(leaveRequests: data));
      } catch (e) {
        emit(AbsenError(message: e.toString()));
      }
    });
  }
}
