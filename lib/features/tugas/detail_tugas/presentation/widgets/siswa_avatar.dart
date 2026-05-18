import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';

/// Avatar siswa dengan fallback initial ketika gambar gagal dimuat
class SiswaAvatar extends StatelessWidget {
  final String avatarUrl;
  final String studentName;
  final double size;

  const SiswaAvatar({
    super.key,
    required this.avatarUrl,
    required this.studentName,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    final initial = studentName.isNotEmpty
        ? studentName[0].toUpperCase()
        : '?';

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: AppColors.lightBlueBg,
      backgroundImage: avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
      onBackgroundImageError: avatarUrl.isNotEmpty
          ? (_, __) {} // Gambar gagal — tampilkan initial
          : null,
      child: avatarUrl.isEmpty
          ? Text(
              initial,
              style: AppTextStyles.cardTitle.copyWith(
                color: AppColors.primaryBlue,
                fontSize: size * 0.4,
              ),
            )
          : null,
    );
  }
}
