import 'package:flutter/material.dart';
import '../../domain/entities/tugas.dart';

class TugasFormController extends ChangeNotifier {
  // Text Controllers
  final TextEditingController judulMateriController = TextEditingController();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  // ValueNotifiers
  final ValueNotifier<String> kelas = ValueNotifier('Untuk XI PPLG Konsentrasi Keahlian');
  final ValueNotifier<String> jenisNilai = ValueNotifier('Ulangan harian');
  final ValueNotifier<String> mapel = ValueNotifier('Mapel');
  final ValueNotifier<String> siswa = ValueNotifier('Semua pelajar');
  final ValueNotifier<DateTime?> tenggat = ValueNotifier(null);
  final ValueNotifier<String> topik = ValueNotifier('Tidak ada topik');
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  // Options
  static const List<String> kelasList = [
    'Untuk XI PPLG Konsentrasi Keahlian',
    'Untuk X PPLG',
    'Untuk XII PPLG',
  ];

  static const List<String> jenisNilaiList = [
    'Ulangan harian',
    'UTS',
    'UAS',
    'Tugas proyek',
    'Kuis',
  ];

  static const List<String> mapelList = [
    'Mapel',
    'Matematika',
    'Bahasa Indonesia',
    'Bahasa Inggris',
    'Pemrograman',
  ];

  static const List<String> siswaList = [
    'Semua pelajar',
    'Kelompok A',
    'Kelompok B',
  ];

  static const List<String> topikList = [
    'Tidak ada topik',
    'Bab 1',
    'Bab 2',
    'Bab 3',
  ];

  bool get isValid => judulController.text.trim().isNotEmpty;

  Tugas buildEntity() {
    return Tugas(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      judul: judulController.text.trim(),
      deskripsi: deskripsiController.text.trim(),
      kelas: kelas.value,
      jenisNilai: jenisNilai.value,
      mapel: mapel.value,
      siswa: siswa.value,
      tenggat: tenggat.value,
      topik: topik.value,
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
    topik.dispose();
    isLoading.dispose();
    super.dispose();
  }
}
