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

  /// Data rekap untuk "Latihan Integral" (id: 1)
  AssignmentRecapModel _getRekapTugas1() {
    return AssignmentRecapModel(
      id: '1',
      title: 'Latihan Integral',
      subtitle: 'Latihan soal integral tentu dan tak tentu - XII IPA 1',
      totalStudents: 30,
      submittedCount: 24,
      pendingCount: 6,
      completionPercentage: 80.0,
      lateStudentsCount: 3,
      submissions: [
        const AssignmentSubmissionModel(
          id: 's1',
          studentName: 'Ahmad Fauzan',
          avatar: 'https://i.pravatar.cc/150?u=ahmad',
          submittedAt: '24 Okt, 08:30',
          fileName: 'Ahmad_Fauzan_Integral.pdf',
          score: 95,
          isSubmitted: true,
        ),
        const AssignmentSubmissionModel(
          id: 's2',
          studentName: 'Ananda Aryani',
          avatar: 'https://i.pravatar.cc/150?u=ananda',
          submittedAt: '23 Okt, 14:15',
          fileName: 'Ananda_Integral.pdf',
          score: 90,
          isSubmitted: true,
        ),
        const AssignmentSubmissionModel(
          id: 's3',
          studentName: 'Bagus Akbar',
          avatar: 'https://i.pravatar.cc/150?u=bagus',
          submittedAt: null,
          fileName: null,
          score: null,
          isSubmitted: false,
        ),
        const AssignmentSubmissionModel(
          id: 's4',
          studentName: 'Bunga Pertiwi',
          avatar: 'https://i.pravatar.cc/150?u=bunga',
          submittedAt: '23 Okt, 14:15',
          fileName: 'Bunga_Integral.pdf',
          score: null,
          isSubmitted: true,
        ),
        const AssignmentSubmissionModel(
          id: 's5',
          studentName: 'Candra Aditama',
          avatar: 'https://i.pravatar.cc/150?u=candra',
          submittedAt: '22 Okt, 09:00',
          fileName: 'Candra_Integral.pdf',
          score: 85,
          isSubmitted: true,
        ),
      ],
    );
  }

  /// Data rekap untuk "Quiz Integral Substitusi" (id: 2)
  AssignmentRecapModel _getRekapTugas2() {
    return AssignmentRecapModel(
      id: '2',
      title: 'Quiz Integral Substitusi',
      subtitle: 'Membahas metode substitusi pada integral - XII IPA 2',
      totalStudents: 30,
      submittedCount: 18,
      pendingCount: 12,
      completionPercentage: 60.0,
      lateStudentsCount: 3,
      submissions: [
        const AssignmentSubmissionModel(
          id: 's1',
          studentName: 'Daffa Rizaldi',
          avatar: 'https://i.pravatar.cc/150?u=daffa',
          submittedAt: '28 Okt, 10:15',
          fileName: 'Daffa_SubstitusiIntegral.pdf',
          score: 95,
          isSubmitted: true,
        ),
        const AssignmentSubmissionModel(
          id: 's2',
          studentName: 'Eka Putri Sari',
          avatar: 'https://i.pravatar.cc/150?u=eka',
          submittedAt: '27 Okt, 16:00',
          fileName: 'Eka_Integral.pdf',
          score: 88,
          isSubmitted: true,
        ),
        const AssignmentSubmissionModel(
          id: 's3',
          studentName: 'Fajar Nugroho',
          avatar: 'https://i.pravatar.cc/150?u=fajar',
          submittedAt: null,
          fileName: null,
          score: null,
          isSubmitted: false,
        ),
        const AssignmentSubmissionModel(
          id: 's4',
          studentName: 'Gita Maharani',
          avatar: 'https://i.pravatar.cc/150?u=gita',
          submittedAt: null,
          fileName: null,
          score: null,
          isSubmitted: false,
        ),
        const AssignmentSubmissionModel(
          id: 's5',
          studentName: 'Hendra Wijaya',
          avatar: 'https://i.pravatar.cc/150?u=hendra',
          submittedAt: '28 Okt, 08:45',
          fileName: 'Hendra_Substitusi.pdf',
          score: 78,
          isSubmitted: true,
        ),
      ],
    );
  }
}
