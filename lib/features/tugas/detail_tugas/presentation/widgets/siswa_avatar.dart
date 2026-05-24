import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';

class SiswaAvatar extends StatelessWidget {
  final String studentName;
  final double size;

  const SiswaAvatar({
    super.key,
    required this.studentName,
    this.size = 44,
  });

  String getInitials(String name) {
    final words = name.trim().split(' ');

    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }

    return words[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final initials = getInitials(studentName);

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: AppColors.primaryBlue.withOpacity(.12),

      child: Text(
        initials,
        style: AppTextStyles.cardTitle.copyWith(
          color: AppColors.primaryBlue,
          fontSize: size * .35,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}