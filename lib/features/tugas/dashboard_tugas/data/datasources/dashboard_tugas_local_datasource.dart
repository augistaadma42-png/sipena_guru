import 'package:flutter/foundation.dart';
import '../models/materi_model.dart';
import '../models/tugas_model.dart';

abstract class DashboardTugasLocalDatasource {
  Future<List<MateriModel>> getMateriTerbaru();
  Future<List<TugasModel>> getDaftarTugas();
  Future<List<Map<String, String>>> getDaftarSiswa(String kelasId);
}

class DashboardTugasLocalDatasourceImpl implements DashboardTugasLocalDatasource {
  @override
  Future<List<MateriModel>> getMateriTerbaru() async {
    debugPrint('[LocalDatasource] Fetching Materi...');
    // Simulasi delay network
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const MateriModel(
        id: '1',
        title: 'Integral Tentu dan Tak Tentu',
        category: 'Matematika Wajib',
        totalMateri: 4,
        tanggal: 'Okt 2026',
      ),
      const MateriModel(
        id: '2',
        title: 'Integral Substitusi',
        category: 'Matematika Wajib',
        totalMateri: 3,
        tanggal: 'Nov 2026',
      ),
    ];
  }

  @override
  Future<List<TugasModel>> getDaftarTugas() async {
    debugPrint('[LocalDatasource] Fetching Tugas...');
    // Simulasi delay network
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const TugasModel(
        id: '1',
        kelas: 'XII IPA 1',
        title: 'Latihan Integral',
        subtitle: 'Latihan soal dan penjelasan mengenai integral tentu dan tak tentu',
        deadline: '25 Okt',
        sisaHari: '2 Hari lagi',
        totalAnggota: 30,
        isUrgent: true,
      ),
      const TugasModel(
        id: '2',
        kelas: 'XII IPA 2',
        title: 'Quiz Integral Substitusi',
        subtitle: 'Membahas metode substitusi pada integral',
        deadline: '28 Okt',
        sisaHari: '5 Hari lagi',
        totalAnggota: 30,
        isUrgent: false,
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
