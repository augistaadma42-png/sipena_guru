import 'package:flutter/foundation.dart';
import '../models/kelas_diampu_model.dart';

abstract class DaftarKelasLocalDatasource {
  Future<List<KelasDiampuModel>> getDaftarKelas();
}

class DaftarKelasLocalDatasourceImpl implements DaftarKelasLocalDatasource {
  @override
  Future<List<KelasDiampuModel>> getDaftarKelas() async {
    debugPrint('[LocalDatasource] Fetching Daftar Kelas...');
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const KelasDiampuModel(
        id: '1',
        namaKelas: 'XI RPL 1',
        namaMapel: 'Sejarah Indonesia',
      ),
      const KelasDiampuModel(
        id: '2',
        namaKelas: 'XI RPL 2',
        namaMapel: 'PKN',
      ),
      const KelasDiampuModel(
        id: '3',
        namaKelas: 'XII TKJ 1',
        namaMapel: 'Matematika',
      ),
    ];
  }
}
