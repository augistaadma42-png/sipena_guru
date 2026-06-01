import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/widgets/dropdown_chip.dart';
import '../../../../../../core/widgets/confirmation_dialog.dart';
import '../bloc/tugas_form_controller.dart';
import '../widgets/tugas_header.dart';
import '../widgets/input_judul.dart';
import '../widgets/deskripsi_input.dart';
import '../widgets/tanggal_picker.dart';
import '../widgets/lampiran_section.dart';
import '../../../dashboard_tugas/domain/entities/tugas_entity.dart';
import '../../data/repositories/tugas_repository_impl.dart';
import '../../domain/usecases/create_tugas.dart';
import '../../../dashboard_tugas/data/datasources/dashboard_tugas_local_datasource.dart';

class BuatTugasPage extends StatefulWidget {
  final String namaKelas;
  final String namaMapel;
  final TugasEntity? tugasToEdit;

  const BuatTugasPage({
    super.key,
    required this.namaKelas,
    required this.namaMapel,
    this.tugasToEdit,
  });

  @override
  State<BuatTugasPage> createState() => _BuatTugasPageState();
}

class _BuatTugasPageState extends State<BuatTugasPage> {
  late final TugasFormController _controller;
  bool _showErrors = false;

  @override
  void initState() {
    super.initState();
    _controller = TugasFormController();

    // Prefill metadata in the background
    _controller.kelas.value = widget.namaKelas;
    _controller.mapel.value = widget.namaMapel;
    _controller.jenisNilai.value = 'Tugas';
    _controller.siswa.value = 'Semua pelajar';

    if (widget.tugasToEdit != null) {
      final edit = widget.tugasToEdit!;
      _controller.judulController.text = edit.title;
      _controller.deskripsiController.text = edit.subtitle;
      _controller.selectedMateri.value = edit.judulMateri ?? 'Pilih Materi';
      _controller.lampiranNames.value = edit.lampiranNames;
    }

    _controller.judulController.addListener(() => setState(() {}));
    _controller.deskripsiController.addListener(() => setState(() {}));
    _controller.selectedMateri.addListener(() => setState(() {}));
    _controller.tenggat.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> getDropdownMateriOptions() {
    final list = ['Pilih Materi'];
    final matching = DashboardTugasLocalDatasourceImpl.getMateriListSync()
        .where((m) => m.kelas == widget.namaKelas && m.category == widget.namaMapel)
        .map((m) => m.title)
        .toList();
    list.addAll(matching);
    return list;
  }

  bool get _isDirty {
    if (widget.tugasToEdit != null) {
      final edit = widget.tugasToEdit!;
      final initialJudul = edit.title.trim();
      final initialDeskripsi = edit.subtitle.trim();
      final initialMateri = (edit.judulMateri ?? 'Pilih Materi').trim();
      final initialLampiran = edit.lampiranNames;

      final currentJudul = _controller.judulController.text.trim();
      final currentDeskripsi = _controller.deskripsiController.text.trim();
      final currentMateri = _controller.selectedMateri.value.trim();
      final currentLampiran = _controller.lampiranNames.value;

      return currentJudul != initialJudul ||
          currentDeskripsi != initialDeskripsi ||
          currentMateri != initialMateri ||
          !listEquals(currentLampiran, initialLampiran);
    } else {
      return _controller.judulController.text.trim().isNotEmpty ||
          _controller.deskripsiController.text.trim().isNotEmpty ||
          _controller.selectedMateri.value != 'Pilih Materi' ||
          _controller.lampiranNames.value.isNotEmpty ||
          _controller.tenggat.value != null;
    }
  }

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
    final isJudulValid = _controller.judulController.text.trim().isNotEmpty;
    final isMateriValid = _controller.selectedMateri.value != 'Pilih Materi';
    final isDeskripsiValid = _controller.deskripsiController.text.trim().isNotEmpty;
    final isTenggatValid = _controller.tenggat.value != null;

    if (!isJudulValid || !isMateriValid || !isDeskripsiValid || !isTenggatValid) {
      setState(() {
        _showErrors = true;
      });

      final List<String> missingFields = [];
      if (!isJudulValid) missingFields.add('Judul Tugas');
      if (!isMateriValid) missingFields.add('Materi Terkait');
      if (!isDeskripsiValid) missingFields.add('Deskripsi');
      if (!isTenggatValid) missingFields.add('Tenggat');

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

    final String title = widget.tugasToEdit != null ? 'Simpan Perubahan Tugas?' : 'Terbitkan Tugas?';
    final String message = widget.tugasToEdit != null 
        ? 'Perubahan tugas akan diterapkan pada data yang ada.'
        : 'Tugas akan tersedia dan dapat dilihat oleh siswa.';

    final shouldSave = await showConfirmationDialog(
      context: context,
      title: title,
      message: message,
      cancelText: 'Batal',
      confirmText: 'Simpan',
    );
    if (shouldSave == true && mounted) {
      _simpanTugas();
    }
  }

  void _simpanTugas() {
    final tugas = _controller.buildEntity();
    final repo = TugasRepositoryImpl();
    final createTugas = CreateTugas(repo);
    createTugas(tugas);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.tugasToEdit != null
              ? 'Tugas "${tugas.judul}" berhasil diperbarui!'
              : 'Tugas "${tugas.judul}" berhasil disimpan!',
        ),
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
                title: widget.tugasToEdit != null ? 'Edit tugas' : 'Buat tugas',
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
                      controller: _controller.judulController,
                      label: 'Judul Tugas',
                      hintText: 'Masukkan judul tugas...',
                      enabled: true,
                      isRequired: true,
                      hasError: _showErrors && _controller.judulController.text.trim().isEmpty,
                      errorText: '* Judul tugas wajib diisi!',
                    ),
                    const SizedBox(height: 16),

                    _buildLabel('Materi Terkait'),
                    const SizedBox(height: 6),
                    ValueListenableBuilder<String>(
                      valueListenable: _controller.selectedMateri,
                      builder: (context, val, _) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownChip(
                            value: val,
                            options: getDropdownMateriOptions(),
                            onChanged: (v) => _controller.selectedMateri.value = v!,
                            disabled: false,
                            hasError: _showErrors && val == 'Pilih Materi',
                          ),
                          if (_showErrors && val == 'Pilih Materi') ...[
                            const SizedBox(height: 6),
                            Text(
                              '* Silakan pilih materi terkait!',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.red.shade400,
                              ),
                            ),
                          ],
                        ],
                      ),
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

                    TanggalPicker(
                      tenggatNotifier: _controller.tenggat,
                      enabled: true,
                      hasError: _showErrors && _controller.tenggat.value == null,
                      errorText: '* Tenggat wajib dipilih!',
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