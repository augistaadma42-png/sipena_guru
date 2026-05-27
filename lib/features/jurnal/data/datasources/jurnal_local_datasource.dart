import '../models/jurnal_model.dart';

abstract class JurnalLocalDatasource {
  Future<List<JurnalModel>> getJurnalTerbaru();
  Future<List<JurnalModel>> getRekapJurnal(
      String? filterKelas, int? filterBulan, int? filterTahun);
  Future<void> simpanJurnal(JurnalModel jurnal);
}

class JurnalLocalDatasourceImpl implements JurnalLocalDatasource {
  // Data dummy jurnal terbaru (tanpa tanggal penuh, hanya jam hari ini)
  final List<JurnalModel> _jurnalTerbaruData = [
    const JurnalModel(
      id: 'j1',
      className: 'XII IPA 1',
      time: '13:00 - 14:30',
      tanggal: '27/05/2026',
      mapel: 'Matematika Wajib',
      title: 'Integral Tentu dan Tak Tentu',
      description: 'Latihan soal dan penjelasan mengenai integral tentu dan tak tentu...',
    ),
    const JurnalModel(
      id: 'j2',
      className: 'XII IPA 2',
      time: '10:00 - 11:30',
      tanggal: '27/05/2026',
      mapel: 'Matematika Wajib',
      title: 'Integral Substitusi',
      description: 'Membahas metode substitusi pada integral...',
    ),
    const JurnalModel(
      id: 'j3',
      className: 'XI IPA 1',
      time: '08:00 - 09:30',
      tanggal: '27/05/2026',
      mapel: 'Matematika Peminatan',
      title: 'Trigonometri Dasar',
      description: 'Diskusi kelompok mengenai perbandingan trigonometri...',
    ),
    const JurnalModel(
      id: 'j4',
      className: 'XII IPA 1',
      time: '07:00 - 08:00',
      tanggal: '26/05/2026',
      mapel: 'Fisika',
      title: 'Quiz Integral',
      description: 'Evaluasi pemahaman siswa tentang integral...',
    ),
    const JurnalModel(
      id: 'j5',
      className: 'XI IPA 2',
      time: '06:30 - 07:00',
      tanggal: '26/05/2026',
      mapel: 'Kimia',
      title: 'Reaksi Reduksi-Oksidasi',
      description: 'Penjelasan dan latihan soal reaksi redoks...',
    ),
  ];

  // Data dummy rekap jurnal (multi-bulan untuk keperluan filter)
  final List<JurnalModel> _rekapJurnalData = [
    // Mei 2026
    const JurnalModel(
      id: 'r1',
      className: 'XII IPA 1',
      time: 'Senin, 04 Mei 2026 | 07:00 - 08:30',
      tanggal: '04/05/2026',
      mapel: 'Matematika Wajib',
      title: 'Integral Tentu dan Tak Tentu',
      description: 'Latihan soal dan penjelasan mengenai integral tentu dan tak tentu',
    ),
    const JurnalModel(
      id: 'r2',
      className: 'XII IPA 2',
      time: 'Selasa, 05 Mei 2026 | 10:00 - 11:30',
      tanggal: '05/05/2026',
      mapel: 'Matematika Wajib',
      title: 'Integral Substitusi',
      description: 'Membahas metode substitusi pada integral',
    ),
    const JurnalModel(
      id: 'r3',
      className: 'XI IPA 1',
      time: 'Rabu, 06 Mei 2026 | 13:00 - 14:30',
      tanggal: '06/05/2026',
      mapel: 'Matematika Peminatan',
      title: 'Trigonometri Dasar',
      description: 'Diskusi kelompok mengenai perbandingan trigonometri',
    ),
    const JurnalModel(
      id: 'r4',
      className: 'XII IPA 1',
      time: 'Kamis, 07 Mei 2026 | 08:00 - 09:30',
      tanggal: '07/05/2026',
      mapel: 'Fisika',
      title: 'Quiz Integral',
      description: 'Evaluasi pemahaman siswa tentang integral',
    ),
    const JurnalModel(
      id: 'r5',
      className: 'XI IPA 2',
      time: 'Jumat, 08 Mei 2026 | 09:00 - 10:30',
      tanggal: '08/05/2026',
      mapel: 'Kimia',
      title: 'Reaksi Reduksi-Oksidasi',
      description: 'Penjelasan dan latihan soal reaksi redoks',
    ),
    const JurnalModel(
      id: 'r6',
      className: 'XII IPA 1',
      time: 'Senin, 18 Mei 2026 | 07:00 - 08:30',
      tanggal: '18/05/2026',
      mapel: 'Matematika Wajib',
      title: 'Turunan Fungsi Komposisi',
      description: 'Membahas aturan rantai pada turunan fungsi',
    ),
    const JurnalModel(
      id: 'r7',
      className: 'XI IPA 1',
      time: 'Rabu, 20 Mei 2026 | 13:00 - 14:30',
      tanggal: '20/05/2026',
      mapel: 'Biologi',
      title: 'Sistem Pencernaan',
      description: 'Penjelasan organ dan proses pencernaan manusia',
    ),
    // April 2026
    const JurnalModel(
      id: 'r8',
      className: 'XII IPA 2',
      time: 'Senin, 06 April 2026 | 10:00 - 11:30',
      tanggal: '06/04/2026',
      mapel: 'Bahasa Indonesia',
      title: 'Menulis Teks Eksposisi',
      description: 'Latihan menyusun paragraf eksposisi yang efektif',
    ),
    const JurnalModel(
      id: 'r9',
      className: 'XI IPA 1',
      time: 'Selasa, 14 April 2026 | 08:00 - 09:30',
      tanggal: '14/04/2026',
      mapel: 'Bahasa Inggris',
      title: 'Reading Comprehension',
      description: 'Latihan membaca dan memahami teks berbahasa Inggris',
    ),
    const JurnalModel(
      id: 'r10',
      className: 'XII IPA 1',
      time: 'Kamis, 23 April 2026 | 07:00 - 08:30',
      tanggal: '23/04/2026',
      mapel: 'Fisika',
      title: 'Hukum Newton',
      description: 'Pembahasan hukum Newton I, II, dan III beserta aplikasinya',
    ),
    // Juni 2026
    const JurnalModel(
      id: 'r11',
      className: 'XII IPA 1',
      time: 'Senin, 01 Juni 2026 | 07:00 - 08:30',
      tanggal: '01/06/2026',
      mapel: 'Matematika Wajib',
      title: 'Persamaan Diferensial',
      description: 'Pengenalan persamaan diferensial orde pertama',
    ),
    const JurnalModel(
      id: 'r12',
      className: 'XI IPA 2',
      time: 'Rabu, 10 Juni 2026 | 09:00 - 10:30',
      tanggal: '10/06/2026',
      mapel: 'Kimia',
      title: 'Kesetimbangan Kimia',
      description: 'Membahas konsep kesetimbangan kimia dan konstanta kesetimbangan',
    ),
  ];

  @override
  Future<List<JurnalModel>> getJurnalTerbaru() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _jurnalTerbaruData;
  }

  @override
  Future<List<JurnalModel>> getRekapJurnal(
      String? filterKelas, int? filterBulan, int? filterTahun) async {
    await Future.delayed(const Duration(milliseconds: 300));
    var results = _rekapJurnalData;

    if (filterKelas != null && filterKelas != 'Semua Kelas') {
      results = results.where((j) => j.className == filterKelas).toList();
    }

    if (filterBulan != null) {
      results = results.where((j) {
        try {
          // tanggal format: 'dd/MM/yyyy'
          final parts = j.tanggal.split('/');
          if (parts.length < 3) return false;
          final bln = int.parse(parts[1]);
          final thn = int.parse(parts[2]);
          return bln == filterBulan;
        } catch (_) {
          return false;
        }
      }).toList();
    }

    return results;
  }

  @override
  Future<void> simpanJurnal(JurnalModel jurnal) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Simulasi simpan data
  }
}
