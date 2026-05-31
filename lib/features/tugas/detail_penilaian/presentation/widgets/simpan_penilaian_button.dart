import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

class SimpanPenilaianButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isAlreadyGraded;

  const SimpanPenilaianButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.isAlreadyGraded = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = isLoading || isAlreadyGraded;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isAlreadyGraded ? AppColors.successGreen : AppColors.primaryBlue,
          disabledBackgroundColor: isAlreadyGraded
              ? AppColors.successGreen.withOpacity(0.5)
              : AppColors.primaryBlue.withOpacity(0.6),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          elevation: isAlreadyGraded ? 0 : 4,
          shadowColor: AppColors.primaryBlue.withOpacity(0.4),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2.5))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isAlreadyGraded
                        ? Icons.check_circle_rounded
                        : Icons.save_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    isAlreadyGraded ? 'Sudah Dinilai' : 'Simpan Penilaian',
                    style: AppTextStyles.cardTitle.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
      ),
    );
  }
}
