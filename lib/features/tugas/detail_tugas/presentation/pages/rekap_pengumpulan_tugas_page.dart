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
  final int lampiranCount;
  final List<String> lampiranNames;

  const RekapPengumpulanTugasPage({
    super.key,
    required this.tugasId,
    required this.tugasTitle,
    required this.tugasSubtitle,
    required this.lampiranCount,
    this.lampiranNames = const [],
  });

  @override
  Widget build(BuildContext context) {
    // Inisialisasi dependensi secara lokal
    final datasource = RekapPengumpulanLocalDatasourceImpl();
    final repository = RekapPengumpulanRepositoryImpl(
      localDatasource: datasource,
    );

    return BlocProvider(
      create: (context) => RekapPengumpulanBloc(
        getAssignmentRecap: GetAssignmentRecapUsecase(repository),
      )..add(LoadRekapPengumpulanEvent(tugasId)),
      child: RekapPengumpulanTugasView(
        tugasTitle: tugasTitle,
        tugasSubtitle: tugasSubtitle,
        lampiranCount: lampiranCount,
        lampiranNames: lampiranNames,
      ),
    );
  }
}

/// View utama yang merender UI berdasarkan state Bloc
class RekapPengumpulanTugasView extends StatelessWidget {
  final String tugasTitle;
  final String tugasSubtitle;
  final int lampiranCount;
  final List<String> lampiranNames;

  const RekapPengumpulanTugasView({
    super.key,
    required this.tugasTitle,
    required this.tugasSubtitle,
    required this.lampiranCount,
    this.lampiranNames = const [],
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
    BuildContext context,
    RekapPengumpulanLoaded state,
  ) {
    final recap = state.recap;
    final submissions = state.filteredSubmissions;
    final onTimeSubmissionCount = recap.submissions
        .where((submission) => submission.isSubmitted && !submission.isLate)
        .length;
    final lateSubmissionCount = recap.lateStudentsCount;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<RekapPengumpulanBloc>().add(
          LoadRekapPengumpulanEvent(recap.id),
        );
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
                TugasHeaderSection(title: tugasTitle, subtitle: tugasSubtitle),
                const SizedBox(height: 20),

                // 2. Info lampiran tugas (jika ada)
                if (lampiranCount > 0)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _LampiranInfoRow(
                      count: lampiranCount,
                      lampiranNames: lampiranNames,
                    ),
                  ),

                // 4. Kartu statistik pengumpulan
                StatistikPengumpulanCard(
                  totalStudents: recap.totalStudents,
                  submittedCount: recap.submittedCount,
                  pendingCount: recap.pendingCount,
                  completionPercentage: recap.completionPercentage,
                  lateStudentsCount: recap.lateStudentsCount,
                ),

                // 3. Tombol unduh semua
                DownloadSemuaButton(
                  onPressed: () {
                    context.read<RekapPengumpulanBloc>().add(
                      DownloadAllEvent(),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Mengunduh semua file tugas...'),
                        backgroundColor: AppColors.primaryBlue,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // 4. Filter tab
                FilterTabWidget(
                  submittedCount: onTimeSubmissionCount,
                  lateCount: lateSubmissionCount,
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
                      final isPending =
                          state.selectedFilter == RekapSubmissionFilter.pending;
                      return SiswaPengumpulanTile(
                        submission: submissions[index],
                        onTap: isPending
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPenilaianSiswaPage(
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

class _LampiranInfoRow extends StatelessWidget {
  final int count;
  final List<String> lampiranNames;

  const _LampiranInfoRow({required this.count, this.lampiranNames = const []});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16, // jarak kanan kiri
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.secondaryOrange,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondaryOrange.withOpacity(0.18),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header atas
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.attach_file_rounded,
                    color: AppColors.secondaryOrange,
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    ' $count Lampiran',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            if (lampiranNames.isNotEmpty) ...[
              const SizedBox(height: 16),

              ...lampiranNames.map(
                (name) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.insert_drive_file_outlined,
                            color: AppColors.secondaryOrange,
                          ),
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 2),

                              const Text(
                                'PDF File',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),

                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.secondaryOrange,
                            side: const BorderSide(
                              color: AppColors.secondaryOrange,
                              width: 1,
                            ),

                            minimumSize: const Size(58, 28),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 0,
                            ),

                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Preview',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
