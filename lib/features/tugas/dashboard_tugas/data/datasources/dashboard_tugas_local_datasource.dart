import 'package:flutter/foundation.dart';
import '../models/materi_model.dart';
import '../models/tugas_model.dart';

abstract class DashboardTugasLocalDatasource {
  Future<List<MateriModel>> getMateriTerbaru();
  Future<List<TugasModel>> getDaftarTugas();
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
        title: 'Bab 1: Pengenalan',
        category: 'Informatika',
        totalMateri: 12,
        tanggal: 'Okt 2023',
      ),
      const MateriModel(
        id: '2',
        title: 'Bab 2: Struktur Data',
        category: 'Informatika',
        totalMateri: 8,
        tanggal: 'Nov 2023',
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
        kelas: 'XI PPLG 1',
        title: 'Latihan Logika Dasar',
        subtitle: 'Konsep If-Else & Looping',
        deadline: '25 Okt',
        sisaHari: '2 Hari lagi',
        totalAnggota: 28,
        isUrgent: true,
      ),
      const TugasModel(
        id: '2',
        kelas: 'XI PPLG 2',
        title: 'Projek Web Dinamis',
        subtitle: 'Integrasi Database MySQL',
        deadline: '28 Okt',
        sisaHari: '5 Hari lagi',
        totalAnggota: 32,
        isUrgent: false,
      ),
    ];
  }
}
