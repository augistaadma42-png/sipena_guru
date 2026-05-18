import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';

/// Skeleton loader untuk tampilan loading halaman rekap
class LoadingPengumpulanWidget extends StatelessWidget {
  const LoadingPengumpulanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header skeleton
          _skeleton(width: 200, height: 28),
          const SizedBox(height: 8),
          _skeleton(width: 280, height: 16),
          const SizedBox(height: 20),

          // Button skeleton
          _skeleton(width: double.infinity, height: 52, radius: 20),
          const SizedBox(height: 20),

          // Statistik cards skeleton
          Row(
            children: [
              Expanded(child: _skeleton(width: double.infinity, height: 130, radius: 20)),
              const SizedBox(width: 12),
              Expanded(child: _skeleton(width: double.infinity, height: 130, radius: 20)),
            ],
          ),
          const SizedBox(height: 20),

          // Filter tab skeleton
          _skeleton(width: double.infinity, height: 52, radius: 14),
          const SizedBox(height: 16),

          // Search skeleton
          _skeleton(width: double.infinity, height: 52, radius: 14),
          const SizedBox(height: 20),

          // List items skeleton
          ...List.generate(
            4,
            (_) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _skeleton(width: double.infinity, height: 80, radius: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skeleton({
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.borderLight.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
