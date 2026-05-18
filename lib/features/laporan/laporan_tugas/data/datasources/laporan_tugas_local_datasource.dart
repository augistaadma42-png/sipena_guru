import '../models/assignment_model.dart';
import '../models/student_assignment_model.dart';
import '../../domain/entities/assignment_entity.dart';

/// Local datasource dengan dummy data sesuai desain referensi
class LaporanTugasLocalDatasource {
  /// Mengembalikan list dummy tugas berdasarkan filter
  Future<List<AssignmentModel>> getAssignmentReport({
    required String bulan,
    required String kelas,
    required String mataPelajaran,
  }) async {
    // Simulasi network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // Dummy data — Tugas 1
    final tugas1 = AssignmentModel(
      id: 'tugas_001',
      title: 'Integral Tentu dan Tak Tentu',
      subtitle: 'Latihan Soal Halaman 45-50',
      date: '12 Okt 2023',
      priority: AssignmentPriority.high,
      unsubmittedCount: 5,
      students: const [
        StudentAssignmentModel(
          id: 'std_001',
          nama: 'Aditya Dharmawan',
          initials: 'AD',
          submitted: false,
        ),
        StudentAssignmentModel(
          id: 'std_002',
          nama: 'Bima Pratama',
          initials: 'BP',
          submitted: false,
        ),
        StudentAssignmentModel(
          id: 'std_003',
          nama: 'Citra Rahayu',
          initials: 'CR',
          submitted: false,
        ),
        StudentAssignmentModel(
          id: 'std_004',
          nama: 'Deni Kurniawan',
          initials: 'DK',
          submitted: false,
        ),
        StudentAssignmentModel(
          id: 'std_005',
          nama: 'Erlita Sari',
          initials: 'ES',
          submitted: false,
        ),
      ],
    );

    // Dummy data — Tugas 2
    final tugas2 = AssignmentModel(
      id: 'tugas_002',
      title: 'Turunan Fungsi Trigonometri',
      subtitle: 'Tugas Mandiri Video Penjelasan',
      date: '05 Okt 2023',
      priority: AssignmentPriority.regular,
      unsubmittedCount: 2,
      students: const [
        StudentAssignmentModel(
          id: 'std_006',
          nama: 'Diana Nuraini',
          initials: 'DN',
          submitted: false,
        ),
        StudentAssignmentModel(
          id: 'std_007',
          nama: 'Eko Susanto',
          initials: 'ES',
          submitted: false,
        ),
      ],
    );

    return [tugas1, tugas2];
  }
}
