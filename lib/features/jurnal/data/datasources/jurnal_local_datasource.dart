import '../models/jurnal_model.dart';

abstract class JurnalLocalDatasource {
  Future<List<JurnalModel>> getJurnalTerbaru();
  Future<List<JurnalModel>> getRekapJurnal(
      String? filterKelas, int? filterBulan, int? filterTahun);
  Future<void> simpanJurnal(JurnalModel jurnal);
}

class JurnalLocalDatasourceImpl implements JurnalLocalDatasource {
  // Data dummy jurnal terbaru
  static final List<JurnalModel> _jurnalTerbaruData = [
    const JurnalModel(
      id: 'j1',
      className: 'XII IPA 1',
      time: '13:00 - 14:30',
      tanggal: '27/05/2026',
      mapel: 'Matematika Wajib',
      title: 'Integral Tentu dan Tak Tentu',
      description: 'Latihan soal and penjelasan mengenai integral tentu dan tak tentu...',
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
      title: 'Polinomial dan Suku Banyak',
      description: 'Diskusi kelompok mengenai pembagian polinomial...',
    ),
    const JurnalModel(
      id: 'j4',
      className: 'XII IPA 1',
      time: '07:00 - 08:00',
      tanggal: '26/05/2026',
      mapel: 'Matematika Wajib',
      title: 'Turunan Fungsi Aljabar',
      description: 'Evaluasi pemahaman siswa tentang turunan fungsi...',
    ),
    const JurnalModel(
      id: 'j5',
      className: 'XI IPA 1',
      time: '06:30 - 07:00',
      tanggal: '26/05/2026',
      mapel: 'Matematika Peminatan',
      title: 'Teorema Sisa Polinomial',
      description: 'Penjelasan and latihan soal teorema sisa...',
    ),
  ];

  // Data dummy rekap jurnal
  static final List<JurnalModel> _rekapJurnalData = [
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
      title: 'Polinomial dan Suku Banyak',
      description: 'Diskusi kelompok mengenai konsep suku banyak',
    ),
    const JurnalModel(
      id: 'r4',
      className: 'XII IPA 1',
      time: 'Kamis, 07 Mei 2026 | 08:00 - 09:30',
      tanggal: '07/05/2026',
      mapel: 'Matematika Wajib',
      title: 'Turunan Fungsi Aljabar',
      description: 'Evaluasi pemahaman siswa tentang turunan fungsi',
    ),
    const JurnalModel(
      id: 'r5',
      className: 'XI IPA 1',
      time: 'Jumat, 08 Mei 2026 | 09:00 - 10:30',
      tanggal: '08/05/2026',
      mapel: 'Matematika Peminatan',
      title: 'Teorema Sisa Polinomial',
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
      mapel: 'Matematika Peminatan',
      title: 'Limit Fungsi Aljabar',
      description: 'Penjelasan limit fungsi aljabar mendekati nilai tertentu',
    ),
    // April 2026
    const JurnalModel(
      id: 'r8',
      className: 'XII IPA 2',
      time: 'Senin, 06 April 2026 | 10:00 - 11:30',
      tanggal: '06/04/2026',
      mapel: 'Matematika Wajib',
      title: 'Integral Parsial',
      description: 'Latihan menyusun integral parsial yang kompleks',
    ),
    const JurnalModel(
      id: 'r9',
      className: 'XI IPA 1',
      time: 'Selasa, 14 April 2026 | 08:00 - 09:30',
      tanggal: '14/04/2026',
      mapel: 'Matematika Peminatan',
      title: 'Persamaan Trigonometri',
      description: 'Latihan penyelesaian persamaan trigonometri dasar',
    ),
    const JurnalModel(
      id: 'r10',
      className: 'XII IPA 1',
      time: 'Kamis, 23 April 2026 | 07:00 - 08:30',
      tanggal: '23/04/2026',
      mapel: 'Matematika Wajib',
      title: 'Limit Fungsi Trigonometri',
      description: 'Pembahasan limit fungsi trigonometri beserta aplikasinya',
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
      className: 'XI IPA 1',
      time: 'Rabu, 10 Juni 2026 | 09:00 - 10:30',
      tanggal: '10/06/2026',
      mapel: 'Matematika Peminatan',
      title: 'Kesetimbangan Polinomial',
      description: 'Membahas konsep pemfaktoran suku banyak secara menyeluruh',
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
          final parts = j.tanggal.split('/');
          if (parts.length < 3) return false;
          final bln = int.parse(parts[1]);
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
    
    // Update atau insert di _jurnalTerbaruData
    final index = _jurnalTerbaruData.indexWhere((j) => j.id == jurnal.id);
    if (index != -1) {
      _jurnalTerbaruData[index] = jurnal;
    } else {
      _jurnalTerbaruData.insert(0, jurnal);
    }

    // Update atau insert di _rekapJurnalData
    final rekapIndex = _rekapJurnalData.indexWhere((j) => j.id == jurnal.id);
    if (rekapIndex != -1) {
      _rekapJurnalData[rekapIndex] = jurnal;
    } else {
      _rekapJurnalData.insert(0, jurnal);
    }
  }
}
