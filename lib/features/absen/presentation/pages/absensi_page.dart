import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';
import 'input_absensi_tab.dart';
import 'riwayat_absensi_tab.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/absen_bloc.dart';
import '../../data/datasources/absen_local_datasource.dart';
import '../../data/repositories/absen_repository_impl.dart';
import '../../domain/usecases/get_riwayat_absensi_usecase.dart';
import '../../domain/usecases/get_student_attendance_usecase.dart';
import '../../domain/usecases/get_leave_requests_usecase.dart';
import '../../domain/usecases/update_leave_request_status_usecase.dart';

class AbsensiPage extends StatelessWidget {
  const AbsensiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _AbsensiPageContent();
  }
}

class _AbsensiPageContent extends StatefulWidget {
  const _AbsensiPageContent({Key? key}) : super(key: key);

  @override
  State<_AbsensiPageContent> createState() => _AbsensiPageContentState();
}

class _AbsensiPageContentState extends State<_AbsensiPageContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late AbsenBloc _inputAbsenBloc;
  late AbsenBloc _riwayatAbsenBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    final ds = AbsenLocalDatasourceImpl();
    final repo = AbsenRepositoryImpl(localDatasource: ds);

    _inputAbsenBloc = AbsenBloc(
      getRiwayatAbsensiUsecase: GetRiwayatAbsensiUsecase(repo),
      getStudentAttendanceUsecase: GetStudentAttendanceUsecase(repo),
      getLeaveRequestsUsecase: GetLeaveRequestsUsecase(repo),
      updateLeaveRequestStatusUsecase: UpdateLeaveRequestStatusUsecase(repo),
    );

    _riwayatAbsenBloc = AbsenBloc(
      getRiwayatAbsensiUsecase: GetRiwayatAbsensiUsecase(repo),
      getStudentAttendanceUsecase: GetStudentAttendanceUsecase(repo),
      getLeaveRequestsUsecase: GetLeaveRequestsUsecase(repo),
      updateLeaveRequestStatusUsecase: UpdateLeaveRequestStatusUsecase(repo),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _inputAbsenBloc.close();
    _riwayatAbsenBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Absensi'),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primaryBlue,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.secondaryOrange,
              indicatorWeight: 3,
              labelStyle: AppTextStyles.cardTitle.copyWith(fontSize: 13),
              unselectedLabelStyle: AppTextStyles.cardSubtitle.copyWith(
                fontSize: 13,
              ),
              tabs: const [
                Tab(text: 'Input Absensi'),
                Tab(text: 'Riwayat'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                BlocProvider<AbsenBloc>.value(
                  value: _inputAbsenBloc,
                  child: const InputAbsensiTab(),
                ),
                BlocProvider<AbsenBloc>.value(
                  value: _riwayatAbsenBloc,
                  child: const RiwayatAbsensiTab(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
