import '../models/detail_penilaian_model.dart';

abstract class DetailPenilaianLocalDatasource {
  Future<DetailPenilaianModel> getDetailPenilaian({
    required String siswaId,
    required String tugasId,
  });
  Future<void> submitPenilaian({
    required String siswaId,
    required String tugasId,
    required int score,
    required String feedback,
  });
}

class DetailPenilaianLocalDatasourceImpl
    implements DetailPenilaianLocalDatasource {
  // In-memory store agar data persistent dalam satu sesi
  final Map<String, DetailPenilaianModel> _store = {};

  //  Dummy data per kombinasi siswaId_tugasId
  static final List<DetailPenilaianModel> _dummyData = [
    // Tugas 1: Latihan Integral
    const DetailPenilaianModel(
      id: 'siswa_s1_tugas_1',
      studentName: 'Ahmad Fauzan',
      nisn: '0057281',
      kelas: 'XII IPA 1',
      tugasTitle: 'Latihan Integral',
      submittedAt: '24 Okt 2026, 08:30',
      attachmentFileName: 'Ahmad_Fauzan_Integral.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 95,
      feedback: 'Sangat baik, semua langkah penyelesaian tepat!',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s2_tugas_1',
      studentName: 'Ananda Aryani',
      nisn: '0057282',
      kelas: 'XII IPA 1',
      tugasTitle: 'Latihan Integral',
      submittedAt: '23 Okt 2026, 14:15',
      attachmentFileName: 'Ananda_Integral.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 90,
      feedback: 'Sudah cukup baik, tingkatkan analisis.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s3_tugas_1',
      studentName: 'Bagus Akbar',
      nisn: '0057283',
      kelas: 'XII IPA 1',
      tugasTitle: 'Latihan Integral',
      submittedAt: 'Belum dikumpulkan',
      attachmentFileName: 'Tidak ada file',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 0,
      feedback: '',
      isSubmitted: false,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s4_tugas_1',
      studentName: 'Bunga Pertiwi',
      nisn: '0057284',
      kelas: 'XII IPA 1',
      tugasTitle: 'Latihan Integral',
      submittedAt: '23 Okt 2026, 14:15',
      attachmentFileName: 'Bunga_Integral.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 0,
      feedback: '',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s5_tugas_1',
      studentName: 'Candra Aditama',
      nisn: '0057285',
      kelas: 'XII IPA 1',
      tugasTitle: 'Latihan Integral',
      submittedAt: '22 Okt 2026, 09:00',
      attachmentFileName: 'Candra_Integral.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 85,
      feedback: 'Pengerjaan rapi, pertahankan.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s6_tugas_1',
      studentName: 'Dewi Lestari',
      nisn: '0057286',
      kelas: 'XII IPA 1',
      tugasTitle: 'Latihan Integral',
      submittedAt: '26 Okt 2026, 19:45',
      attachmentFileName: 'Dewi_Lestari_Integral.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 75,
      feedback: 'Terlambat mengumpulkan, perlu lebih disiplin.',
      isSubmitted: true,
    ),
    // Tugas 2: Quiz Integral Substitusi
    const DetailPenilaianModel(
      id: 'siswa_s1_tugas_2',
      studentName: 'Daffa Rizaldi',
      nisn: '0057291',
      kelas: 'XII IPA 2',
      tugasTitle: 'Quiz Integral Substitusi',
      submittedAt: '28 Okt 2026, 10:15',
      attachmentFileName: 'Daffa_SubstitusiIntegral.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 95,
      feedback: 'Pengerjaan sangat teliti. Pertahankan!',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s2_tugas_2',
      studentName: 'Eka Putri Sari',
      nisn: '0057292',
      kelas: 'XII IPA 2',
      tugasTitle: 'Quiz Integral Substitusi',
      submittedAt: '27 Okt 2026, 16:00',
      attachmentFileName: 'Eka_Integral.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 88,
      feedback: 'Baik, perlu lebih teliti di langkah substitusi.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s3_tugas_2',
      studentName: 'Fajar Nugroho',
      nisn: '0057293',
      kelas: 'XII IPA 2',
      tugasTitle: 'Quiz Integral Substitusi',
      submittedAt: 'Belum dikumpulkan',
      attachmentFileName: 'Tidak ada file',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 0,
      feedback: '',
      isSubmitted: false,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s4_tugas_2',
      studentName: 'Gita Maharani',
      nisn: '0057294',
      kelas: 'XII IPA 2',
      tugasTitle: 'Quiz Integral Substitusi',
      submittedAt: 'Belum dikumpulkan',
      attachmentFileName: 'Tidak ada file',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 0,
      feedback: '',
      isSubmitted: false,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s5_tugas_2',
      studentName: 'Hendra Wijaya',
      nisn: '0057295',
      kelas: 'XII IPA 2',
      tugasTitle: 'Quiz Integral Substitusi',
      submittedAt: '28 Okt 2026, 08:45',
      attachmentFileName: 'Hendra_Substitusi.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 78,
      feedback: 'Perlu perbaiki langkah substitusi variabel.',
      isSubmitted: true,
    ),
  ];

  String _key(String siswaId, String tugasId) =>
      'siswa_${siswaId}_tugas_${tugasId}';

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
        nisn: '0057999',
        kelas: 'XII IPA 1',
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
    required String siswaId,
    required String tugasId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _findOrThrow(siswaId, tugasId);
  }

  @override
  Future<void> submitPenilaian({
    required String siswaId,
    required String tugasId,
    required int score,
    required String feedback,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final updated = _findOrThrow(
      siswaId,
      tugasId,
    ).copyWith(currentScore: score, feedback: feedback, isSubmitted: true);
    _store[_key(siswaId, tugasId)] = updated;
  }
}