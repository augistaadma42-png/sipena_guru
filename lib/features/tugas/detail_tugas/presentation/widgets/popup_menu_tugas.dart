import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';

/// Popup menu tiga titik untuk aksi per siswa
class PopupMenuTugas extends StatelessWidget {
  final VoidCallback onLihat;
  final VoidCallback onUnduh;
  final VoidCallback onBeriNilai;

  const PopupMenuTugas({
    super.key,
    required this.onLihat,
    required this.onUnduh,
    required this.onBeriNilai,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert_rounded,
        color: AppColors.disabledGrey,
        size: 20,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) {
        switch (value) {
          case 'lihat':
            onLihat();
            break;
          case 'unduh':
            onUnduh();
            break;
          case 'nilai':
            onBeriNilai();
            break;
        }
      },
      itemBuilder: (context) => [
        _buildItem('lihat', Icons.visibility_rounded, 'Lihat File'),
        _buildItem('unduh', Icons.download_rounded, 'Unduh File'),
        _buildItem('nilai', Icons.grade_rounded, 'Beri Nilai'),
      ],
    );
  }

  PopupMenuItem<String> _buildItem(
      String value, IconData icon, String label) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primaryBlue),
          const SizedBox(width: 10),
          Text(label, style: AppTextStyles.cardSubtitle.copyWith(
            color: AppColors.textPrimary,
            fontSize: 13,
          )),
        ],
      ),
    );
  }
}
