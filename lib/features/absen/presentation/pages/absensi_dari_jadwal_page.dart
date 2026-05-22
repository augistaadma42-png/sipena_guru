import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import 'input_absensi_tab.dart';
import 'detail_absensi_page.dart';
import '../bloc/absen_bloc.dart';
import '../../data/datasources/absen_local_datasource.dart';
import '../../data/repositories/absen_repository_impl.dart';
import '../../domain/usecases/get_riwayat_absensi_usecase.dart';
import '../../domain/usecases/get_student_attendance_usecase.dart';
import '../../domain/usecases/get_leave_requests_usecase.dart';
import '../../domain/usecases/update_leave_request_status_usecase.dart';

class AbsensiDariJadwalPage extends StatelessWidget {
  final String className;
  final String subject;
  final String time;
  final String jamKe;
  final bool isReadOnly;

  const AbsensiDariJadwalPage({
    Key? key,
    required this.className,
    required this.subject,
    required this.time,
    required this.jamKe,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Jika sudah diisi (isReadOnly = true), tampilkan detail absensi (view)
    // Jika belum diisi (isReadOnly = false), tampilkan form input absensi
    if (isReadOnly) {
      return DetailAbsensiPage(
        className: className,
        subject: subject,
        time: time,
        jamKe: jamKe,
        isReadOnly: true,
      );
    }

    final ds = AbsenLocalDatasourceImpl();
    final repo = AbsenRepositoryImpl(localDatasource: ds);

    return BlocProvider(
      create: (_) => AbsenBloc(
        getRiwayatAbsensiUsecase: GetRiwayatAbsensiUsecase(repo),
        getStudentAttendanceUsecase: GetStudentAttendanceUsecase(repo),
        getLeaveRequestsUsecase: GetLeaveRequestsUsecase(repo),
        updateLeaveRequestStatusUsecase: UpdateLeaveRequestStatusUsecase(repo),
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: const CustomAppBar(title: 'Isi Absensi', showBackButton: true),
        body: InputAbsensiTab(
          prefilledKelas: className,
          prefilledSubject: subject,
        ),
      ),
    );
  }
}
