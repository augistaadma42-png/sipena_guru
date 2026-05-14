import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class JadwalHeaderCard extends StatefulWidget {
  const JadwalHeaderCard({Key? key}) : super(key: key);

  @override
  State<JadwalHeaderCard> createState() => _JadwalHeaderCardState();
}

class _JadwalHeaderCardState extends State<JadwalHeaderCard> {
  bool _isDownloading = false;

  Future<void> _downloadPDF() async {
    setState(() => _isDownloading = true);

    // Simulasi loading proses generate PDF
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isDownloading = false);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline,
                color: Colors.white, size: 18),
            const SizedBox(width: 10),
            const Text('Jadwal berhasil diunduh!'),
          ],
        ),
        backgroundColor: AppColors.successGreen,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Semester Genap\n2025/2026',
            style: AppTextStyles.sectionTitle.copyWith(
              fontSize: 22,
              height: 1.2,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Update terakhir: 06 Januari 2026',
            style: AppTextStyles.cardSubtitle.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.access_time,
                    size: 18, color: AppColors.primaryBlue),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Jadwal akan diperbarui setiap periode semester dan jika terdapat perubahan jadwal tertentu.',
                    style: AppTextStyles.cardSubtitle.copyWith(
                      color: AppColors.primaryBlue.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _isDownloading ? null : _downloadPDF,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryOrange,
                disabledBackgroundColor:
                    AppColors.secondaryOrange.withOpacity(0.7),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
              ),
              child: _isDownloading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Menyiapkan PDF...',
                          style: AppTextStyles.cardTitle
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.download_outlined,
                            size: 20, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          'Download Jadwal (PDF)',
                          style: AppTextStyles.cardTitle
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
