import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../detail_penilaian/presentation/pages/detail_penilaian_siswa_page.dart';
import '../../data/datasources/rekap_pengumpulan_local_datasource.dart';
import '../../data/repositories/rekap_pengumpulan_repository_impl.dart';
import '../../domain/usecases/get_assignment_recap_usecase.dart';
import '../bloc/rekap_pengumpulan_bloc.dart';
import '../bloc/rekap_pengumpulan_event.dart';
import '../bloc/rekap_pengumpulan_state.dart';
import '../widgets/rekap_pengumpulan_app_bar.dart';
import '../widgets/tugas_header_section.dart';
import '../widgets/download_semua_button.dart';
import '../widgets/statistik_pengumpulan_card.dart';
import '../widgets/filter_tab_widget.dart';
import '../widgets/search_siswa_field.dart';
import '../widgets/kumpulan_tugas_header.dart';
import '../widgets/siswa_pengumpulan_tile.dart';
import '../widgets/empty_pengumpulan_widget.dart';
import '../widgets/loading_pengumpulan_widget.dart';
import '../../../../../../core/constants/colors.dart';

/// Entry point halaman Rekap Pengumpulan Tugas
/// Menerima [tugasId], [tugasTitle], [tugasSubtitle] dari halaman sebelumnya
class RekapPengumpulanTugasPage extends StatelessWidget {
  final String tugasId;
  final String tugasTitle;
  final String tugasSubtitle;

  const RekapPengumpulanTugasPage({
    super.key,
    required this.tugasId,
    required this.tugasTitle,
    required this.tugasSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    // Inisialisasi dependensi secara lokal
    final datasource = RekapPengumpulanLocalDatasourceImpl();
    final repository =
        RekapPengumpulanRepositoryImpl(localDatasource: datasource);

    return BlocProvider(
      create: (context) => RekapPengumpulanBloc(
        getAssignmentRecap: GetAssignmentRecapUsecase(repository),
      )..add(LoadRekapPengumpulanEvent(tugasId)),
      child: RekapPengumpulanTugasView(
        tugasTitle: tugasTitle,
        tugasSubtitle: tugasSubtitle,
      ),
    );
  }
}

/// View utama yang merender UI berdasarkan state Bloc
class RekapPengumpulanTugasView extends StatelessWidget {
  final String tugasTitle;
  final String tugasSubtitle;

  const RekapPengumpulanTugasView({
    super.key,
    required this.tugasTitle,
    required this.tugasSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const RekapPengumpulanAppBar(),
      body: BlocBuilder<RekapPengumpulanBloc, RekapPengumpulanState>(
        builder: (context, state) {
          if (state is RekapPengumpulanInitial ||
              state is RekapPengumpulanLoading) {
            return const LoadingPengumpulanWidget();
          }

          if (state is RekapPengumpulanEmpty) {
            return const EmptyPengumpulanWidget();
          }

          if (state is RekapPengumpulanError) {
            return Center(
              child: Text(
                'Terjadi kesalahan: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is RekapPengumpulanLoaded) {
            return _buildLoadedContent(context, state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadedContent(
      BuildContext context, RekapPengumpulanLoaded state) {
    final recap = state.recap;
    final submissions = state.filteredSubmissions;

    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<RekapPengumpulanBloc>()
            .add(LoadRekapPengumpulanEvent(recap.id));
      },
      color: AppColors.secondaryOrange,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header judul tugas
                TugasHeaderSection(
                  title: tugasTitle,
                  subtitle: tugasSubtitle,
                ),

                // 2. Tombol unduh semua
                DownloadSemuaButton(
                  onPressed: () {
                    context
                        .read<RekapPengumpulanBloc>()
                        .add(DownloadAllEvent());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Mengunduh semua file tugas...'),
                        backgroundColor: AppColors.primaryBlue,
                      ),
                    );
                  },
                ),

                // 3. Kartu statistik pengumpulan
                StatistikPengumpulanCard(
                  totalStudents: recap.totalStudents,
                  submittedCount: recap.submittedCount,
                  pendingCount: recap.pendingCount,
                  completionPercentage: recap.completionPercentage,
                  lateStudentsCount: recap.lateStudentsCount,
                ),

                // 4. Filter tab
                FilterTabWidget(
                  submittedCount: recap.submittedCount,
                  pendingCount: recap.pendingCount,
                ),

                // 5. Search field
                const SearchSiswaField(),

                // 6. Header list
                const KumpulanTugasHeader(),

                const SizedBox(height: 12),
              ],
            ),
          ),

          // 7. List siswa atau empty state
          submissions.isEmpty
              ? const SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyPengumpulanWidget(),
                )
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  sliver: SliverList.separated(
                    itemCount: submissions.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return SiswaPengumpulanTile(
                        submission: submissions[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPenilaianSiswaPage(
                                args: DetailPenilaianArgs(
                                  siswaId: submissions[index].id,
                                  tugasId: recap.id,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
