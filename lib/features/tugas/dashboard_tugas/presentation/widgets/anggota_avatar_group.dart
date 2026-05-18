import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';

class AnggotaAvatarGroup extends StatelessWidget {
  final int totalAnggota;

  const AnggotaAvatarGroup({super.key, required this.totalAnggota});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 90,
      child: Stack(
        children: [
          _buildAvatar(0, 'https://i.pravatar.cc/150?u=1'),
          _buildAvatar(18, 'https://i.pravatar.cc/150?u=2'),
          _buildAvatar(36, 'https://i.pravatar.cc/150?u=3'),
          Positioned(
            left: 54,
            child: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                '+$totalAnggota',
                style: AppTextStyles.labelStyle.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(double left, String url) {
    return Positioned(
      left: left,
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
