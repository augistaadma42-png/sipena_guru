import '../models/notifikasi_model.dart';
import '../../domain/entities/notifikasi_entity.dart'; // import JenisNotif

abstract class NotifikasiLocalDatasource {
  Future<List<NotifikasiModel>> getNotifikasi();
  Future<void> markAsRead(String id);
  Future<void> markAllAsRead();
}

class NotifikasiLocalDatasourceImpl implements NotifikasiLocalDatasource {
  final List<NotifikasiModel> _dummyData = [
    NotifikasiModel(
      id: '001',
      judul: 'Absensi belum diisi',
      isi: 'Absensi kelas XII IPA 1 belum diisi hari ini.',
      jenis: JenisNotif.absensi,
      waktu: DateTime.now().subtract(const Duration(minutes: 10)),
      dibaca: false,
    ),
    NotifikasiModel(
      id: '002',
      judul: 'Tugas dikumpulkan',
      isi: 'Ahmad Fauzan telah mengumpulkan tugas Latihan Integral.',
      jenis: JenisNotif.tugasKumpul,
      waktu: DateTime.now().subtract(const Duration(hours: 1)),
      dibaca: false,
    ),
    NotifikasiModel(
      id: '003',
      judul: 'Tugas belum dinilai',
      isi: 'Tugas Latihan Integral XII IPA 1 belum dinilai — deadline sudah lewat.',
      jenis: JenisNotif.tugasBelumDinilai,
      waktu: DateTime.now().subtract(const Duration(hours: 3)),
      dibaca: false,
    ),
    NotifikasiModel(
      id: '004',
      judul: 'Pengajuan tidak masuk',
      isi: 'Terdapat pengajuan tidak masuk dari Ahmad Fauzan (XII IPA 1) — Sakit.',
      jenis: JenisNotif.pengajuan,
      waktu: DateTime.now().subtract(const Duration(hours: 5)),
      dibaca: false,
    ),
    NotifikasiModel(
      id: '005',
      judul: 'Absensi belum diisi',
      isi: 'Absensi kelas XII IPA 2 belum diisi hari ini.',
      jenis: JenisNotif.absensi,
      waktu: DateTime.now().subtract(const Duration(days: 1)),
      dibaca: true,
    ),
    NotifikasiModel(
      id: '006',
      judul: 'Pengajuan tidak masuk',
      isi: 'Terdapat pengajuan tidak masuk dari Ananda Aryani (XII IPA 1) — Izin.',
      jenis: JenisNotif.pengajuan,
      waktu: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      dibaca: true,
    ),
    NotifikasiModel(
      id: '007',
      judul: 'Tugas belum dinilai',
      isi: 'Tugas Quiz Integral Substitusi XII IPA 2 belum dinilai — deadline sudah lewat.',
      jenis: JenisNotif.tugasBelumDinilai,
      waktu: DateTime.now().subtract(const Duration(days: 2)),
      dibaca: true,
    ),
  ];

  @override
  Future<List<NotifikasiModel>> getNotifikasi() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _dummyData;
  }

  @override
  Future<void> markAsRead(String id) async {
    final idx = _dummyData.indexWhere((n) => n.id == id);
    if (idx != -1) {
      _dummyData[idx] = _dummyData[idx].copyWith(dibaca: true);
    }
  }

  @override
  Future<void> markAllAsRead() async {
    for (int i = 0; i < _dummyData.length; i++) {
      _dummyData[i] = _dummyData[i].copyWith(dibaca: true);
    }
  }
}
