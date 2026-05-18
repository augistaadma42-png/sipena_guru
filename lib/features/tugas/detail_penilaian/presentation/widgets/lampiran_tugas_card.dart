import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';
import 'preview_file_widgets.dart';

class LampiranTugasCard extends StatelessWidget {
  final String fileName;
  final String previewUrl;
  final VoidCallback? onDownload;

  const LampiranTugasCard({
    super.key, required this.fileName,
    required this.previewUrl, this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(
          color: Color(0x0D000000), blurRadius: 16, offset: Offset(0, 4))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.picture_as_pdf_rounded,
                      color: Color(0xFFE53E3E), size: 22),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lihat Lampiran', style: AppTextStyles.sectionTitle),
                      Text(fileName, style: AppTextStyles.cardSubtitle,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onDownload,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.download_rounded,
                          color: AppColors.primaryBlue, size: 16),
                      const SizedBox(width: 4),
                      Text('Unduh File',
                        style: AppTextStyles.labelStyle.copyWith(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            PreviewFileWidget(previewUrl: previewUrl),
          ],
        ),
      ),
    );
  }
}