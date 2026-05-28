import 'package:flutter/foundation.dart';
import '../models/materi_model.dart';
import '../models/tugas_model.dart';

abstract class DashboardTugasLocalDatasource {
  Future<List<MateriModel>> getMateriTerbaru();
  Future<List<TugasModel>> getDaftarTugas();
  Future<List<Map<String, String>>> getDaftarSiswa(String kelasId);
}

class DashboardTugasLocalDatasourceImpl
    implements DashboardTugasLocalDatasource {

  // Bridged In-Memory DB lists
  static final List<MateriModel> _materiList = [
    const MateriModel(
      id: '1',
      title: 'Integral Tentu dan Tak Tentu',
      category: 'Matematika Wajib',
      totalMateri: 4,
      tanggal: 'Okt 2026',
      kelas: 'XII IPA 1',
      lampiranCount: 2,
      deskripsi:
          'Pembahasan lengkap tentang integral tentu dan tak tentu, termasuk metode substitusi, parsial, dan penggunaan tabel integral.',
      lampiranNames: ['Ringkasan_Integral.pdf', 'Contoh_Soal.docx'],
    ),
    const MateriModel(
      id: '2',
      title: 'Integral Substitusi',
      category: 'Matematika Wajib',
      totalMateri: 3,
      tanggal: 'Nov 2026',
      kelas: 'XII IPA 2',
      lampiranCount: 1,
      deskripsi:
          'Fokus pada teknik substitusi dalam menyelesaikan integral kompleks dengan berbagai contoh kasus nyata.',
      lampiranNames: ['Video_Tutorial.mp4'],
    ),
    const MateriModel(
      id: '3',
      title: 'Polinomial dan Suku Banyak',
      category: 'Matematika Peminatan',
      totalMateri: 2,
      tanggal: 'Okt 2026',
      kelas: 'XI IPA 1',
      lampiranCount: 2,
      deskripsi:
          'Membahas tentang konsep suku banyak, pembagian polinomial dengan metode Horner, dan teorema sisa.',
      lampiranNames: ['Teori_Polinomial.pdf', 'Latihan_Horner.xlsx'],
    ),
  ];

  static final List<TugasModel> _tugasList = [
    const TugasModel(
      id: '1',
      kelas: 'XII IPA 1',
      title: 'Latihan Integral',
      subtitle:
          'Kerjakan soal-soal integral tentu dan tak tentu pada buku paket hal. 45–50. Tunjukkan langkah penyelesaian secara lengkap.',
      deadline: '25 Okt 12:00',
      totalAnggota: 30,
      submittedCount: 24,
      gradedCount: 24,
      createdAt: '20 Okt',
      sisaHari: '2 Hari lagi',
      isUrgent: true,
      isGraded: true,
      jenisNilai: 'Tugas',
      mapel: 'Matematika Wajib',
      siswa: 'Semua pelajar',
      lampiranCount: 2,
      lampiranNames: ['Soal_Latihan.pdf', 'Kunci_Jawaban.pdf'],
      judulMateri: 'Integral Tentu dan Tak Tentu',
    ),
    const TugasModel(
      id: '2',
      kelas: 'XII IPA 2',
      title: 'Quiz Integral Substitusi',
      subtitle:
          'Quiz online membahas metode substitusi pada integral. Dikerjakan mandiri tanpa membuka catatan.',
      deadline: '10 Apr 23:59',
      totalAnggota: 30,
      submittedCount: 30,
      gradedCount: 30,
      createdAt: '1 Apr',
      sisaHari: 'Kadaluarsa',
      isUrgent: false,
      isGraded: true,
      jenisNilai: 'Tugas',
      mapel: 'Matematika Wajib',
      siswa: 'Semua pelajar',
      lampiranCount: 0,
      lampiranNames: [],
      judulMateri: 'Integral Substitusi',
    ),
    const TugasModel(
      id: '4',
      kelas: 'XI IPA 1',
      title: 'Latihan Polinomial',
      subtitle:
          'Kerjakan soal latihan pembagian polinomial menggunakan metode pembagian bersusun dan Horner.',
      deadline: '01 Nov 10:00',
      totalAnggota: 30,
      submittedCount: 8,
      gradedCount: 8,
      createdAt: '28 Okt',
      sisaHari: '9 Hari lagi',
      isUrgent: false,
      isGraded: true,
      jenisNilai: 'Tugas',
      mapel: 'Matematika Peminatan',
      siswa: 'Semua pelajar',
      lampiranCount: 1,
      lampiranNames: ['Latihan_SukuBanyak.pdf'],
      judulMateri: 'Polinomial dan Suku Banyak',
    ),
  ];

  @override
  Future<List<MateriModel>> getMateriTerbaru() async {
    debugPrint('[LocalDatasource] Fetching Materi...');
    await Future.delayed(const Duration(milliseconds: 500));
    return List.unmodifiable(_materiList);
  }

  @override
  Future<List<TugasModel>> getDaftarTugas() async {
    debugPrint('[LocalDatasource] Fetching Tugas...');
    await Future.delayed(const Duration(milliseconds: 500));
    return List.unmodifiable(_tugasList);
  }

  @override
  Future<List<Map<String, String>>> getDaftarSiswa(String kelasId) async {
    debugPrint('[LocalDatasource] Fetching Daftar Siswa...');
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      {'absen': '1', 'nisn': '0057281', 'jk': 'L', 'nama': 'Ahmad Fauzan'},
      {'absen': '2', 'nisn': '0057282', 'jk': 'P', 'nama': 'Ananda Aryani'},
      {'absen': '3', 'nisn': '0057283', 'jk': 'L', 'nama': 'Bagus Akbar'},
      {'absen': '4', 'nisn': '0057284', 'jk': 'P', 'nama': 'Bunga Pertiwi'},
      {'absen': '5', 'nisn': '0057285', 'jk': 'L', 'nama': 'Candra Aditama'},
      {'absen': '6', 'nisn': '0057286', 'jk': 'L', 'nama': 'Daffa Rizaldi'},
      {'absen': '7', 'nisn': '0057287', 'jk': 'P', 'nama': 'Dewi Lestari'},
      {'absen': '8', 'nisn': '0057288', 'jk': 'P', 'nama': 'Eka Putri Sari'},
      {'absen': '9', 'nisn': '0057289', 'jk': 'L', 'nama': 'Fajar Nugroho'},
      {'absen': '10', 'nisn': '0057290', 'jk': 'P', 'nama': 'Gita Maharani'},
      {'absen': '11', 'nisn': '0057291', 'jk': 'L', 'nama': 'Hendra Wijaya'},
      {'absen': '12', 'nisn': '0057292', 'jk': 'P', 'nama': 'Indah Permata'},
      {'absen': '13', 'nisn': '0057293', 'jk': 'L', 'nama': 'Joko Susilo'},
      {'absen': '14', 'nisn': '0057294', 'jk': 'P', 'nama': 'Kartika Putri'},
      {'absen': '15', 'nisn': '0057295', 'jk': 'L', 'nama': 'Lutfi Hakim'},
      {'absen': '16', 'nisn': '0057296', 'jk': 'L', 'nama': 'Muhammad Rafli'},
      {'absen': '17', 'nisn': '0057297', 'jk': 'P', 'nama': 'Nabila Syifa'},
      {'absen': '18', 'nisn': '0057298', 'jk': 'P', 'nama': 'Olivia Rian'},
      {'absen': '19', 'nisn': '0057299', 'jk': 'L', 'nama': 'Putra Pratama'},
      {'absen': '20', 'nisn': '0057300', 'jk': 'P', 'nama': 'Qori Aina'},
      {'absen': '21', 'nisn': '0057301', 'jk': 'L', 'nama': 'Rian Hidayat'},
      {'absen': '22', 'nisn': '0057302', 'jk': 'P', 'nama': 'Siti Aminah'},
      {'absen': '23', 'nisn': '0057303', 'jk': 'L', 'nama': 'Taufik Hidayat'},
      {'absen': '24', 'nisn': '0057304', 'jk': 'P', 'nama': 'Umi Aminah'},
      {'absen': '25', 'nisn': '0057305', 'jk': 'P', 'nama': 'Vina Panduwinata'},
      {'absen': '26', 'nisn': '0057306', 'jk': 'L', 'nama': 'Wahyu Hidayat'},
      {'absen': '27', 'nisn': '0057307', 'jk': 'P', 'nama': 'Xena Clarissa'},
      {'absen': '28', 'nisn': '0057308', 'jk': 'P', 'nama': 'Yeni Wahid'},
      {'absen': '29', 'nisn': '0057309', 'jk': 'L', 'nama': 'Zulfikar Ali'},
      {'absen': '30', 'nisn': '0057310', 'jk': 'L', 'nama': 'Zaki Mubarak'},
    ];
  }

  // Bridging helpers
  static List<MateriModel> getMateriListSync() {
    return _materiList;
  }
}
