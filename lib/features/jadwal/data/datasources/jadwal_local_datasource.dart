import '../models/jadwal_slot_model.dart';
import '../models/jam_slot_model.dart';

abstract class JadwalLocalDatasource {
  Future<List<JamSlotModel>> getJamSlots();
  Future<List<JadwalSlotModel>> getJadwalPelajaran();
}

class JadwalLocalDatasourceImpl implements JadwalLocalDatasource {
  @override
  Future<List<JamSlotModel>> getJamSlots() async {
    // Simulasi penundaan jaringan
    await Future.delayed(const Duration(milliseconds: 200));
    return const [
      JamSlotModel(label: '1',  jamSenKam: '07:00 - 07:40', jamJumat: '07:00 - 07:30'),
      JamSlotModel(label: '2',  jamSenKam: '07:40 - 08:20', jamJumat: '07:30 - 08:00'),
      JamSlotModel(label: '3',  jamSenKam: '08:20 - 09:00', jamJumat: '08:00 - 08:30'),
      JamSlotModel(label: '4',  jamSenKam: '09:00 - 09:40', jamJumat: '08:30 - 09:00'),
      JamSlotModel(label: 'Istirahat', jamSenKam: '09:40 - 10:00', jamJumat: '09:00 - 09:30', isIstirahat: true),
      JamSlotModel(label: '5',  jamSenKam: '10:00 - 10:40', jamJumat: '09:30 - 09:50'),
      JamSlotModel(label: '6',  jamSenKam: '10:40 - 11:20', jamJumat: '09:50 - 10:20'),
      JamSlotModel(label: '7',  jamSenKam: '11:20 - 12:00', jamJumat: '10:20 - 10:50'),
      JamSlotModel(label: 'Istirahat', jamSenKam: '12:00 - 13:00', jamJumat: '11:20 - 13:00', isIstirahat: true),
      JamSlotModel(label: '8',  jamSenKam: '13:00 - 13:40', jamJumat: '13:00 - 13:30'),
      JamSlotModel(label: '9',  jamSenKam: '13:40 - 14:20', jamJumat: '13:30 - 14:00'),
      JamSlotModel(label: '10', jamSenKam: '14:20 - 15:00', jamJumat: '14:00 - 14:30'),
      JamSlotModel(label: '11', jamSenKam: '-',              jamJumat: '14:30 - 15:00'),
      JamSlotModel(label: '12', jamSenKam: '-',              jamJumat: '14:30 - 15:00'),
    ];
  }

  @override
  Future<List<JadwalSlotModel>> getJadwalPelajaran() async {
    // Simulasi penundaan jaringan
    await Future.delayed(const Duration(milliseconds: 200));
    return const [
      JadwalSlotModel(hari: 'Senin',  jamKe: 1,  mapel: 'Matematika Wajib', kelas: 'XII IPA 1', ruang: 'R.12'),
      JadwalSlotModel(hari: 'Senin',  jamKe: 2,  mapel: 'Matematika Wajib', kelas: 'XII IPA 1', ruang: 'R.12'),
      JadwalSlotModel(hari: 'Senin',  jamKe: 5,  mapel: 'Matematika Wajib', kelas: 'XII IPA 2', ruang: 'R.13'),
      JadwalSlotModel(hari: 'Senin',  jamKe: 6,  mapel: 'Matematika Wajib', kelas: 'XII IPA 2', ruang: 'R.13'),
      JadwalSlotModel(hari: 'Selasa', jamKe: 1,  mapel: 'Matematika Peminatan', kelas: 'XI IPA 1', ruang: 'R.14'),
      JadwalSlotModel(hari: 'Selasa', jamKe: 2,  mapel: 'Matematika Peminatan', kelas: 'XI IPA 1', ruang: 'R.14'),
      JadwalSlotModel(hari: 'Selasa', jamKe: 3,  mapel: 'Matematika Peminatan', kelas: 'XI IPA 1', ruang: 'R.14'),
      JadwalSlotModel(hari: 'Selasa', jamKe: 5,  mapel: 'Matematika Wajib', kelas: 'XII IPA 1', ruang: 'R.12'),
      JadwalSlotModel(hari: 'Rabu',   jamKe: 3,  mapel: 'Matematika Wajib', kelas: 'XII IPA 2', ruang: 'R.13'),
      JadwalSlotModel(hari: 'Kamis',  jamKe: 1,  mapel: 'Matematika Peminatan', kelas: 'XI IPA 1', ruang: 'R.14'),
      JadwalSlotModel(hari: 'Kamis',  jamKe: 2,  mapel: 'Matematika Peminatan', kelas: 'XI IPA 1', ruang: 'R.14'),
      JadwalSlotModel(hari: 'Jumat',  jamKe: 1,  mapel: 'Matematika Wajib', kelas: 'XII IPA 1', ruang: 'R.12'),
      JadwalSlotModel(hari: 'Jumat',  jamKe: 2,  mapel: 'Matematika Wajib', kelas: 'XII IPA 1', ruang: 'R.12'),
      JadwalSlotModel(hari: 'Jumat',  jamKe: 5,  mapel: 'Matematika Wajib', kelas: 'XII IPA 2', ruang: 'R.13'),
      JadwalSlotModel(hari: 'Jumat',  jamKe: 6,  mapel: 'Matematika Wajib', kelas: 'XII IPA 2', ruang: 'R.13'),
    ];
  }
}
