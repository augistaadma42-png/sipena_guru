import 'package:flutter/material.dart';
import '../../domain/entities/tugas.dart';

class TugasFormController extends ChangeNotifier {
  // Text Controllers
  final TextEditingController judulMateriController = TextEditingController();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  // ValueNotifiers
  final ValueNotifier<String> kelas = ValueNotifier('XII IPA 1');
  final ValueNotifier<String> jenisNilai = ValueNotifier('Ulangan harian');
  final ValueNotifier<String> mapel = ValueNotifier('Matematika Wajib');
  final ValueNotifier<String> siswa = ValueNotifier('Semua pelajar');
  final ValueNotifier<DateTime?> tenggat = ValueNotifier(null);
  final ValueNotifier<String> topik = ValueNotifier('Tidak ada topik');
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  // Options
  static const List<String> kelasList = [
    'XII IPA 1',
    'XII IPA 2',
    'XI IPA 1',
  ];

  static const List<String> jenisNilaiList = [
    'Ulangan harian',
    'UTS',
    'UAS',
    'Tugas proyek',
    'Kuis',
  ];

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

  static const List<String> topikList = [
    'Tidak ada topik',
    'Integral Tentu & Tak Tentu',
    'Integral Substitusi',
    'Integral Parsial',
    'Trigonometri',
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
