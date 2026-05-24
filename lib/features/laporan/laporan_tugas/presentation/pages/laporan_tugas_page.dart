import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/colors.dart';
import '../../data/datasources/laporan_tugas_local_datasource.dart';
import '../../data/repositories/laporan_tugas_repository_impl.dart';
import '../../domain/usecases/get_assignment_report_usecase.dart';
import '../bloc/laporan_tugas_bloc.dart';
import '../bloc/laporan_tugas_event.dart';
import '../bloc/laporan_tugas_state.dart';
import '../widgets/laporan_tugas_app_bar.dart';
import '../widgets/tugas_card.dart';
import '../widgets/monthly_summary_card.dart';
import '../widgets/motivational_banner_card.dart';
import '../widgets/empty_tugas_widget.dart';
import '../widgets/loading_tugas_widget.dart';

/// Halaman utama Laporan Tugas — entry point fitur
class LaporanTugasPage extends StatefulWidget {
  const LaporanTugasPage({super.key});

  @override
  State<LaporanTugasPage> createState() => _LaporanTugasPageState();
}

class _LaporanTugasPageState extends State<LaporanTugasPage> {
  /// BLoC di-provide secara lokal (no global di/provider)
  late final LaporanTugasBloc _bloc;

  
  @override
  void initState() {
    super.initState();
    // Wiring dependency secara manual (bisa diganti dengan get_it / injectable)
    _bloc = LaporanTugasBloc(
      getAssignmentReportUsecase: GetAssignmentReportUsecase(
        LaporanTugasRepositoryImpl(
          localDatasource: LaporanTugasLocalDatasource(),
        ),
      ),
    )..add(const LoadAssignmentReportEvent(
        bulan: LaporanTugasBloc.defaultBulan,
        kelas: LaporanTugasBloc.defaultKelas,
        mataPelajaran: LaporanTugasBloc.defaultMapel,
      ));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  /// Menampilkan snackbar konfirmasi unduh rekap
  void _onUnduhRekap(BuildContext context) {
    _bloc.add(const DownloadRecapEvent());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.download_done_rounded, color: Colors.white, size: 18),
            SizedBox(width: 10),
            Text(
              'Rekap berhasil diunduh!',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LaporanTugasBloc>.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: const LaporanTugasAppBar(),
        body: SafeArea(
          top: false,
          child: BlocBuilder<LaporanTugasBloc, LaporanTugasState>(
            builder: (context, state) {
              return _buildBody(context, state);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, LaporanTugasState state) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        
        // ── Konten utama sesuai state ──
        if (state is LaporanTugasLoading)
          const SliverToBoxAdapter(child: LoadingTugasWidget()),

        if (state is LaporanTugasEmpty)
          const SliverToBoxAdapter(child: EmptyTugasWidget()),

        if (state is LaporanTugasError)
          SliverToBoxAdapter(
            child: EmptyTugasWidget(message: state.message),
          ),

        if (state is LaporanTugasLoaded) ...[
          // ── Label "Daftar Tugas" ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Row(
                children: [
                  Text(
                    'Daftar Tugas',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryBlue,
                          fontSize: 16,
                        ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.lightBlueBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${state.assignments.length} Tugas',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── ListView tugas dengan separator ──
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final assignment = state.assignments[index];
                final isExpanded =
                    state.expandedIds.contains(assignment.id);
                return TugasCard(
                  assignment: assignment,
                  isExpanded: isExpanded,
                );
              },
              childCount: state.assignments.length,
            ),
          ),

          // ── Monthly Summary Card ──
          SliverToBoxAdapter(
            child: MonthlySummaryCard(
              totalTugas: 12,
              belumSelesai: 7,
              completionPercentage: 0.75,
              onUnduhRekap: () => _onUnduhRekap(context),
            ),
          ),
        ],

        // ── Motivational Banner (selalu tampil) ──
        if (state is! LaporanTugasLoading)
          const SliverToBoxAdapter(
            child: MotivationalBannerCard(),
          ),

        // ── Bottom padding ──
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
      ],
    );
  }
}
