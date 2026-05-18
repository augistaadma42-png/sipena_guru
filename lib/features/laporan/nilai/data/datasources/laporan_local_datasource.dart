import '../models/student_nilai_model.dart';

/// Abstract interface datasource lokal
abstract class LaporanLocalDatasource {
  Future<List<StudentNilaiModel>> getStudentNilai({
    required int page,
    required int perPage,
  });

  Future<int> getTotalSiswa();
}

/// Implementasi datasource dengan dummy data lokal
class LaporanLocalDatasourceImpl implements LaporanLocalDatasource {
  /// Dummy data 32 siswa (sesuai desain referensi total 32 siswa)
  static final List<StudentNilaiModel> _allStudents = [
    const StudentNilaiModel(
      id: '1',
      nama: 'Aditya Pratama',
      kelas: 'XII MIPA 4',
      tanggalInput: '24 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '2',
      nama: 'Bunga Citra Lestari',
      kelas: 'XII MIPA 4',
      tanggalInput: '24 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '3',
      nama: 'Dedi Kurniawan',
      kelas: 'XII MIPA 4',
      tanggalInput: '25 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '4',
      nama: 'Eka Sari Putri',
      kelas: 'XII MIPA 4',
      tanggalInput: '25 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '5',
      nama: 'Fahmi Azhar',
      kelas: 'XII MIPA 4',
      tanggalInput: '25 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '6',
      nama: 'Gita Rahayu',
      kelas: 'XII MIPA 4',
      tanggalInput: '26 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '7',
      nama: 'Hendra Saputra',
      kelas: 'XII MIPA 4',
      tanggalInput: '26 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '8',
      nama: 'Indah Permata',
      kelas: 'XII MIPA 4',
      tanggalInput: '26 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '9',
      nama: 'Joko Widodo',
      kelas: 'XII MIPA 4',
      tanggalInput: '27 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '10',
      nama: 'Kartika Sari',
      kelas: 'XII MIPA 4',
      tanggalInput: '27 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '11',
      nama: 'Lukman Hakim',
      kelas: 'XII MIPA 4',
      tanggalInput: '27 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '12',
      nama: 'Maya Anggraini',
      kelas: 'XII MIPA 4',
      tanggalInput: '28 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '13',
      nama: 'Nanda Rizky',
      kelas: 'XII MIPA 4',
      tanggalInput: '28 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '14',
      nama: 'Oscar Pratama',
      kelas: 'XII MIPA 4',
      tanggalInput: '28 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '15',
      nama: 'Putri Andini',
      kelas: 'XII MIPA 4',
      tanggalInput: '29 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '16',
      nama: 'Qori Rahmawan',
      kelas: 'XII MIPA 4',
      tanggalInput: '29 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '17',
      nama: 'Rizki Firmansyah',
      kelas: 'XII MIPA 4',
      tanggalInput: '29 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '18',
      nama: 'Sari Dewi',
      kelas: 'XII MIPA 4',
      tanggalInput: '30 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '19',
      nama: 'Taufik Hidayat',
      kelas: 'XII MIPA 4',
      tanggalInput: '30 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '20',
      nama: 'Umi Kalsum',
      kelas: 'XII MIPA 4',
      tanggalInput: '30 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '21',
      nama: 'Vina Melati',
      kelas: 'XII MIPA 4',
      tanggalInput: '31 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '22',
      nama: 'Wahyu Setiawan',
      kelas: 'XII MIPA 4',
      tanggalInput: '31 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '23',
      nama: 'Xena Putri',
      kelas: 'XII MIPA 4',
      tanggalInput: '31 Okt 2023',
    ),
    const StudentNilaiModel(
      id: '24',
      nama: 'Yoga Pratama',
      kelas: 'XII MIPA 4',
      tanggalInput: '01 Nov 2023',
    ),
    const StudentNilaiModel(
      id: '25',
      nama: 'Zara Aulia',
      kelas: 'XII MIPA 4',
      tanggalInput: '01 Nov 2023',
    ),
    const StudentNilaiModel(
      id: '26',
      nama: 'Agus Santoso',
      kelas: 'XII MIPA 4',
      tanggalInput: '01 Nov 2023',
    ),
    const StudentNilaiModel(
      id: '27',
      nama: 'Bintang Ramadhan',
      kelas: 'XII MIPA 4',
      tanggalInput: '02 Nov 2023',
    ),
    const StudentNilaiModel(
      id: '28',
      nama: 'Cahya Nugraha',
      kelas: 'XII MIPA 4',
      tanggalInput: '02 Nov 2023',
    ),
    const StudentNilaiModel(
      id: '29',
      nama: 'Diana Lestari',
      kelas: 'XII MIPA 4',
      tanggalInput: '02 Nov 2023',
    ),
    const StudentNilaiModel(
      id: '30',
      nama: 'Ervan Wahyudi',
      kelas: 'XII MIPA 4',
      tanggalInput: '03 Nov 2023',
    ),
    const StudentNilaiModel(
      id: '31',
      nama: 'Fitri Rahayu',
      kelas: 'XII MIPA 4',
      tanggalInput: '03 Nov 2023',
    ),
    const StudentNilaiModel(
      id: '32',
      nama: 'Galih Prabowo',
      kelas: 'XII MIPA 4',
      tanggalInput: '03 Nov 2023',
    ),
  ];

  @override
  Future<List<StudentNilaiModel>> getStudentNilai({
    required int page,
    required int perPage,
  }) async {
    // Simulasi network delay
    await Future.delayed(const Duration(milliseconds: 600));

    final startIndex = (page - 1) * perPage;
    final endIndex = (startIndex + perPage).clamp(0, _allStudents.length);

    if (startIndex >= _allStudents.length) return [];

    return _allStudents.sublist(startIndex, endIndex);
  }

  @override
  Future<int> getTotalSiswa() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _allStudents.length;
  }
}