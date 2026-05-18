import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

class DetailPenilaianAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final int notifCount;
  const DetailPenilaianAppBar({super.key, this.notifCount = 3});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.cardBackground,
      elevation: 0, scrolledUnderElevation: 1,
      shadowColor: AppColors.borderLight,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: AppColors.primaryBlue, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _SipenaLogo(),
          const SizedBox(width: 12),
          Text('Detail & Penilaian', style: AppTextStyles.sectionTitle),
        ],
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications_outlined,
                  color: AppColors.primaryBlue, size: 26),
              if (notifCount > 0)
                Positioned(
                  top: -4, right: -4,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: AppColors.secondaryOrange,
                      shape: BoxShape.circle,
                    ),
                    child: Text('$notifCount',
                      style: const TextStyle(
                        color: Colors.white, fontSize: 9,
                        fontWeight: FontWeight.w700,
                      )),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SipenaLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28, height: 28,
          decoration: BoxDecoration(
            color: AppColors.secondaryOrange,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.swap_horiz_rounded,
              color: Colors.white, size: 18),
        ),
        const SizedBox(width: 5),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(text: 'S', style: TextStyle(
                color: AppColors.secondaryOrange,
                fontWeight: FontWeight.w800, fontSize: 17)),
              TextSpan(text: 'ipena', style: TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w800, fontSize: 17)),
            ],
          ),
        ),
      ],
    );
  }
}