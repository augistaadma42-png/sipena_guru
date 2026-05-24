import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/widgets/custom_drawer.dart';

import '../bloc/laporan_absensi_bloc.dart';
import '../bloc/laporan_absensi_event.dart';
import '../bloc/laporan_absensi_state.dart';
import '../widgets/absensi_legend_widgets.dart';
import '../widgets/absensi_table_card.dart';
import '../widgets/attend_summary_card.dart';
import '../widgets/empry_absensi_widgets.dart';
import '../widgets/export_pdf_button.dart';
import '../widgets/laporan_absensi_app_bar.dart';
import '../widgets/periode_absensi_card.dart';

class LaporanAbsensiBulananPage extends StatefulWidget {
  const LaporanAbsensiBulananPage({super.key});

  @override
  State<LaporanAbsensiBulananPage> createState() =>
      _LaporanAbsensiBulananPageState();
}

class _LaporanAbsensiBulananPageState extends State<LaporanAbsensiBulananPage> {
  @override
  void initState() {
    super.initState();
    context.read<LaporanAbsensiBloc>().add(const LoadAttendanceEvent());
  }

  void _showExportSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.picture_as_pdf_rounded, color: Colors.white),
            SizedBox(width: 8),
            Text('Laporan absensi berhasil disimpan (dummy).'),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.secondaryOrange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _onChangeMonthPressed(String currentMonthKey) {
    final isOctober = currentMonthKey == '2023-10';
    final nextKey = isOctober ? '2023-11' : '2023-10';
    final nextLabel = isOctober ? 'November 2023' : 'Oktober 2023';

    context.read<LaporanAbsensiBloc>().add(
          ChangeMonthEvent(monthKey: nextKey, monthLabel: nextLabel),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const LaporanAbsensiAppBar(),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: BlocBuilder<LaporanAbsensiBloc, LaporanAbsensiState>(
          builder: (context, state) {
            if (state is LaporanAbsensiLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryBlue,
                ),
              );
            }

            if (state is LaporanAbsensiError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (state is LaporanAbsensiEmpty) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    PeriodeAbsensiCard(
                      monthLabel: state.monthLabel,
                      classLabel: 'Kelas XII - IPA 1',
                      waliKelas: 'Bp. Raharjo',
                      onTapChangeMonth: () => context.read<LaporanAbsensiBloc>().add(
                            const ChangeMonthEvent(
                              monthKey: '2023-10',
                              monthLabel: 'Oktober 2023',
                            ),
                          ),
                    ),
                    const SizedBox(height: 16),
                    const EmptyAbsensiWidget(),
                  ],
                ),
              );
            }

            if (state is LaporanAbsensiLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PeriodeAbsensiCard(
                      monthLabel: state.monthLabel,
                      classLabel: state.classLabel,
                      waliKelas: state.homeroomTeacher,
                      onTapChangeMonth: () => _onChangeMonthPressed(state.monthKey),
                    ),
                    const SizedBox(height: 14),
                    const AbsensiLegendWidget(),
                    const SizedBox(height: 14),
                    AbsensiTableCard(students: state.students),
                    const SizedBox(height: 14),
                    AttendanceSummaryCard(
                      averageAttendance: '${state.averageHadirPercent.round()}%',
                      totalAlfa: state.totalAlfa.toString(),
                    ),
                    const SizedBox(height: 22),
                    Align(
                      alignment: Alignment.center,
                      child: ExportPdfButton(
                        onPressed: () {
                          context
                              .read<LaporanAbsensiBloc>()
                              .add(const ExportPdfEvent());
                          _showExportSnackbar();
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}