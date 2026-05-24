import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../bloc/tugas_form_controller.dart';
import '../widgets/tugas_header.dart';
import '../../../../../../core/widgets/dropdown_chip.dart';
import '../widgets/input_judul.dart';
import '../widgets/deskripsi_input.dart';
import '../widgets/tanggal_picker.dart';
import '../widgets/lampiran_section.dart';
import '../widgets/engagement_card.dart';
import '../../../dashboard_tugas/domain/entities/tugas_entity.dart';
import '../../data/repositories/tugas_repository_impl.dart';
import '../../domain/usecases/create_tugas.dart';

class BuatTugasPage extends StatefulWidget {
  final TugasEntity? tugasToEdit;

  const BuatTugasPage({super.key, this.tugasToEdit});

  @override
  State<BuatTugasPage> createState() => _BuatTugasPageState();
}

class _BuatTugasPageState extends State<BuatTugasPage> {
  late final TugasFormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TugasFormController();

    if (widget.tugasToEdit != null) {
      final edit = widget.tugasToEdit!;
      _controller.jenisNilai.value = edit.jenisNilai;
      _controller.mapel.value = edit.mapel;
      _controller.siswa.value = edit.siswa;
      _controller.judulController.text = edit.title;
      _controller.deskripsiController.text = edit.subtitle;
      _controller.judulMateriController.text = edit.judulMateri ?? '';
      if (TugasFormController.kelasList.contains(edit.kelas)) {
        _controller.kelas.value = edit.kelas;
      }
    }

    _controller.judulController.addListener(() => setState(() {}));
    _controller.jenisNilai.addListener(() {
      if (_controller.jenisNilai.value == 'Materi') {
        _controller.tenggat.value = null;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSimpan() {
    if (!_controller.isValid) {
      final message = _controller.jenisNilai.value == 'Materi'
          ? 'Judul materi wajib diisi!'
          : 'Judul tugas wajib diisi!';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

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
    final isMateri = _controller.jenisNilai.value == 'Materi';

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            TugasHeader(
              onClose: () => Navigator.of(context).pop(),
              onSimpan: _onSimpan,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildChipSection(),
                    const SizedBox(height: 16),

                    InputJudul(
                      controller: _controller.judulMateriController,
                      label: 'Judul Materi',
                      hintText: 'Materi tentang.....',
                      isRequired: false,
                      enabled: isMateri,
                    ),
                    const SizedBox(height: 12),

                    InputJudul(
                      controller: _controller.judulController,
                      label: 'Judul Tugas',
                      hintText: 'Judul tugas...',
                      enabled: !isMateri,
                      isRequired: !isMateri,
                    ),
                    const SizedBox(height: 12),

                    DeskripsiInput(controller: _controller.deskripsiController),
                    const SizedBox(height: 12),

                    TanggalPicker(
                      tenggatNotifier: _controller.tenggat,
                      enabled: !isMateri,
                    ),
                    const SizedBox(height: 12),

                    const LampiranSection(),
                    const SizedBox(height: 12),

                    const EngagementCard(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChipSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<String>(
          valueListenable: _controller.kelas,
          builder: (context, val, child) => DropdownChip(
            value: val,
            options: TugasFormController.kelasList,
            onChanged: (v) => _controller.kelas.value = v!,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ValueListenableBuilder<String>(
              valueListenable: _controller.jenisNilai,
              builder: (context, val, child) => DropdownChip(
                value: val,
                options: TugasFormController.jenisNilaiList,
                onChanged: (v) => _controller.jenisNilai.value = v!,
              ),
            ),
            const SizedBox(width: 8),
            ValueListenableBuilder<String>(
              valueListenable: _controller.mapel,
              builder: (context, val, child) => DropdownChip(
                value: val,
                options: TugasFormController.mapelList,
                onChanged: (v) => _controller.mapel.value = v!,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<String>(
          valueListenable: _controller.siswa,
          builder: (context, val, child) => DropdownChip(
            value: val,
            options: TugasFormController.siswaList,
            onChanged: (v) => _controller.siswa.value = v!,
          ),
        ),
      ],
    );
  }
}
