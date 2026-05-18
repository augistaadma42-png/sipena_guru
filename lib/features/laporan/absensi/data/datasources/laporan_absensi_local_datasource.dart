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
    '2023-10': [
      StudentAttendanceModel(
        id: '1',
        nama: 'Aditya Pratama',
        nis: '1209321',
        hadir: 18,
        izin: 2,
        sakit: 1,
        dispensasi: 0,
        alfa: 0,
      ),
      StudentAttendanceModel(
        id: '2',
        nama: 'Bunga Citra Lestari',
        nis: '1209322',
        hadir: 20,
        izin: 0,
        sakit: 1,
        dispensasi: 0,
        alfa: 0,
      ),
      StudentAttendanceModel(
        id: '3',
        nama: 'Deni Kurniawan',
        nis: '1209323',
        hadir: 15,
        izin: 0,
        sakit: 2,
        dispensasi: 1,
        alfa: 3,
      ),
      StudentAttendanceModel(
        id: '4',
        nama: 'Eka Putri Maharani',
        nis: '1209324',
        hadir: 19,
        izin: 1,
        sakit: 0,
        dispensasi: 1,
        alfa: 0,
      ),
      StudentAttendanceModel(
        id: '5',
        nama: 'Fajar Ramadhan',
        nis: '1209325',
        hadir: 17,
        izin: 2,
        sakit: 2,
        dispensasi: 0,
        alfa: 0,
      ),
    ],
    '2023-11': [
      StudentAttendanceModel(
        id: '1',
        nama: 'Aditya Pratama',
        nis: '1209321',
        hadir: 16,
        izin: 1,
        sakit: 1,
        dispensasi: 0,
        alfa: 1,
      ),
      StudentAttendanceModel(
        id: '2',
        nama: 'Bunga Citra Lestari',
        nis: '1209322',
        hadir: 18,
        izin: 0,
        sakit: 1,
        dispensasi: 0,
        alfa: 1,
      ),
      StudentAttendanceModel(
        id: '3',
        nama: 'Deni Kurniawan',
        nis: '1209323',
        hadir: 14,
        izin: 1,
        sakit: 2,
        dispensasi: 1,
        alfa: 2,
      ),
      StudentAttendanceModel(
        id: '4',
        nama: 'Eka Putri Maharani',
        nis: '1209324',
        hadir: 17,
        izin: 1,
        sakit: 1,
        dispensasi: 0,
        alfa: 1,
      ),
      StudentAttendanceModel(
        id: '5',
        nama: 'Fajar Ramadhan',
        nis: '1209325',
        hadir: 16,
        izin: 2,
        sakit: 1,
        dispensasi: 1,
        alfa: 1,
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