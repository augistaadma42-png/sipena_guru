import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

class AvatarSiswa extends StatelessWidget {
  final String nama;
  final double radius;
  const AvatarSiswa({super.key, required this.nama, this.radius = 36});

  String _inisial(String nama) {
    final parts = nama.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.lightBlueBg,
      child: Text(
        _inisial(nama),
        style: AppTextStyles.sectionTitle.copyWith(
          fontSize: radius * 0.6, color: AppColors.primaryBlue),
      ),
    );
  }
}