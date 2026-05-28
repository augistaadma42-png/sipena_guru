import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';
import '../../../buat_tugas/presentation/pages/buat_tugas_page.dart';

class EmptyTugasWidget extends StatelessWidget {
  final String namaKelas;
  final String namaMapel;

  const EmptyTugasWidget({
    super.key,
    required this.namaKelas,
    required this.namaMapel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.lightBlueBg.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.assignment_late_outlined,
                size: 80,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Belum ada tugas tersedia',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Tekan tombol + untuk membuat tugas baru bagi siswa Anda.',
              style: AppTextStyles.headerSubtitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BuatTugasPage(
                      namaKelas: namaKelas,
                      namaMapel: namaMapel,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Tambah Tugas',
                style: AppTextStyles.buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
