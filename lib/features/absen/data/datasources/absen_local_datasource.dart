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
  static final List<RiwayatAbsensiModel> _riwayatList = [
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

  static final List<StudentAttendanceModel> _studentList = [
    const StudentAttendanceModel(id: 's1', nisn: '0057281', name: 'Ahmad Fauzan', initials: 'AF', status: 'hadir'),
    const StudentAttendanceModel(id: 's2', nisn: '0057282', name: 'Ananda Aryani', initials: 'AA', status: 'hadir'),
    const StudentAttendanceModel(id: 's3', nisn: '0057283', name: 'Bagus Akbar', initials: 'BA', status: 'hadir'),
    const StudentAttendanceModel(id: 's4', nisn: '0057284', name: 'Bunga Pertiwi', initials: 'BP', status: 'hadir'),
    const StudentAttendanceModel(id: 's5', nisn: '0057285', name: 'Candra Aditama', initials: 'CA', status: 'hadir'),
    const StudentAttendanceModel(id: 's6', nisn: '0057286', name: 'Daffa Rizaldi', initials: 'DR', status: 'hadir'),
    const StudentAttendanceModel(id: 's7', nisn: '0057287', name: 'Dewi Lestari', initials: 'DL', status: 'hadir'),
    const StudentAttendanceModel(id: 's8', nisn: '0057288', name: 'Eka Putri Sari', initials: 'EP', status: 'hadir'),
    const StudentAttendanceModel(id: 's9', nisn: '0057289', name: 'Fajar Nugroho', initials: 'FN', status: 'hadir'),
    const StudentAttendanceModel(id: 's10', nisn: '0057290', name: 'Gita Maharani', initials: 'GM', status: 'hadir'),
    const StudentAttendanceModel(id: 's11', nisn: '0057291', name: 'Hendra Wijaya', initials: 'HW', status: 'hadir'),
    const StudentAttendanceModel(id: 's12', nisn: '0057292', name: 'Indah Permata', initials: 'IP', status: 'hadir'),
    const StudentAttendanceModel(id: 's13', nisn: '0057293', name: 'Joko Susilo', initials: 'JS', status: 'hadir'),
    const StudentAttendanceModel(id: 's14', nisn: '0057294', name: 'Kartika Putri', initials: 'KP', status: 'hadir'),
    const StudentAttendanceModel(id: 's15', nisn: '0057295', name: 'Lutfi Hakim', initials: 'LH', status: 'hadir'),
    const StudentAttendanceModel(id: 's16', nisn: '0057296', name: 'Muhammad Rafli', initials: 'MR', status: 'hadir'),
    const StudentAttendanceModel(id: 's17', nisn: '0057297', name: 'Nabila Syifa', initials: 'NS', status: 'hadir'),
    const StudentAttendanceModel(id: 's18', nisn: '0057298', name: 'Olivia Rian', initials: 'OR', status: 'hadir'),
    const StudentAttendanceModel(id: 's19', nisn: '0057299', name: 'Putra Pratama', initials: 'PP', status: 'hadir'),
    const StudentAttendanceModel(id: 's20', nisn: '0057300', name: 'Qori Aina', initials: 'QA', status: 'hadir'),
    const StudentAttendanceModel(id: 's21', nisn: '0057301', name: 'Rian Hidayat', initials: 'RH', status: 'hadir'),
    const StudentAttendanceModel(id: 's22', nisn: '0057302', name: 'Siti Aminah', initials: 'SA', status: 'hadir'),
    const StudentAttendanceModel(id: 's23', nisn: '0057303', name: 'Taufik Hidayat', initials: 'TH', status: 'hadir'),
    const StudentAttendanceModel(id: 's24', nisn: '0057304', name: 'Umi Aminah', initials: 'UA', status: 'hadir'),
    const StudentAttendanceModel(id: 's25', nisn: '0057305', name: 'Vina Panduwinata', initials: 'VP', status: 'hadir'),
    const StudentAttendanceModel(id: 's26', nisn: '0057306', name: 'Wahyu Hidayat', initials: 'WH', status: 'hadir'),
    const StudentAttendanceModel(id: 's27', nisn: '0057307', name: 'Xena Clarissa', initials: 'XC', status: 'hadir'),
    const StudentAttendanceModel(id: 's28', nisn: '0057308', name: 'Yeni Wahid', initials: 'YW', status: 'hadir'),
    const StudentAttendanceModel(id: 's29', nisn: '0057309', name: 'Zulfikar Ali', initials: 'ZA', status: 'hadir'),
    const StudentAttendanceModel(id: 's30', nisn: '0057310', name: 'Zaki Mubarak', initials: 'ZM', status: 'hadir'),
  ];

  static final List<LeaveRequestModel> _leaveRequests = [
    LeaveRequestModel(
      id: '001',
      studentName: 'Ananda Aryani',
      initials: 'AA',
      nisn: '0057282',
      className: 'XII IPA 1',
      type: 'Izin',
      date: DateTime(2026, 5, 24),
      duration: '1 Hari',
      reason: 'Keperluan keluarga mendesak',
      suratAda: true,
      status: 'pending',
    ),
    LeaveRequestModel(
      id: '002',
      studentName: 'Bagus Akbar',
      initials: 'BA',
      nisn: '0057283',
      className: 'XI IPA 1',
      type: 'Sakit',
      date: DateTime(2026, 5, 24),
      duration: '1 Hari',
      reason: 'Demam dan sakit kepala',
      suratAda: true,
      status: 'pending',
    ),
    LeaveRequestModel(
      id: '003',
      studentName: 'Bunga Pertiwi',
      initials: 'BP',
      nisn: '0057284',
      className: 'XII IPA 2',
      type: 'Dispen',
      date: DateTime(2026, 5, 24),
      duration: '1 Hari',
      reason: 'Mewakili sekolah lomba LKS tingkat provinsi',
      suratAda: true,
      status: 'approved',
    ),
    LeaveRequestModel(
      id: '004',
      studentName: 'Ahmad Fauzan',
      initials: 'AF',
      nisn: '0057281',
      className: 'XII IPA 1',
      type: 'Izin',
      date: DateTime(2026, 5, 21),
      duration: '1 Hari',
      reason: 'Acara pernikahan saudara',
      suratAda: false,
      status: 'rejected',
    ),
    LeaveRequestModel(
      id: '005',
      studentName: 'Candra Aditama',
      initials: 'CA',
      nisn: '0057285',
      className: 'XI IPA 1',
      type: 'Sakit',
      date: DateTime(2026, 5, 20),
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

  static void addRiwayat(RiwayatAbsensiModel item) {
    _riwayatList.insert(0, item);
  }
}
