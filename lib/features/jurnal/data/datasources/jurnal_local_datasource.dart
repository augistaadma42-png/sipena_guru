import '../models/jurnal_model.dart';

abstract class JurnalLocalDatasource {
  Future<List<JurnalModel>> getJurnalTerbaru();
  Future<List<JurnalModel>> getRekapJurnal(String? filterKelas, DateTime? filterTanggal);
  Future<void> simpanJurnal(JurnalModel jurnal);
}

class JurnalLocalDatasourceImpl implements JurnalLocalDatasource {
  final List<JurnalModel> _jurnalTerbaruData = [
    const JurnalModel(
      id: 'j1',
      className: 'XII IPA 1',
      time: '13:00 - 14:30',
      title: 'Integral Tentu dan Tak Tentu',
      description: 'Latihan soal dan penjelasan mengenai integral tentu dan tak tentu...',
    ),
    const JurnalModel(
      id: 'j2',
      className: 'XII IPA 2',
      time: '10:00 - 11:30',
      title: 'Integral Substitusi',
      description: 'Membahas metode substitusi pada integral...',
    ),
    const JurnalModel(
      id: 'j3',
      className: 'XI IPA 1',
      time: '08:00 - 09:30',
      title: 'Trigonometri Dasar',
      description: 'Diskusi kelompok mengenai perbandingan trigonometri...',
    ),
    const JurnalModel(
      id: 'j4',
      className: 'XII IPA 1',
      time: '07:00 - 08:00',
      title: 'Quiz Integral',
      description: 'Evaluasi pemahaman siswa tentang integral...',
    ),
    const JurnalModel(
      id: 'j5',
      className: 'Apel Pagi',
      time: '06:30 - 07:00',
      title: 'Upacara Bendera',
      description: 'Mengikuti upacara bendera bersama seluruh siswa...',
    ),
  ];

  final List<JurnalModel> _rekapJurnalData = [
    const JurnalModel(
      id: 'r1',
      className: 'XII IPA 1',
      time: 'Senin, 04 Mei 2026 | 07:00 - 08:30',
      title: 'Integral Tentu dan Tak Tentu',
      description: '"Latihan soal dan penjelasan mengenai integral tentu dan tak tentu"',
    ),
    const JurnalModel(
      id: 'r2',
      className: 'XII IPA 2',
      time: 'Selasa, 05 Mei 2026 | 10:00 - 11:30',
      title: 'Integral Substitusi',
      description: '"Membahas metode substitusi pada integral"',
    ),
    const JurnalModel(
      id: 'r3',
      className: 'XI IPA 1',
      time: 'Rabu, 06 Mei 2026 | 13:00 - 14:30',
      title: 'Trigonometri Dasar',
      description: '"Diskusi kelompok mengenai perbandingan trigonometri"',
    ),
    const JurnalModel(
      id: 'r4',
      className: 'XII IPA 1',
      time: 'Kamis, 07 Mei 2026 | 08:00 - 09:30',
      title: 'Quiz Integral',
      description: '"Evaluasi pemahaman siswa tentang integral"',
    ),
  ];

  @override
  Future<List<JurnalModel>> getJurnalTerbaru() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _jurnalTerbaruData;
  }

  @override
  Future<List<JurnalModel>> getRekapJurnal(String? filterKelas, DateTime? filterTanggal) async {
    await Future.delayed(const Duration(milliseconds: 300));
    var results = _rekapJurnalData;
    
    if (filterKelas != null && filterKelas != 'Semua Kelas') {
      results = results.where((j) => j.className == filterKelas).toList();
    }
    
    // Asumsikan time memiliki format tanggal yang bisa diparse jika filterTanggal != null
    // Untuk dummy ini, kita filter sederhana.
    return results;
  }

  @override
  Future<void> simpanJurnal(JurnalModel jurnal) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Simulasi simpan data
  }
}
