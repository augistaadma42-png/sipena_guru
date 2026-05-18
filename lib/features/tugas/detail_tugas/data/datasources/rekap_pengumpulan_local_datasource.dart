import 'package:flutter/foundation.dart';
import '../models/assignment_recap_model.dart';
import '../models/assignment_submission_model.dart';

abstract class RekapPengumpulanLocalDatasource {
  Future<AssignmentRecapModel> getAssignmentRecap(String tugasId);
}

class RekapPengumpulanLocalDatasourceImpl
    implements RekapPengumpulanLocalDatasource {

  /// Dummy data berbeda berdasarkan id tugas
  @override
  Future<AssignmentRecapModel> getAssignmentRecap(String tugasId) async {
    debugPrint('[RekapDatasource] Fetching recap for tugasId: $tugasId');
    await Future.delayed(const Duration(milliseconds: 600));

    if (tugasId == '1') {
      return _getRekapTugas1();
    } else if (tugasId == '2') {
      return _getRekapTugas2();
    }

    // Fallback untuk tugas yang tidak dikenal
    return _getRekapTugas1();
  }

  /// Data rekap untuk "Latihan Logika Dasar" (id: 1)
  AssignmentRecapModel _getRekapTugas1() {
    return AssignmentRecapModel(
      id: '1',
      title: 'Latihan Logika Dasar',
      subtitle: 'UTS Semester Ganjil 2023/2024',
      totalStudents: 32,
      submittedCount: 24,
      pendingCount: 8,
      completionPercentage: 75.0,
      lateStudentsCount: 5,
      submissions: [
        const AssignmentSubmissionModel(
          id: 's1',
          studentName: 'Esa Farellio',
          avatar: 'https://i.pravatar.cc/150?u=esa',
          submittedAt: '24 Okt, 08:30',
          fileName: 'Esa_tugas.pdf',
          score: 100,
          isSubmitted: true,
        ),
        const AssignmentSubmissionModel(
          id: 's2',
          studentName: 'Augista Adma Z',
          avatar: 'https://i.pravatar.cc/150?u=augista',
          submittedAt: '23 Okt, 14:15',
          fileName: 'Ara_Project.pdf',
          score: 90,
          isSubmitted: true,
        ),
        const AssignmentSubmissionModel(
          id: 's3',
          studentName: 'Feby Shandy I',
          avatar: 'https://i.pravatar.cc/150?u=feby',
          submittedAt: null,
          fileName: null,
          score: null,
          isSubmitted: false,
        ),
        const AssignmentSubmissionModel(
          id: 's4',
          studentName: 'Devita Aisyah V.P',
          avatar: 'https://i.pravatar.cc/150?u=devita',
          submittedAt: '23 Okt, 14:15',
          fileName: 'Devita_A_VP_tugas.pdf',
          score: null,
          isSubmitted: true,
        ),
        const AssignmentSubmissionModel(
          id: 's5',
          studentName: 'Rizky Maulana',
          avatar: 'https://i.pravatar.cc/150?u=rizky1',
          submittedAt: '22 Okt, 09:00',
          fileName: 'Rizky_logika.pdf',
          score: 85,
          isSubmitted: true,
        ),
      ],
    );
  }

  /// Data rekap untuk "Projek Web Dinamis" (id: 2)
  AssignmentRecapModel _getRekapTugas2() {
    return AssignmentRecapModel(
      id: '2',
      title: 'Projek Web Dinamis',
      subtitle: 'Integrasi Database MySQL',
      totalStudents: 30,
      submittedCount: 18,
      pendingCount: 12,
      completionPercentage: 60.0,
      lateStudentsCount: 3,
      submissions: [
        const AssignmentSubmissionModel(
          id: 's1',
          studentName: 'Bima Sakti',
          avatar: 'https://i.pravatar.cc/150?u=bima',
          submittedAt: '28 Okt, 10:15',
          fileName: 'Bima_WebProject.zip',
          score: 95,
          isSubmitted: true,
        ),
        const AssignmentSubmissionModel(
          id: 's2',
          studentName: 'Nayla Putri',
          avatar: 'https://i.pravatar.cc/150?u=nayla',
          submittedAt: '27 Okt, 16:00',
          fileName: 'Nayla_MySQL_Project.pdf',
          score: 88,
          isSubmitted: true,
        ),
        const AssignmentSubmissionModel(
          id: 's3',
          studentName: 'Dimas Pratama',
          avatar: 'https://i.pravatar.cc/150?u=dimas',
          submittedAt: null,
          fileName: null,
          score: null,
          isSubmitted: false,
        ),
        const AssignmentSubmissionModel(
          id: 's4',
          studentName: 'Sari Indah K',
          avatar: 'https://i.pravatar.cc/150?u=sari',
          submittedAt: null,
          fileName: null,
          score: null,
          isSubmitted: false,
        ),
        const AssignmentSubmissionModel(
          id: 's5',
          studentName: 'Farhan Aditya',
          avatar: 'https://i.pravatar.cc/150?u=farhan',
          submittedAt: '28 Okt, 08:45',
          fileName: 'Farhan_WebDynamic.pdf',
          score: 78,
          isSubmitted: true,
        ),
      ],
    );
  }
}
