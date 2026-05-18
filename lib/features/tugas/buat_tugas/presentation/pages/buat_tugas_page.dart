import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../bloc/tugas_form_controller.dart';
import '../widgets/tugas_header.dart';     
import '../../../../../../core/widgets/dropdown_chip.dart';
import '../widgets/input_judul.dart';
import '../widgets/deskripsi_input.dart';
import '../widgets/tanggal_picker.dart';
import '../widgets/topik_dropdown.dart';
import '../widgets/lampiran_section.dart';
import '../widgets/engagement_card.dart';
import '../../../dashboard_tugas/presentation/pages/tugas_store.dart';

class BuatTugasPage extends StatefulWidget {
  const BuatTugasPage({super.key});

  @override
  State<BuatTugasPage> createState() => _BuatTugasPageState();
}

class _BuatTugasPageState extends State<BuatTugasPage> {
  late final TugasFormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TugasFormController();
    // rebuild tombol simpan saat judul berubah
    _controller.judulController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSimpan() {
    if (!_controller.isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Judul tugas wajib diisi!'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    final tugas = _controller.buildEntity();
    TugasStore.tambah(context, tugas);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tugas "${tugas.judul}" berhasil disimpan!'),
        backgroundColor: AppColors.successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header custom (bukan AppBar)
            TugasHeader(
              onClose: () => Navigator.of(context).pop(),
              onSimpan: _onSimpan,
            ),

            // Konten scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row chips dropdown
                    _buildChipSection(),
                    const SizedBox(height: 16),

                    // Input Judul
                    InputJudul(controller: _controller.judulController),
                    const SizedBox(height: 12),

                    // Deskripsi + Toolbar
                    DeskripsiInput(controller: _controller.deskripsiController),
                    const SizedBox(height: 12),

                    // Tanggal & Topik
                    TanggalPicker(tenggatNotifier: _controller.tenggat),
                    const SizedBox(height: 8),
                    TopikDropdown(
                      topikNotifier: _controller.topik,
                      options: TugasFormController.topikList,
                    ),
                    const SizedBox(height: 12),

                    // Lampiran
                    const LampiranSection(),
                    const SizedBox(height: 12),

                    // Engagement
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
        // Kelas — full width chip
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
            // Jenis Nilai
            ValueListenableBuilder<String>(
              valueListenable: _controller.jenisNilai,
              builder: (context, val, child) => DropdownChip(
                value: val,
                options: TugasFormController.jenisNilaiList,
                onChanged: (v) => _controller.jenisNilai.value = v!,
              ),
            ),
            const SizedBox(width: 8),
            // Mapel
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
        // Siswa
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
