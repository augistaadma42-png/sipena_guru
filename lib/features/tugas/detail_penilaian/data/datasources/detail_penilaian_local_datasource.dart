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


  static final List<DetailPenilaianModel> _dummyData = [
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
      studentName: 'Daffa Rizaldi',
      nisn: '0057286',
      kelas: 'XII IPA 1',
      tugasTitle: 'Latihan Integral',
      submittedAt: '24 Okt 2026, 09:15',
      attachmentFileName: 'Daffa_Integral.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 92,
      feedback: 'Penyelesaian sistematis dan benar.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s7_tugas_1',
      studentName: 'Dewi Lestari',
      nisn: '0057287',
      kelas: 'XII IPA 1',
      tugasTitle: 'Latihan Integral',
      submittedAt: '26 Okt 2026, 19:45',
      attachmentFileName: 'Dewi_Lestari_Integral.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 75,
      feedback: 'Terlambat mengumpulkan, perlu lebih disiplin.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s8_tugas_1',
      studentName: 'Eka Putri Sari',
      nisn: '0057288',
      kelas: 'XII IPA 1',
      tugasTitle: 'Latihan Integral',
      submittedAt: '24 Okt 2026, 10:00',
      attachmentFileName: 'Eka_Integral.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 87,
      feedback: 'Baik, jawaban lengkap.',
      isSubmitted: true,
    ),

    
    const DetailPenilaianModel(
      id: 'siswa_s1_tugas_2',
      studentName: 'Ahmad Fauzan',
      nisn: '0057291',
      kelas: 'XII IPA 2',
      tugasTitle: 'Quiz Integral Substitusi',
      submittedAt: '28 Okt 2026, 10:15',
      attachmentFileName: 'Ahmad_Substitusi.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 95,
      feedback: 'Pengerjaan sangat teliti. Pertahankan!',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s2_tugas_2',
      studentName: 'Ananda Aryani',
      nisn: '0057292',
      kelas: 'XII IPA 2',
      tugasTitle: 'Quiz Integral Substitusi',
      submittedAt: '27 Okt 2026, 16:00',
      attachmentFileName: 'Ananda_Substitusi.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 90,
      feedback: 'Sangat baik, semua substitusi tepat.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s3_tugas_2',
      studentName: 'Bagus Akbar',
      nisn: '0057293',
      kelas: 'XII IPA 2',
      tugasTitle: 'Quiz Integral Substitusi',
      submittedAt: '28 Okt 2026, 09:30',
      attachmentFileName: 'Bagus_Substitusi.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 88,
      feedback: 'Langkah substitusi sudah tepat.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s4_tugas_2',
      studentName: 'Bunga Pertiwi',
      nisn: '0057294',
      kelas: 'XII IPA 2',
      tugasTitle: 'Quiz Integral Substitusi',
      submittedAt: '28 Okt 2026, 08:30',
      attachmentFileName: 'Bunga_Substitusi.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 88,
      feedback: 'Penyelesaian lengkap dan rapi.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s5_tugas_2',
      studentName: 'Candra Aditama',
      nisn: '0057295',
      kelas: 'XII IPA 2',
      tugasTitle: 'Quiz Integral Substitusi',
      submittedAt: '28 Okt 2026, 07:15',
      attachmentFileName: 'Candra_Substitusi.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 85,
      feedback: 'Sudah baik, tingkatkan ketelitian.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s6_tugas_2',
      studentName: 'Daffa Rizaldi',
      nisn: '0057296',
      kelas: 'XII IPA 2',
      tugasTitle: 'Quiz Integral Substitusi',
      submittedAt: '29 Okt 2026, 10:15',
      attachmentFileName: 'Daffa_SubstitusiIntegral.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 75,
      feedback: 'Terlambat, perbaiki manajemen waktu.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s7_tugas_2',
      studentName: 'Dewi Lestari',
      nisn: '0057297',
      kelas: 'XII IPA 2',
      tugasTitle: 'Quiz Integral Substitusi',
      submittedAt: '28 Okt 2026, 11:30',
      attachmentFileName: 'Dewi_Substitusi.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 89,
      feedback: 'Sangat baik, jawaban terstruktur.',
      isSubmitted: true,
    ),

    const DetailPenilaianModel(
      id: 'siswa_s8_tugas_2',
      studentName: 'Eka Putri Sari',
      nisn: '0057298',
      kelas: 'XII IPA 2',
      tugasTitle: 'Quiz Integral Substitusi',
      submittedAt: '29 Okt 2026, 16:00',
      attachmentFileName: 'Eka_Integral.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 0,
      feedback: '',
      isSubmitted: true,
    ),

  
    const DetailPenilaianModel(
      id: 'siswa_s1_tugas_4',
      studentName: 'Ahmad Fauzan',
      nisn: '0057301',
      kelas: 'XI IPA 1',
      tugasTitle: 'Latihan Polinomial',
      submittedAt: '29 Okt 2026, 09:30',
      attachmentFileName: 'Ahmad_Fauzan_Polinomial.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 85,
      feedback: 'Metode Horner diterapkan dengan benar.',
      isSubmitted: true,
    ),

    const DetailPenilaianModel(
      id: 'siswa_s2_tugas_4',
      studentName: 'Ananda Aryani',
      nisn: '0057302',
      kelas: 'XI IPA 1',
      tugasTitle: 'Latihan Polinomial',
      submittedAt: '29 Okt 2026, 09:30',
      attachmentFileName: 'Ananda_Aryani_Polinomial.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 0,
      feedback: '',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s3_tugas_4',
      studentName: 'Bagus Akbar',
      nisn: '0057303',
      kelas: 'XI IPA 1',
      tugasTitle: 'Latihan Polinomial',
      submittedAt: '29 Okt 2026, 09:30',
      attachmentFileName: 'Bagus_Akbar_Polinomial.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 93,
      feedback: 'Luar biasa, semua langkah Horner benar.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s4_tugas_4',
      studentName: 'Bunga Pertiwi',
      nisn: '0057304',
      kelas: 'XI IPA 1',
      tugasTitle: 'Latihan Polinomial',
      submittedAt: '29 Okt 2026, 09:30',
      attachmentFileName: 'Bunga_Pertiwi_Polinomial.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 89,
      feedback: 'Penyelesaian rapi dan benar.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s5_tugas_4',
      studentName: 'Candra Aditama',
      nisn: '0057305',
      kelas: 'XI IPA 1',
      tugasTitle: 'Latihan Polinomial',
      submittedAt: '29 Okt 2026, 09:30',
      attachmentFileName: 'Candra_Aditama_Polinomial.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 85,
      feedback: 'Sudah baik.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s6_tugas_4',
      studentName: 'Daffa Rizaldi',
      nisn: '0057306',
      kelas: 'XI IPA 1',
      tugasTitle: 'Latihan Polinomial',
      submittedAt: '29 Okt 2026, 09:30',
      attachmentFileName: 'Daffa_Rizaldi_Polinomial.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 93,
      feedback: 'Sangat teliti.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s7_tugas_4',
      studentName: 'Dewi Lestari',
      nisn: '0057307',
      kelas: 'XI IPA 1',
      tugasTitle: 'Latihan Polinomial',
      submittedAt: '29 Okt 2026, 09:30',
      attachmentFileName: 'Dewi_Lestari_Polinomial.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 89,
      feedback: 'Jawaban lengkap.',
      isSubmitted: true,
    ),
    const DetailPenilaianModel(
      id: 'siswa_s8_tugas_4',
      studentName: 'Eka Putri Sari',
      nisn: '0057308',
      kelas: 'XI IPA 1',
      tugasTitle: 'Latihan Polinomial',
      submittedAt: '29 Okt 2026, 09:30',
      attachmentFileName: 'Eka_Putri_Sari_Polinomial.pdf',
      attachmentPreviewUrl: 'assets/images/preview_dummy.png',
      currentScore: 85,
      feedback: 'Sudah cukup baik.',
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
      // Fallback dinamis — siswa yang belum ada datanya
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
    final updated = _findOrThrow(siswaId, tugasId)
        .copyWith(currentScore: score, feedback: feedback, isSubmitted: true);
    _store[_key(siswaId, tugasId)] = updated;
  }
}
