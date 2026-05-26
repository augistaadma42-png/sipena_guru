import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import '../widgets/common_widgets.dart';
import '../widgets/menu_card.dart';
import '../widgets/stats_card.dart';

import 'package:fitur_guru/features/laporan/nilai/data/datasources/laporan_local_datasource.dart';
import 'package:fitur_guru/features/laporan/nilai/data/repositories/laporan_repository_impl.dart';
import 'package:fitur_guru/features/laporan/nilai/domain/usecases/get_student_nilai_usecase.dart';
import 'package:fitur_guru/features/laporan/nilai/presentation/bloc/laporan_bloc.dart';
import 'package:fitur_guru/features/laporan/nilai/presentation/pages/laporan_nilai_page.dart';

import 'package:fitur_guru/features/laporan/absensi/data/datasources/laporan_absensi_local_datasource.dart';
import 'package:fitur_guru/features/laporan/absensi/data/repositories/laporan_absensi_repository_impl.dart';
import 'package:fitur_guru/features/laporan/absensi/domain/usecases/get_student_attend_usecase.dart';
import 'package:fitur_guru/features/laporan/absensi/presentation/bloc/laporan_absensi_bloc.dart';
import 'package:fitur_guru/features/laporan/absensi/presentation/pages/laporan_absensi_bulanan.dart';

import 'package:fitur_guru/features/laporan/laporan_tugas/presentation/pages/laporan_tugas_page.dart';

/// DashboardPage - Tampilan PERSIS seperti gambar yang diberikan
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Background sangat terang
      appBar: const DashboardAppBar(),
      body: RefreshIndicator(
        color: AppColors.secondaryOrange,

        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title: Report Hub
              Text(
                'Laporan Tugas',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                'Pantau dan unduh laporan capaian akademik siswa Anda.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              // Filter Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.borderLight.withValues(alpha: 0.5),
                  ),
                ),
                child: const Column(
                  children: [
                    FilterDropdown(
                      label: 'Pilih Kelas',
                      value: 'XII IPA 1',
                      items: ['XII IPA 1', 'XII IPA 2', 'XI IPA 1'],
                    ),
                    SizedBox(height: 16),
                    FilterDropdown(
                      label: 'Pilih Mata Pelajaran',
                      value: 'Matematika Wajib',
                      items: ['Matematika Wajib', 'Matematika Peminatan'],
                    ),
                    SizedBox(height: 16),
                    FilterDropdown(
                      label: 'Pilih Bulan',
                      value: 'Mei 2026',
                      items: ['Maret 2026', 'April 2026', 'Mei 2026'],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Report List (Vertical Cards)
              ReportList(
                items: [
                  {
                    'title': 'Laporan Nilai Akhir',
                    'description':
                        'Ringkasan akumulasi nilai formatif dan sumatif siswa dalam satu periode semester.',
                    'icon': Icons.bar_chart,
                    'accentColor': AppColors.primaryBlue,
                    'isNew': true,
                  },
                  {
                    'title': 'Laporan Absensi Bulanan',
                    'description':
                        'Persentase kehadiran dan rekapitulasi ketidakhadiran siswa per bulan.',
                    'icon': Icons.calendar_today,
                    'accentColor': AppColors.secondaryOrange,
                  },
                  {
                    'title': 'Laporan Tugas',
                    'description':
                        'Analisis tugas, status pengumpulan, dan distribusi nilai siswa.',
                    'icon': Icons.analytics_outlined,
                    'accentColor': const Color(0xFF3B82F6),
                  },
                ],
                onMenuTap: (index) {
                  if (index == 0) {
                    // Navigasi ke Laporan Nilai Akhir
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) {
                            final dataSource = LaporanLocalDatasourceImpl();
                            final repository = LaporanRepositoryImpl(
                              localDatasource: dataSource,
                            );
                            return LaporanBloc(
                              getStudentNilaiUsecase: GetStudentNilaiUsecase(
                                repository,
                              ),
                              getTotalSiswaUsecase: GetTotalSiswaUsecase(
                                repository,
                              ),
                            );
                          },
                          child: const LaporanNilaiPage(),
                        ),
                      ),
                    );
                  } else if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) {
                            final ds = LaporanAbsensiLocalDatasourceImpl();
                            final repo = LaporanAbsensiRepositoryImpl(
                              localDatasource: ds,
                            );
                            return LaporanAbsensiBloc(
                              getStudentAttendanceUsecase:
                                  GetStudentAttendanceUsecase(repo),
                              getTotalStudentsUsecase: GetTotalStudentsUsecase(
                                repo,
                              ),
                            );
                          },
                          child: const LaporanAbsensiBulananPage(),
                        ),
                      ),
                    );
                  } else if (index == 2) {
                    // Navigasi ke Laporan Tugas (Statistik Tugas)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LaporanTugasPage(),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 24),
              // Recent Activity Section
              Text(
                'Ringkasan Aktivitas Terakhir',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 16),
              const ActivityList(
                activities: [
                  {
                    'title': 'Laporan Nilai Akhir - XII IPA 1',
                    'time': 'Diunduh 2 jam yang lalu',
                    'icon': Icons.description_outlined,
                    'iconColor': AppColors.secondaryOrange,
                    'bgColor': Color(0xFFFFF7ED),
                  },
                  {
                    'title': 'Statistik Tugas - XII IPA 2',
                    'time': 'Dilihat 5 jam yang lalu',
                    'icon': Icons.visibility_outlined,
                    'iconColor': Color(0xFF3B82F6),
                    'bgColor': Color(0xFFEFF6FF),
                  },
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
