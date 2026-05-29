import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
import '../../../buat_tugas/presentation/pages/buat_materi_page.dart';
import '../widgets/daftar_siswa_tab.dart';

class DashboardTugasPage extends StatelessWidget {
  final String namaKelas;
  final String namaMapel;

  const DashboardTugasPage({
    super.key,
    this.namaKelas = '',
    this.namaMapel = '',
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
      child: DashboardTugasView(
        namaKelas: namaKelas,
        namaMapel: namaMapel,
      ),
    );
  }
}

class DashboardTugasView extends StatefulWidget {
  final String namaKelas;
  final String namaMapel;

  const DashboardTugasView({
    super.key,
    required this.namaKelas,
    required this.namaMapel,
  });

  @override
  State<DashboardTugasView> createState() => _DashboardTugasViewState();
}

class _DashboardTugasViewState extends State<DashboardTugasView> {
  String? _selectedMonth;

  static const List<String> _allMonths = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
  ];

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
          onPressed: () => _showAddSelectionBottomSheet(context),
        ),
      ),
    );
  }

  void _showAddSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 48,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Buat Baru',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      Navigator.of(context).pop();
                      await Navigator.of(this.context).push(
                        MaterialPageRoute(
                          builder: (context) => BuatTugasPage(
                            namaKelas: widget.namaKelas,
                            namaMapel: widget.namaMapel,
                          ),
                        ),
                      );
                      if (mounted) {
                        this.context.read<DashboardTugasBloc>().add(RefreshDashboardEvent());
                      }
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderLight),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.assignment_rounded,
                              color: AppColors.primaryBlue,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Buat Tugas',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Tugaskan latihan, kuis, atau tugas ke siswa',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      Navigator.of(context).pop();
                      await Navigator.of(this.context).push(
                        MaterialPageRoute(
                          builder: (context) => BuatMateriPage(
                            namaKelas: widget.namaKelas,
                            namaMapel: widget.namaMapel,
                          ),
                        ),
                      );
                      if (mounted) {
                        this.context.read<DashboardTugasBloc>().add(RefreshDashboardEvent());
                      }
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderLight),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryOrange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.menu_book_rounded,
                              color: AppColors.secondaryOrange,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Buat Materi',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Bagikan modul, catatan, atau modul ajar',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
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
          return EmptyTugasWidget(
            namaKelas: widget.namaKelas,
            namaMapel: widget.namaMapel,
          );
        }

        if (state is DashboardTugasError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        if (state is DashboardTugasLoaded) {
          final classFilteredTugas = state.tugasList
              .where((t) => t.kelas == widget.namaKelas && t.mapel == widget.namaMapel)
              .toList();
          final classFilteredMateri = state.materiList
              .where((m) => m.kelas == widget.namaKelas && m.category == widget.namaMapel)
              .toList();

          final filteredTugasList =
              (_selectedMonth == null || _selectedMonth == 'Semua')
              ? classFilteredTugas
              : classFilteredTugas
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
                  MateriTerbaruSection(materiList: classFilteredMateri),
                  const SizedBox(height: 24),
                  DaftarTugasSection(
                    tugasList: filteredTugasList,
                    monthOptions: _allMonths,
                    selectedMonth: _selectedMonth ?? 'Semua',
                    onMonthSelected: (value) {
                      setState(() {
                        _selectedMonth = value == 'Semua' ? null : value;
                      });
                    },
                  ),
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
