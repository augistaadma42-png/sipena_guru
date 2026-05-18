import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/constants/colors.dart';

class LampiranSection extends StatelessWidget {
  const LampiranSection({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      _LampiranItem(icon: Icons.add_to_drive, label: 'Drive', color: Color(0xFF4285F4)),
      _LampiranItem(icon: Icons.smart_display_outlined, label: 'YouTube', color: Color(0xFFFF0000)),
      _LampiranItem(icon: Icons.add_circle_outline, label: 'Buat', color: AppColors.textSecondary),
      _LampiranItem(icon: Icons.upload_outlined, label: 'Upload', color: AppColors.primaryBlue),
      _LampiranItem(icon: Icons.link, label: 'Link', color: Color(0xFF10B981)),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.attach_file, color: AppColors.primaryBlue, size: 18),
              const SizedBox(width: 8),
              Text(
                'Lampirkan',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items,
          ),
        ],
      ),
    );
  }
}

class _LampiranItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _LampiranItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
