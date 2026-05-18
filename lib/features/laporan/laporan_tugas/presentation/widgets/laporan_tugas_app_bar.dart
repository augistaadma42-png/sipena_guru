import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/text_styles.dart';

/// AppBar kustom untuk halaman Laporan Tugas
class LaporanTugasAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const LaporanTugasAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      shadowColor: AppColors.borderLight,
      surfaceTintColor: Colors.white,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).maybePop(),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.primaryBlue,
          size: 20,
        ),
      ),
      title: Text(
        'Laporan Tugas',
        style: AppTextStyles.appBarTitle,
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.lightBlueBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: AppColors.primaryBlue,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
