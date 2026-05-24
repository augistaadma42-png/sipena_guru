import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';

class AnggotaAvatarGroup extends StatelessWidget {
  final int totalAnggota;

  const AnggotaAvatarGroup({
    super.key,
    required this.totalAnggota,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 100,
      child: Stack(
        children: [
          _buildAvatar(0, 'AF'),
          _buildAvatar(18, 'AA'),
          _buildAvatar(36, 'BP'),

          Positioned(
            left: 54,
            child: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                '+$totalAnggota',
                style: AppTextStyles.labelStyle.copyWith(
                  fontSize: 9,
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

  Widget _buildAvatar(
    double left,
    String initials,
  ) {
    return Positioned(
      left: left,
      child: Container(
        height: 28,
        width: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(.15),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: Text(
          initials,
          style: AppTextStyles.labelStyle.copyWith(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
      ),
    );
  }
}