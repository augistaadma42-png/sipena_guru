

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';
import '../widgets/attendance_card.dart';
import '../widgets/task_summary_card.dart';
import 'package:intl/intl.dart';
import '../../../absen/presentation/pages/detail_absensi_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ScrollController _attendanceScrollController = ScrollController();

  @override
  void dispose() {
    _attendanceScrollController.dispose();
    super.dispose();
  }
    String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Selamat Pagi';
    } else if (hour < 15) {
      return 'Selamat Siang';
    } else if (hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  String getFormattedDate() {
    return DateFormat(
      'EEEE, dd MMMM yyyy',
      'id_ID',
    ).format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Dashboard'),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Section
              Text(
                '${getGreeting()},',
                style: GoogleFonts.inter(
                  fontSize: 28, // Diperbesar dari 24
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF002369),
                  height: 1.2,
                ),
              ),
              Text(
                'Umi Kulsum S.pd',
                style: GoogleFonts.inter(
                  fontSize: 32, // Diperbesar dari 24 agar nama lebih menonjol
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF002369),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                 getFormattedDate(),
                style: GoogleFonts.inter(
                  fontSize: 16, // Diperbesar dari 14
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF002369).withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 24),

              // Absensi Hari Ini Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6F9), // Menggunakan warna terang yang sama dengan Jurnal Terbaru
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Absensi Hari ini',
                      style: AppTextStyles.sectionTitle,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 350,
                      child: RawScrollbar(
                        controller: _attendanceScrollController,
                        thumbColor: AppColors.primaryBlue,
                        radius: const Radius.circular(8),
                        thickness: 6,
                        thumbVisibility: true,
                        child: ListView(
                          controller: _attendanceScrollController,
                          padding: const EdgeInsets.only(right: 16),
                          children: [
                            AttendanceCard(
                              time: '10:40-12:00',
                              className: 'Kelas XI-RPL 1',
                              room: 'LAB 1',
                              subject: 'Bahasa Indonesia',
                              status: AttendanceStatus.done,
                              statusText: 'Sudah di isi',
                              filledCount: 34,
                              totalCount: 38,
                              onActionTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailAbsensiPage(
                                      className: 'Kelas XI-RPL 1',
                                      subject: 'Bahasa Indonesia',
                                      time: '10:40-12:00',
                                      jamKe: 'Jam ke-3',
                                      isReadOnly: true,
                                    ),
                                  ),
                                );
                              },
                            ),
                            AttendanceCard(
                              time: '08:40-10:00',
                              className: 'Kelas XI-PSPT 2',
                              room: 'LAB 1',
                              subject: 'Bahasa Indonesia',
                              status: AttendanceStatus.pending,
                              statusText: 'Belum di isi',
                              filledCount: 0,
                              totalCount: 34,
                              onActionTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailAbsensiPage(
                                      className: 'Kelas XI-PSPT 2',
                                      subject: 'Bahasa Indonesia',
                                      time: '08:40-10:00',
                                      jamKe: 'Jam ke-2',
                                      isReadOnly: false,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const AttendanceCard(
                              time: '12:00-13:40',
                              className: 'Kelas XI-RPL 1',
                              room: 'LAB 1',
                              subject: 'Bahasa Indonesia',
                              status: AttendanceStatus.locked,
                              statusText: 'Belum Waktunya',
                            ),
                            const AttendanceCard(
                              time: '13:40-15:00',
                              className: 'Kelas XI-RPL 1',
                              room: 'LAB 1',
                              subject: 'Bahasa Indonesia',
                              status: AttendanceStatus.locked,
                              statusText: 'Belum Waktunya',
                            ),
                            // Tambahan jadwal agar bisa discroll
                            const AttendanceCard(
                              time: '15:00-16:20',
                              className: 'Kelas X-RPL 2',
                              room: 'LAB 2',
                              subject: 'Pemrograman Web',
                              status: AttendanceStatus.locked,
                              statusText: 'Belum Waktunya',
                            ),
                            const AttendanceCard(
                              time: '16:20-17:40',
                              className: 'Kelas X-RPL 2',
                              room: 'LAB 2',
                              subject: 'Pemrograman Web',
                              status: AttendanceStatus.locked,
                              statusText: 'Belum Waktunya',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Ringkasan Tugas Section
              TaskSummarySection(
                onCheckNowTap: () => print('Periksa Sekarang tapped'),
                onSeeAllTap: () => print('Lihat Semua tapped'),
                onTaskTap: (taskName) => print('Task tapped: $taskName'),
              ),
              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.secondaryOrange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
