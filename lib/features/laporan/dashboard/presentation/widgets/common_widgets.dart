import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitur_guru/core/constants/colors.dart';

/// App Bar yang sesuai dengan gambar: Putih, ada tombol back, judul Laporan, dan icon profil
class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.primaryBlue),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: Text(
        'Laporan',
        style: GoogleFonts.inter(
          color: AppColors.primaryBlue,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryBlue, width: 1.5),
            ),
            child: const Icon(
              Icons.account_circle_outlined,
              color: AppColors.primaryBlue,
              size: 24,
            ),
          ),
        ),
      ],
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