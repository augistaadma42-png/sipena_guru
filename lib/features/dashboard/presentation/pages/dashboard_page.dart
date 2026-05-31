import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';
import '../widgets/attendance_card.dart';
import '../widgets/task_summary_card.dart';
import '../widgets/aktivitas_terbaru_widget.dart';
import '../../../tugas/daftar_kelas/presentation/pages/daftar_kelas_page.dart'; // [CHANGE 3]
import '../../../laporan/laporan_tugas/presentation/pages/laporan_tugas_page.dart'; // [CHANGE 3]
import 'aktivitas_semua_page.dart';
import 'package:intl/intl.dart';
import '../../../absen/presentation/pages/absensi_dari_jadwal_page.dart';
import '../../../absen/presentation/pages/detail_absensi_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../../domain/entities/attendance_overview_entity.dart';

import '../../../jurnal/presentation/bloc/jurnal_bloc.dart';
import '../../../jurnal/presentation/bloc/jurnal_event.dart';


class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _DashboardPageContent();
  }
}

class _DashboardPageContent extends StatefulWidget {
  const _DashboardPageContent({Key? key}) : super(key: key);

  @override
  State<_DashboardPageContent> createState() => _DashboardPageContentState();
}

class _DashboardPageContentState extends State<_DashboardPageContent> {
  final ScrollController _attendanceScrollController = ScrollController();

  @override
  void dispose() {
    _attendanceScrollController.dispose();
    super.dispose();
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return 'Selamat Pagi';
    if (hour >= 12 && hour < 15) return 'Selamat Siang';
    if (hour >= 15 && hour < 18) return 'Selamat Sore';
    return 'Selamat Malam';
  }

  String getFormattedDate() {
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now());
  }

  // Tombol "Lihat" → DetailAbsensiPage (sama seperti di rekap absensi)
  void _navigateToDetailAbsensi({
    required String className,
    required String subject,
    required String time,
    required String jamKe,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailAbsensiPage(
          className: className,
          subject: subject,
          time: time,
          jamKe: jamKe,
          isReadOnly: true,
        ),
      ),
    );
  }

  // Tombol "Absen" → AbsensiDariJadwalPage (form input absensi baru)
  void _navigateToInputAbsensi({
    required String className,
    required String subject,
    required String time,
    required String jamKe,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AbsensiDariJadwalPage(
          className: className,
          subject: subject,
          time: time,
          jamKe: jamKe,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Dashboard'),
      drawer: const CustomDrawer(),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading || state is DashboardInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DashboardError) {
            return Center(child: Text(state.message));
          } else if (state is DashboardLoaded) {
            return RefreshIndicator(
              color: AppColors.secondaryOrange,

              onRefresh: () async {
                context.read<DashboardBloc>().add(LoadDashboardDataEvent());
                context.read<JurnalBloc>().add(LoadJurnalTerbaruEvent());
                await Future.delayed(const Duration(milliseconds: 500));
              },

              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),

                child: Padding(
                  padding: const EdgeInsets.all(20.0),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      // Greeting Section
                      Text(
                        '${getGreeting()},',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF002369),
                          height: 1.3,
                        ),
                      ),

                      Text(
                        'Umi Kulsum S.Pd.',
                        style: GoogleFonts.inter(
                          fontSize: 29,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF002369),
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        getFormattedDate(),
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF002369).withOpacity(0.7),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ABSENSI HARI INI
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F6F9),

                          borderRadius: BorderRadius.circular(16),

                          border: Border.all(color: AppColors.borderLight),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            // HEADER
                            Container(
                              width: double.infinity,

                              padding: const EdgeInsets.all(20),

                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.borderLight,
                                    width: 1,
                                  ),
                                ),
                              ),

                              child: Text(
                                'Absensi Hari Ini',
                                style: AppTextStyles.sectionTitle,
                              ),
                            ),

                            // LIST
                            SizedBox(
                              height: (155 * 3) + (16 * 2) + 40,
                              child: RawScrollbar(
                                controller: _attendanceScrollController,

                                thumbColor: AppColors.primaryBlue,

                                radius: const Radius.circular(8),

                                thickness: 6,

                                thumbVisibility: true,

                                child: ListView(
                                  controller: _attendanceScrollController,

                                  padding: const EdgeInsets.all(20),

                                  children: state.attendanceOverviewList.map((
                                    item,
                                  ) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 16,
                                      ),

                                      child: AttendanceCard(
                                        time: item.time,

                                        className: item.className,

                                        room: item.room,

                                        subject: item.subject,

                                        status:
                                            item.status ==
                                                AttendanceOverviewStatus.done
                                            ? AttendanceStatus.done
                                            : item.status ==
                                                  AttendanceOverviewStatus
                                                      .pending
                                            ? AttendanceStatus.pending
                                            : AttendanceStatus.locked,

                                        statusText: item.statusText,

                                        filledCount: item.filledCount,

                                        totalCount: item.totalCount,

                                        onActionTap:
                                            item.status ==
                                                AttendanceOverviewStatus.done
                                            ? () => _navigateToDetailAbsensi(
                                                className: item.className,
                                                subject: item.subject,
                                                time: item.time,
                                                jamKe: 'Jam ke-1 & 2',
                                              )
                                            : item.status ==
                                                  AttendanceOverviewStatus
                                                      .pending
                                            ? () => _navigateToInputAbsensi(
                                                className: item.className,
                                                subject: item.subject,
                                                time: item.time,
                                                jamKe: 'Jam ke-3 & 4',
                                              )
                                            : null,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Ringkasan Tugas Section
                      TaskSummarySection(
                        taskSummaryList: state.taskSummaryList,

                        onCheckNowTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DaftarKelasPage(),
                          ),
                        ),

                        onSeeAllTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LaporanTugasPage(),
                          ),
                        ),

                        onTaskTap: (task) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LaporanTugasPage(
                              initialKelas: task.kelas,
                              initialMataPelajaran: task.mataPelajaran,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Aktivitas Terbaru Section
                      AktivitasTerbaruWidget(
                        aktivitasList: state.aktivitasList,

                        onLihatSemua: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AktivitasSemua(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}