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
    'Kelompok A',
    'Kelompok B',
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
      topik: '',
      createdAt: DateTime.now(),
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
    tenggat.dispose();
    isLoading.dispose();
    super.dispose();
  }
}
