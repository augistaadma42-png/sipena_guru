import 'package:flutter/material.dart';
import '../../domain/entities/tugas.dart';

class TugasFormController extends ChangeNotifier {
  // Text Controllers
  final TextEditingController judulMateriController = TextEditingController();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  // ValueNotifiers
  final ValueNotifier<String> kelas = ValueNotifier('XII IPA 1');
  final ValueNotifier<String> jenisNilai = ValueNotifier('Tugas');
  final ValueNotifier<String> mapel = ValueNotifier('Matematika Wajib');
  final ValueNotifier<String> siswa = ValueNotifier('Semua pelajar');
  final ValueNotifier<String> selectedMateri = ValueNotifier('Pilih Materi');
  final ValueNotifier<DateTime?> tenggat = ValueNotifier(null);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  // Options
  static const List<String> kelasList = ['XII IPA 1', 'XII IPA 2', 'XI IPA 1'];

  static const List<String> jenisNilaiList = ['Materi', 'Tugas'];

  static const List<String> mapelList = [
    'Matematika Wajib',
    'Matematika Peminatan',
    'Fisika',
    'Kimia',
    'Biologi',
  ];

  static const List<String> siswaList = [
    'Semua pelajar',
  ];

  static const List<String> materiList = [
    'Pilih Materi',
    'Materi Integral Dasar',
    'Materi Integral Substitusi',
    'Materi Turunan Fungsi',
    'Materi Limit Fungsi',
  ];

  bool get isValid {
    return jenisNilai.value == 'Materi'
        ? judulMateriController.text.trim().isNotEmpty
        : judulController.text.trim().isNotEmpty;
  }

  Tugas buildEntity() {
    final judul = jenisNilai.value == 'Materi'
        ? judulMateriController.text.trim()
        : judulController.text.trim();

    return Tugas(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      judul: judul,
      deskripsi: deskripsiController.text.trim(),
      kelas: kelas.value,
      jenisNilai: jenisNilai.value,
      mapel: mapel.value,
      siswa: siswa.value,
      tenggat: tenggat.value,
      createdAt: DateTime.now(),
      // [CHANGE 4] Simpan materi terkait yang dipilih
      materiTerkait: selectedMateri.value == 'Pilih Materi' ? '' : selectedMateri.value,
    );
  }

  @override
  void dispose() {
    judulMateriController.dispose();
    judulController.dispose();
    deskripsiController.dispose();
    kelas.dispose();
    jenisNilai.dispose();
    mapel.dispose();
    siswa.dispose();
    selectedMateri.dispose();
    tenggat.dispose();
    isLoading.dispose();
    super.dispose();
  }
}