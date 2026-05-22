import '../models/student_attendence_model.dart';

abstract class LaporanAbsensiLocalDatasource {
  Future<List<StudentAttendanceModel>> getStudentAttendance({
    required String monthKey,
    required int page,
    required int perPage,
  });

  Future<int> getTotalStudents({required String monthKey});
}

/// Datasource lokal dengan dummy data per bulan.
class LaporanAbsensiLocalDatasourceImpl implements LaporanAbsensiLocalDatasource {
  static const Map<String, List<StudentAttendanceModel>> _monthlyData = {
    '2026-05': [
      StudentAttendanceModel(
        id: '1',
        nama: 'Ahmad Fauzan',
        nis: '0057281',
        hadir: 18,
        izin: 1,
        sakit: 1,
        dispensasi: 0,
        alfa: 0,
      ),
      StudentAttendanceModel(
        id: '2',
        nama: 'Ananda Aryani',
        nis: '0057282',
        hadir: 20,
        izin: 0,
        sakit: 0,
        dispensasi: 0,
        alfa: 0,
      ),
      StudentAttendanceModel(
        id: '3',
        nama: 'Bagus Akbar',
        nis: '0057283',
        hadir: 15,
        izin: 0,
        sakit: 2,
        dispensasi: 1,
        alfa: 2,
      ),
      StudentAttendanceModel(
        id: '4',
        nama: 'Bunga Pertiwi',
        nis: '0057284',
        hadir: 19,
        izin: 1,
        sakit: 0,
        dispensasi: 1,
        alfa: 0,
      ),
      StudentAttendanceModel(
        id: '5',
        nama: 'Candra Aditama',
        nis: '0057285',
        hadir: 17,
        izin: 2,
        sakit: 1,
        dispensasi: 0,
        alfa: 0,
      ),
    ],
    '2026-04': [
      StudentAttendanceModel(
        id: '1',
        nama: 'Ahmad Fauzan',
        nis: '0057281',
        hadir: 16,
        izin: 1,
        sakit: 1,
        dispensasi: 0,
        alfa: 0,
      ),
      StudentAttendanceModel(
        id: '2',
        nama: 'Ananda Aryani',
        nis: '0057282',
        hadir: 18,
        izin: 0,
        sakit: 1,
        dispensasi: 0,
        alfa: 0,
      ),
      StudentAttendanceModel(
        id: '3',
        nama: 'Bagus Akbar',
        nis: '0057283',
        hadir: 14,
        izin: 1,
        sakit: 2,
        dispensasi: 1,
        alfa: 1,
      ),
      StudentAttendanceModel(
        id: '4',
        nama: 'Bunga Pertiwi',
        nis: '0057284',
        hadir: 17,
        izin: 1,
        sakit: 1,
        dispensasi: 0,
        alfa: 0,
      ),
      StudentAttendanceModel(
        id: '5',
        nama: 'Candra Aditama',
        nis: '0057285',
        hadir: 16,
        izin: 2,
        sakit: 1,
        dispensasi: 1,
        alfa: 0,
      ),
    ],
  };

  @override
  Future<List<StudentAttendanceModel>> getStudentAttendance({
    required String monthKey,
    required int page,
    required int perPage,
  }) async {
    await Future.delayed(const Duration(milliseconds: 550));

    final data = _monthlyData[monthKey] ?? const <StudentAttendanceModel>[];
    if (data.isEmpty) return [];

    final start = (page - 1) * perPage;
    if (start >= data.length) return [];

    final end = (start + perPage).clamp(0, data.length);
    return data.sublist(start, end);
  }

  @override
  Future<int> getTotalStudents({required String monthKey}) async {
    await Future.delayed(const Duration(milliseconds: 120));
    return (_monthlyData[monthKey] ?? const <StudentAttendanceModel>[]).length;
  }
}