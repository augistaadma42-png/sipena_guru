import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/widgets/custom_app_bar.dart';

/// App Bar yang sesuai dengan gambar: Putih, ada tombol back, judul Laporan, dan icon profil
class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
 
  const DashboardAppBar({
    super.key,
    this.title = 'Laporan',
    this.showBackButton = true,
  });
 
  @override
  Size get preferredSize => const Size.fromHeight(80);
 
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: title,
      showBackButton: showBackButton,
    );
  }
}

/// Widget untuk dropdown filter (Pilih Kelas, Mata Pelajaran, Bulan)
class FilterDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;

  const FilterDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: GoogleFonts.inter(fontSize: 14, color: AppColors.textPrimary),
                  ),
                );
              }).toList(),
              onChanged: (_) {},
            ),
          ),
        ),
      ],
    );
  }
}