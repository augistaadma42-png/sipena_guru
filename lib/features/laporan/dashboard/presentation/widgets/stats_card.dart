import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitur_guru/core/constants/colors.dart';

/// Item Aktivitas Terakhir yang sesuai dengan gambar: Icon, judul, waktu, dan chevron
class ActivityItem extends StatelessWidget {
  final String title;
  final String time;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  const ActivityItem({
    super.key,
    required this.title,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          // Icon background bulat
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20),
        ],
      ),
    );
  }
}

/// List Aktivitas Terakhir
class ActivityList extends StatelessWidget {
  final List<Map<String, dynamic>> activities;

  const ActivityList({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: activities.map((activity) {
        return ActivityItem(
          title: activity['title'] as String,
          time: activity['time'] as String,
          icon: activity['icon'] as IconData,
          iconColor: activity['iconColor'] as Color,
          bgColor: activity['bgColor'] as Color,
        );
      }).toList(),
    );
  }
}