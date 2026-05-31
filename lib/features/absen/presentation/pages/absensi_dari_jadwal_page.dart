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

class AbsensiDariJadwalPage extends StatefulWidget {
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
  State<AbsensiDariJadwalPage> createState() => _AbsensiDariJadwalPageState();
}

class _AbsensiDariJadwalPageState extends State<AbsensiDariJadwalPage> {
  late final AbsenBloc _absenBloc;
  final GlobalKey<InputAbsensiTabState> _inputAbsensiTabKey =
      GlobalKey<InputAbsensiTabState>();

  @override
  void initState() {
    super.initState();
    final ds = AbsenLocalDatasourceImpl();
    final repo = AbsenRepositoryImpl(localDatasource: ds);
    _absenBloc = AbsenBloc(
      getRiwayatAbsensiUsecase: GetRiwayatAbsensiUsecase(repo),
      getStudentAttendanceUsecase: GetStudentAttendanceUsecase(repo),
      getLeaveRequestsUsecase: GetLeaveRequestsUsecase(repo),
      updateLeaveRequestStatusUsecase: UpdateLeaveRequestStatusUsecase(repo),
    );
  }

  @override
  void dispose() {
    _absenBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Jika sudah diisi (isReadOnly = true), tampilkan detail absensi
    if (widget.isReadOnly) {
      return DetailAbsensiPage(
        className: widget.className,
        subject: widget.subject,
        time: widget.time,
        jamKe: widget.jamKe,
        isReadOnly: true,
      );
    }

    return BlocProvider.value(
      value: _absenBloc,
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: CustomAppBar(
          title: 'Isi Absensi',
          showBackButton: true,
          onBackTap: () {
            _inputAbsensiTabKey.currentState?.handleBack();
          },
        ),
        body: InputAbsensiTab(
          key: _inputAbsensiTabKey,
          prefilledKelas: widget.className,
          prefilledSubject: widget.subject,
        ),
      ),
    );
  }
}