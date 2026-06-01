import 'package:flutter/material.dart';
import '../models/aktivitas_model.dart';
import '../models/task_summary_model.dart';
import '../models/attendance_overview_model.dart';
import '../../domain/entities/attendance_overview_entity.dart';

abstract class DashboardLocalDatasource {
  Future<List<AktivitasModel>> getAktivitasTerbaru();
  Future<List<TaskSummaryModel>> getTaskSummary();
  Future<List<AttendanceOverviewModel>> getAttendanceOverview();
}

class DashboardLocalDatasourceImpl implements DashboardLocalDatasource {
  @override
  Future<List<AktivitasModel>> getAktivitasTerbaru() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      AktivitasModel(
        tanggal: '08 Mei 2026',
        jam: '07.00',
        deskripsi: 'Login berhasil',
        jenis: 'sistem',
        icon: Icons.login,
      ),
      AktivitasModel(
        tanggal: '08 Mei 2026',
        jam: '13.15',
        deskripsi: 'Logout',
        jenis: 'sistem',
        icon: Icons.logout,
      ),
      AktivitasModel(
        tanggal: '07 Mei 2026',
        jam: '19.00',
        deskripsi: 'Password diubah',
        jenis: 'sistem',
        icon: Icons.lock_outline,
      ),
      AktivitasModel(
        tanggal: '07 Mei 2026',
        jam: '07.00',
        deskripsi: 'Mengisi Absensi XII IPA 1',
        jenis: 'absensi',
        icon: Icons.fact_check_outlined,
      ),
      AktivitasModel(
        tanggal: '07 Mei 2026',
        jam: '08.00',
        deskripsi: 'Mengedit absensi XI DKV 2',
        jenis: 'absensi',
        icon: Icons.edit_note_outlined,
      ),
    ];
  }

  @override
  Future<List<TaskSummaryModel>> getTaskSummary() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      TaskSummaryModel(
        title: 'Tugas Matematika',
        subtitle: 'XII IPA 1',
        countText: '30/30 Siswa',
        dateText: '10 Mei 2026',
        kelas: 'XII IPA 1',
        mataPelajaran: 'Matematika Wajib',
      ),
      TaskSummaryModel(
        title: 'Latihan Integral',
        subtitle: 'XII IPA 1',
        countText: '24/30 Siswa',
        dateText: '12 Mei 2026',
        kelas: 'XII IPA 1',
        mataPelajaran: 'Matematika Wajib',
      ),
      TaskSummaryModel(
        title: 'Quiz Substitusi',
        subtitle: 'XII IPA 2',
        countText: '30/30 Siswa',
        dateText: '15 Mei 2026',
        kelas: 'XII IPA 2',
        mataPelajaran: 'Matematika Wajib',
      ),
    ];
  }

  @override
  Future<List<AttendanceOverviewModel>> getAttendanceOverview() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      AttendanceOverviewModel(
        time: '07:00 - 08:40',
        className: 'XII IPA 1',
        room: 'R.12',
        subject: 'Matematika Wajib',
        status: AttendanceOverviewStatus.done,
        statusText: 'Selesai',
        filledCount: 30,
        totalCount: 30,
      ),
      AttendanceOverviewModel(
        time: '10:00 - 11:40',
        className: 'XII IPA 2',
        room: 'R.13',
        subject: 'Matematika Wajib',
        status: AttendanceOverviewStatus.pending,
        statusText: 'Menunggu',
      ),
      AttendanceOverviewModel(
        time: '07:00 - 09:00',
        className: 'XI IPA 1',
        room: 'R.14',
        subject: 'Matematika Peminatan',
        status: AttendanceOverviewStatus.locked,
        statusText: 'Belum Waktunya',
      ),
    ];
  }
}
