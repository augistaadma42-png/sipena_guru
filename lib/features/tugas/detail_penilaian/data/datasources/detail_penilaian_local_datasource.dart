import '../models/detail_penilaian_model.dart';

abstract class DetailPenilaianLocalDatasource {
  Future<DetailPenilaianModel> getDetailPenilaian({
    required String siswaId, required String tugasId,
  });
  Future<void> submitPenilaian({
    required String siswaId, required String tugasId,
    required int score,      required String feedback,
  });
}

class DetailPenilaianLocalDatasourceImpl
    implements DetailPenilaianLocalDatasource {

  // In-memory store agar data terasa persistent dalam satu sesi
  final Map<String, DetailPenilaianModel> _store = {};

  // ── Dummy bank data per kombinasi siswaId_tugasId ──────────
  static final List<DetailPenilaianModel> _dummyData = [
    // Tugas 1: Latihan Logika Dasar
    const DetailPenilaianModel(
      id: 'siswa_1_tugas_1', studentName: 'Esa Farellio',
      nisn: '2021049923', kelas: 'XI-RPL 1',
      tugasTitle: 'Latihan Logika Dasar', submittedAt: '12 Okt 2023, 14:20',
      attachmentFileName: 'Esa_logika.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 0, feedback: '', isSubmitted: false,
    ),
    const DetailPenilaianModel(
      id: 'siswa_2_tugas_1', studentName: 'Augista Adma Z',
      nisn: '2021049905', kelas: 'XI-RPL 1',
      tugasTitle: 'Latihan Logika Dasar', submittedAt: '12 Okt 2023, 15:05',
      attachmentFileName: 'Augista_logika.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 85, feedback: 'Sudah cukup baik, tingkatkan analisis.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_3_tugas_1', studentName: 'Rizky Pratama',
      nisn: '2021049910', kelas: 'XI-RPL 1',
      tugasTitle: 'Latihan Logika Dasar', submittedAt: '13 Okt 2023, 09:15',
      attachmentFileName: 'Rizky_logika.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 0, feedback: '', isSubmitted: false,
    ),
    // Tugas 2: Projek Web Dinamis
    const DetailPenilaianModel(
      id: 'siswa_1_tugas_2', studentName: 'Esa Farellio',
      nisn: '2021049923', kelas: 'XI-RPL 1',
      tugasTitle: 'Projek Web Dinamis', submittedAt: '20 Okt 2023, 10:30',
      attachmentFileName: 'Esa_web.zip',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 90, feedback: 'Desain responsif, kode rapi. Pertahankan!',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_2_tugas_2', studentName: 'Augista Adma Z',
      nisn: '2021049905', kelas: 'XI-RPL 1',
      tugasTitle: 'Projek Web Dinamis', submittedAt: '21 Okt 2023, 08:00',
      attachmentFileName: 'Augista_web.zip',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 0, feedback: '', isSubmitted: false,
    ),
    const DetailPenilaianModel(
      id: 'siswa_4_tugas_2', studentName: 'Nadia Cahyani',
      nisn: '2021049934', kelas: 'XI-RPL 1',
      tugasTitle: 'Projek Web Dinamis', submittedAt: '20 Okt 2023, 22:45',
      attachmentFileName: 'Nadia_web.zip',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 78, feedback: 'JavaScript masih perlu diperbaiki.',
      isSubmitted: true,
    ),
  ];

  String _key(String siswaId, String tugasId) => '${siswaId}_$tugasId';

  DetailPenilaianModel _findOrThrow(String siswaId, String tugasId) {
    final key = _key(siswaId, tugasId);
    if (_store.containsKey(key)) return _store[key]!;
    try {
      return _dummyData.firstWhere((d) => d.id == key);
    } catch (_) {
      // Jika data tidak ditemukan di list dummy, buat data default secara dinamis
      final newModel = DetailPenilaianModel(
        id: key,
        studentName: 'Siswa $siswaId',
        nisn: '2021049999',
        kelas: 'XI-RPL 1',
        tugasTitle: 'Tugas $tugasId',
        submittedAt: 'Belum dikumpulkan',
        attachmentFileName: 'Tidak ada file',
        attachmentPreviewUrl: 'assets/images/preview_dummy.png',
        currentScore: 0,
        feedback: '',
        isSubmitted: false,
      );
      _store[key] = newModel;
      return newModel;
    }
  }

  @override
  Future<DetailPenilaianModel> getDetailPenilaian({
    required String siswaId, required String tugasId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _findOrThrow(siswaId, tugasId);
  }

  @override
  Future<void> submitPenilaian({
    required String siswaId, required String tugasId,
    required int score,      required String feedback,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final updated = _findOrThrow(siswaId, tugasId).copyWith(
      currentScore: score, feedback: feedback, isSubmitted: true,
    );
    _store[_key(siswaId, tugasId)] = updated;
  }
}