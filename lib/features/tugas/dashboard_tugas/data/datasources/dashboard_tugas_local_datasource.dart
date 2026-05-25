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
  @override
  Future<List<MateriModel>> getMateriTerbaru() async {
    debugPrint('[LocalDatasource] Fetching Materi...');
    await Future.delayed(const Duration(milliseconds: 500));
    return [
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
        title: 'Kinematika Gerak Lurus',
        category: 'Fisika',
        totalMateri: 2,
        tanggal: 'Okt 2026',
        kelas: 'XI IPA 1',
        lampiranCount: 3,
        deskripsi:
            'Konsep dasar gerak lurus beraturan dan gerak lurus berubah beraturan, analisis grafik, dan persamaan kinematika.',
        lampiranNames: [
          'Teori_Kinematika.pdf',
          'Grafik_Contoh.xlsx',
          'Simulasi_Gerak.zip',
        ],
      ),
    ];
  }

  @override
  Future<List<TugasModel>> getDaftarTugas() async {
    debugPrint('[LocalDatasource] Fetching Tugas...');
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const TugasModel(
        id: '1',
        kelas: 'XII IPA 1',
        title: 'Latihan Integral',
        subtitle:
            'Kerjakan soal-soal integral tentu dan tak tentu pada buku paket hal. 45–50. Tunjukkan langkah penyelesaian secara lengkap.',
        deadline: '25 Okt',
        totalAnggota: 38,
        submittedCount: 30,
        gradedCount: 32,
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
        deadline: '10 Apr',
        totalAnggota: 38,
        submittedCount: 38,
        gradedCount: 38,
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
        kelas: 'XII IPA 1',
        title: 'Ulangan Harian Kimia',
        subtitle:
            'Ulangan harian materi ikatan kimia dan bentuk molekul. Siapkan alat tulis.',
        deadline: '1 Nov',
        totalAnggota: 15,
        submittedCount: 8,
        gradedCount: 13,
        createdAt: '28 Okt',
        sisaHari: '9 Hari lagi',
        isUrgent: false,
        isGraded: true,
        jenisNilai: 'Tugas',
        mapel: 'Kimia',
        siswa: 'semua pelajar',
        lampiranCount: 1,
        lampiranNames: ['Materi_Ikatan_Kimia.pdf'],
        judulMateri: 'Ikatan Kimia dan Bentuk Molekul',
      ),
    ];
  }

  @override
  Future<List<Map<String, String>>> getDaftarSiswa(String kelasId) async {
    debugPrint('[LocalDatasource] Fetching Daftar Siswa...');
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      {'absen': '1', 'nisn': '0057281', 'jk': 'L', 'nama': 'Ahmad Fauzan'},
      {'absen': '2', 'nisn': '0057282', 'jk': 'P', 'nama': 'Ananda Aryani'},
      {'absen': '3', 'nisn': '0057283', 'jk': 'L', 'nama': 'Bagus Akbar'},
      {'absen': '4', 'nisn': '0057284', 'jk': 'P', 'nama': 'Bunga Pertiwi'},
      {'absen': '5', 'nisn': '0057285', 'jk': 'L', 'nama': 'Candra Aditama'},
    ];
  }
}
