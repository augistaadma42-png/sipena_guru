import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import '../bloc/laporan_bloc.dart';
import '../bloc/laporan_event.dart';
import '../bloc/laporan_state.dart';
import '../widgets/laporan_app_bar.dart';
import '../widgets/kelas_info_card.dart';
import '../widgets/mata_pelajaran_card.dart';
import '../widgets/daftar_nilai_card.dart';
import '../widgets/validation_info_widget.dart';
import '../widgets/export_pdf_button.dart';

/// Halaman utama Laporan Nilai Akhir
class LaporanNilaiPage extends StatefulWidget {
  const LaporanNilaiPage({super.key});

  @override
  State<LaporanNilaiPage> createState() => _LaporanNilaiPageState();
}

class _LaporanNilaiPageState extends State<LaporanNilaiPage> {
  int _activeNavIndex = 2; // Laporan aktif

  @override
  void initState() {
    super.initState();
    // Trigger load data saat halaman pertama dibuka
    context.read<LaporanBloc>().add(const LoadLaporanEvent());
  }

  void _onNavTap(int index) {
    setState(() => _activeNavIndex = index);
    // TODO: Navigasi ke halaman lain sesuai index
  }

  void _onExportPdf() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.picture_as_pdf_rounded, color: Colors.white),
            SizedBox(width: 10),
            Text('Mengekspor laporan sebagai PDF...'),
          ],
        ),
        backgroundColor: AppColors.secondaryOrange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const LaporanAppBar(),
      body: BlocBuilder<LaporanBloc, LaporanState>(
        builder: (context, state) {
          if (state is LaporanLoading) {
            return const _LoadingView();
          }

          if (state is LaporanError) {
            return _ErrorView(
              message: state.message,
              onRetry: () => context
                  .read<LaporanBloc>()
                  .add(const LoadLaporanEvent()),
            );
          }

          if (state is LaporanLoaded) {
            return _LoadedView(
              state: state,
              onPageChanged: (page) =>
                  context.read<LaporanBloc>().add(ChangePageEvent(page)),
              onExportPdf: _onExportPdf,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

/// View saat loading
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryBlue,
        strokeWidth: 2.5,
      ),
    );
  }
}

/// View saat error
class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 56,
              color: AppColors.disabledGrey,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
              ),
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}

/// View utama saat data berhasil dimuat
class _LoadedView extends StatelessWidget {
  final LaporanLoaded state;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onExportPdf;

  const _LoadedView({
    required this.state,
    required this.onPageChanged,
    required this.onExportPdf,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Kelas Terpilih
          KelasInfoCard(
            labelKelas: 'KELAS TERPILIH',
            namaKelas: state.namaKelas,
          ),
          const SizedBox(height: 12),

          // Card Mata Pelajaran
          MataPelajaranCard(
            labelMapel: 'MATA PELAJARAN',
            namaMapel: state.namaMapel,
          ),
          const SizedBox(height: 16),

          // Card Daftar Nilai (tabel + pagination)
          DaftarNilaiCard(
            students: state.students,
            currentPage: state.currentPage,
            totalPages: state.totalPages,
            totalSiswa: state.totalSiswa,
            perPage: state.perPage,
            onPageChanged: onPageChanged,
          ),
          const SizedBox(height: 16),

          // Info Validasi
          const ValidationInfoWidget(
            validationText:
                'Laporan ini telah divalidasi oleh sistem pada 27 Okt 2023.',
          ),
          const SizedBox(height: 16),

          // Tombol Export PDF
          ExportPdfButton(onPressed: onExportPdf),
        ],
      ),
    );
  }
}