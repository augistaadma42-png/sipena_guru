import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/dashboard_tugas_local_datasource.dart';
import '../../data/repositories/dashboard_tugas_repository_impl.dart';
import '../../domain/usecases/get_daftar_tugas_usecase.dart';
import '../../domain/usecases/get_materi_terbaru_usecase.dart';
import '../bloc/dashboard_tugas_bloc.dart';
import '../bloc/dashboard_tugas_event.dart';
import '../bloc/dashboard_tugas_state.dart';
import '../widgets/dashboard_tugas_app_bar.dart';
import '../widgets/materi_terbaru_section.dart';
import '../widgets/daftar_tugas_section.dart';
import '../widgets/floating_add_tugas_button.dart';
import '../widgets/empty_tugas_widget.dart';
import '../widgets/loading_dashboard_widget.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import '../../../buat_tugas/presentation/pages/buat_tugas_page.dart';
import '../widgets/daftar_siswa_tab.dart';

class DashboardTugasPage extends StatelessWidget {
  // [CHANGE 1] Terima namaKelas dari DaftarKelasPage
  final String namaKelas;

  const DashboardTugasPage({
    super.key,
    this.namaKelas = '',
  });

  @override
  Widget build(BuildContext context) {
    final datasource = DashboardTugasLocalDatasourceImpl();
    final repository = DashboardTugasRepositoryImpl(
      localDatasource: datasource,
    );

    return BlocProvider(
      create: (context) => DashboardTugasBloc(
        getMateriTerbaru: GetMateriTerbaruUsecase(repository),
        getDaftarTugas: GetDaftarTugasUsecase(repository),
      )..add(LoadDashboardTugasEvent()),
      child: DashboardTugasView(namaKelas: namaKelas),
    );
  }
}

class DashboardTugasView extends StatefulWidget {
  // [CHANGE 1] Teruskan namaKelas ke AppBar
  final String namaKelas;

  const DashboardTugasView({
    super.key,
    required this.namaKelas,
  });

  @override
  State<DashboardTugasView> createState() => _DashboardTugasViewState();
}

class _DashboardTugasViewState extends State<DashboardTugasView> {
  String? _selectedMonth;

  String _extractMonthFromDeadline(String deadline) {
    final trimmed = deadline.trim();
    if (trimmed.isEmpty) return '';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    return parts.last;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        // [CHANGE 1] Pass namaKelas ke AppBar
        appBar: DashboardTugasAppBar(
          namaKelas: widget.namaKelas,
          bottom: const TabBar(
            indicatorColor: AppColors.primaryBlue,
            labelColor: AppColors.primaryBlue,
            unselectedLabelColor: AppColors.textSecondary,
            tabs: [
              Tab(text: 'Tugas & Nilai'),
              Tab(text: 'Daftar Siswa'),
            ],
          ),
        ),
        body: TabBarView(
          children: [_buildTugasTab(context), const DaftarSiswaTab()],
        ),
        floatingActionButton: FloatingAddTugasButton(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const BuatTugasPage()),
            );
            if (context.mounted) {
              context.read<DashboardTugasBloc>().add(RefreshDashboardEvent());
            }
          },
        ),
      ),
    );
  }

  Widget _buildTugasTab(BuildContext context) {
    return BlocBuilder<DashboardTugasBloc, DashboardTugasState>(
      builder: (context, state) {
        debugPrint('[DashboardTugasView] Current State: $state');

        if (state is DashboardTugasInitial || state is DashboardTugasLoading) {
          return Container(
            color: AppColors.backgroundLight,
            child: const LoadingDashboardWidget(),
          );
        }

        if (state is DashboardTugasEmpty) {
          return const EmptyTugasWidget();
        }

        if (state is DashboardTugasError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        if (state is DashboardTugasLoaded) {
              (_selectedMonth == null || _selectedMonth == 'Semua')
              ? state.tugasList
              : state.tugasList
                    .where(
                      (t) =>
                          _extractMonthFromDeadline(t.deadline) ==
                          _selectedMonth,
                    )
                    .toList();

          return RefreshIndicator(
            onRefresh: () async {
              context.read<DashboardTugasBloc>().add(RefreshDashboardEvent());
            },
            color: AppColors.secondaryOrange,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  MateriTerbaruSection(materiList: state.materiList),
                  const SizedBox(height: 24),
                  DaftarTugasSection(tugasList: state.tugasList),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
