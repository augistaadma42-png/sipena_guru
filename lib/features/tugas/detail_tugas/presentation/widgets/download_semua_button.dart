import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';

class DownloadSemuaButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DownloadSemuaButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.06), // biru transparan
              borderRadius: BorderRadius.circular(18),

              border: Border.all(
                color: AppColors.primaryBlue.withOpacity(0.35),
                width: 1.5,
              ),

              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.download_rounded,
                  color: AppColors.primaryBlue,
                  size: 22,
                ),

                const SizedBox(width: 10),

                Text(
                  'Unduh Semua Tugas',
                  style: AppTextStyles.buttonText.copyWith(
                    fontSize: 16,
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}