import '../models/riwayat_absensi_model.dart';
import '../models/student_attendance_model.dart';
import '../models/leave_request_model.dart';

abstract class AbsenLocalDatasource {
  Future<List<RiwayatAbsensiModel>> getRiwayatAbsensi(DateTime? date, String? kelas);
  Future<List<StudentAttendanceModel>> getStudentAttendance(String kelas);
  Future<List<LeaveRequestModel>> getLeaveRequests();
  Future<void> updateLeaveRequestStatus(String id, String status);
}

class AbsenLocalDatasourceImpl implements AbsenLocalDatasource {
  final List<RiwayatAbsensiModel> _riwayatList = [
    RiwayatAbsensiModel(
      id: '1',
      tanggal: DateTime(2026, 5, 4),
      hari: 'Senin',
      kelas: 'XII IPA 1',
      mapel: 'Matematika Wajib',
      jamMulai: '07:00',
      jamSelesai: '08:40',
      jamKe: 'Jam Ke 1-2',
      jumlahHadir: 28,
      totalSiswa: 30,
      lengkap: true,
    ),
    RiwayatAbsensiModel(
      id: '2',
      tanggal: DateTime(2026, 5, 4),
      hari: 'Senin',
      kelas: 'XII IPA 2',
      mapel: 'Matematika Wajib',
      jamMulai: '10:00',
      jamSelesai: '11:40',
      jamKe: 'Jam Ke 5-6',
      jumlahHadir: 30,
      totalSiswa: 30,
      lengkap: true,
    ),
    RiwayatAbsensiModel(
      id: '3',
      tanggal: DateTime(2026, 5, 5),
      hari: 'Selasa',
      kelas: 'XI IPA 1',
      mapel: 'Matematika Peminatan',
      jamMulai: '07:00',
      jamSelesai: '09:00',
      jamKe: 'Jam Ke 1-3',
      jumlahHadir: 27,
      totalSiswa: 30,
      lengkap: false,
    ),
    RiwayatAbsensiModel(
      id: '4',
      tanggal: DateTime(2026, 5, 6),
      hari: 'Rabu',
      kelas: 'XII IPA 2',
      mapel: 'Matematika Wajib',
      jamMulai: '08:20',
      jamSelesai: '09:00',
      jamKe: 'Jam Ke 3',
      jumlahHadir: 30,
      totalSiswa: 30,
      lengkap: true,
    ),
  ];

  final List<StudentAttendanceModel> _studentList = [
    const StudentAttendanceModel(id: 's1', nisn: '0057281', name: 'Ahmad Fauzan', initials: 'AF', status: 'hadir'),
    const StudentAttendanceModel(id: 's2', nisn: '0057282', name: 'Budi Santoso', initials: 'BS', status: 'hadir'),
    const StudentAttendanceModel(id: 's3', nisn: '0057283', name: 'Citra Kirana', initials: 'CK', status: 'hadir'),
    const StudentAttendanceModel(id: 's4', nisn: '0057284', name: 'Dewi Lestari', initials: 'DL', status: 'hadir'),
    const StudentAttendanceModel(id: 's5', nisn: '0057285', name: 'Eka Saputra', initials: 'ES', status: 'hadir'),
  ];

  final List<LeaveRequestModel> _leaveRequests = [
    LeaveRequestModel(
      id: '001',
      studentName: 'Augista A.Z',
      initials: 'AA',
      nisn: '2001001',
      className: 'XI RPL 1',
      type: 'Izin',
      date: DateTime(2024, 5, 24),
      duration: '1 Hari',
      reason: 'Keperluan keluarga mendesak',
      suratAda: true,
      status: 'pending',
    ),
    LeaveRequestModel(
      id: '002',
      studentName: 'Feby Shandi S.',
      initials: 'RS',
      nisn: '2022002',
      className: 'XI RPL 1',
      type: 'Sakit',
      date: DateTime(2024, 5, 24),
      duration: '1 Hari',
      reason: 'Demam dan sakit kepala',
      suratAda: true,
      status: 'pending',
    ),
    LeaveRequestModel(
      id: '003',
      studentName: 'Gavin K.H',
      initials: 'GK',
      nisn: '2022992',
      className: 'XI RPL 2',
      type: 'Dispen',
      date: DateTime(2024, 5, 24),
      duration: '1 Hari',
      reason: 'Mewakili sekolah lomba LKS tingkat provinsi',
      suratAda: true,
      status: 'approved',
    ),
    LeaveRequestModel(
      id: '004',
      studentName: 'Fariskha F.A',
      initials: 'FA',
      nisn: '2001001',
      className: 'X DKV 1',
      type: 'Izin',
      date: DateTime(2024, 5, 21),
      duration: '1 Hari',
      reason: 'Acara pernikahan saudara',
      suratAda: false,
      status: 'rejected',
    ),
    LeaveRequestModel(
      id: '005',
      studentName: 'Devita A.V.P',
      initials: 'DA',
      nisn: '2002991',
      className: 'XI RPL 2',
      type: 'Sakit',
      date: DateTime(2024, 5, 20),
      duration: '1 Hari',
      reason: 'Gastritis kambuh',
      suratAda: true,
      status: 'pending',
    ),
  ];

  @override
  Future<List<RiwayatAbsensiModel>> getRiwayatAbsensi(DateTime? date, String? kelas) async {
    await Future.delayed(const Duration(milliseconds: 300));
    var results = _riwayatList;
    if (date != null) {
      results = results.where((item) =>
          item.tanggal.year == date.year &&
          item.tanggal.month == date.month &&
          item.tanggal.day == date.day).toList();
    }
    if (kelas != null && kelas != 'Semua Kelas') {
      results = results.where((item) => item.kelas == kelas).toList();
    }
    return results;
  }

  @override
  Future<List<StudentAttendanceModel>> getStudentAttendance(String kelas) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _studentList;
  }

  @override
  Future<List<LeaveRequestModel>> getLeaveRequests() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _leaveRequests;
  }

  @override
  Future<void> updateLeaveRequestStatus(String id, String status) async {
    final idx = _leaveRequests.indexWhere((r) => r.id == id);
    if (idx != -1) {
      _leaveRequests[idx] = _leaveRequests[idx].copyWith(status: status);
    }
  }
}
