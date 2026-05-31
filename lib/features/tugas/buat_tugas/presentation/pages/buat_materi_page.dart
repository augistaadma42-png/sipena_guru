import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/widgets/confirmation_dialog.dart';
import '../bloc/tugas_form_controller.dart';
import '../widgets/tugas_header.dart';
import '../widgets/input_judul.dart';
import '../widgets/deskripsi_input.dart';
import '../widgets/lampiran_section.dart';
import '../../data/repositories/tugas_repository_impl.dart';
import '../../domain/usecases/create_tugas.dart';

class BuatMateriPage extends StatefulWidget {
  final String namaKelas;
  final String namaMapel;

  const BuatMateriPage({
    super.key,
    required this.namaKelas,
    required this.namaMapel,
  });

  @override
  State<BuatMateriPage> createState() => _BuatMateriPageState();
}

class _BuatMateriPageState extends State<BuatMateriPage> {
  late final TugasFormController _controller;
  bool _showErrors = false;

  @override
  void initState() {
    super.initState();
    _controller = TugasFormController();

    // Prefill metadata in the background
    _controller.kelas.value = widget.namaKelas;
    _controller.mapel.value = widget.namaMapel;
    _controller.jenisNilai.value = 'Materi';

    _controller.judulMateriController.addListener(() => setState(() {}));
    _controller.deskripsiController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isDirty =>
      _controller.judulMateriController.text.trim().isNotEmpty ||
      _controller.deskripsiController.text.trim().isNotEmpty ||
      _controller.lampiranNames.value.isNotEmpty;

  Future<void> _handleBack() async {
    if (_isDirty) {
      final shouldPop = await showConfirmationDialog(
        context: context,
        title: 'Batalkan Perubahan?',
        message: 'Perubahan yang belum disimpan akan hilang. Apakah Anda yakin ingin kembali?',
        cancelText: 'Tetap di Halaman',
        confirmText: 'Kembali',
        isDestructive: true,
      );
      if (shouldPop == true && mounted) {
        Navigator.of(context).pop();
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> _handleSave() async {
    final isJudulValid = _controller.judulMateriController.text.trim().isNotEmpty;
    final isDeskripsiValid = _controller.deskripsiController.text.trim().isNotEmpty;

    if (!isJudulValid || !isDeskripsiValid) {
      setState(() {
        _showErrors = true;
      });

      final List<String> missingFields = [];
      if (!isJudulValid) missingFields.add('Judul Materi');
      if (!isDeskripsiValid) missingFields.add('Deskripsi');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan! Field berikut wajib diisi: ${missingFields.join(", ")}'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    final shouldSave = await showConfirmationDialog(
      context: context,
      title: 'Publikasikan Materi?',
      message: 'Materi akan ditambahkan ke daftar pembelajaran.',
      cancelText: 'Batal',
      confirmText: 'Simpan',
    );
    if (shouldSave == true && mounted) {
      _simpanMateri();
    }
  }

  void _simpanMateri() {
    final tugas = _controller.buildEntity();
    final repo = TugasRepositoryImpl();
    final createTugas = CreateTugas(repo);
    createTugas(tugas);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Materi "${tugas.judul}" berhasil disimpan!'),
        backgroundColor: AppColors.successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isDirty,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _handleBack();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(
          child: Column(
            children: [
              TugasHeader(
                title: 'Buat materi',
                onClose: _handleBack,
                onSimpan: _handleSave,
              ),
              Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputJudul(
                      controller: _controller.judulMateriController,
                      label: 'Judul Materi',
                      hintText: 'Masukkan judul materi...',
                      enabled: true,
                      isRequired: true,
                      hasError: _showErrors && _controller.judulMateriController.text.trim().isEmpty,
                      errorText: '* Judul materi wajib diisi!',
                    ),
                    const SizedBox(height: 16),

                    _buildLabel('Deskripsi'),
                    const SizedBox(height: 6),
                    DeskripsiInput(
                      controller: _controller.deskripsiController,
                      hasError: _showErrors && _controller.deskripsiController.text.trim().isEmpty,
                      errorText: '* Deskripsi wajib diisi!',
                    ),
                    const SizedBox(height: 16),

                    LampiranSection(
                      lampiranNamesNotifier: _controller.lampiranNames,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
    );
  }
}
