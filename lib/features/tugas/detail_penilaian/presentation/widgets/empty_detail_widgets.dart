import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

class EmptyDetailWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  const EmptyDetailWidget({super.key,
    this.message = 'Data tidak ditemukan.', this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppColors.lightBlueBg, shape: BoxShape.circle),
              child: const Icon(Icons.assignment_late_outlined,
                  color: AppColors.primaryBlue, size: 48),
            ),
            const SizedBox(height: 20),
            Text('Oops!', style: AppTextStyles.sectionTitle.copyWith(fontSize: 20)),
            const SizedBox(height: 8),
            Text(message, style: AppTextStyles.cardSubtitle,
                textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
                icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                label: const Text('Coba Lagi',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}