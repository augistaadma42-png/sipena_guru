import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

/// Widget pagination dengan tombol navigasi halaman
class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int totalSiswa;
  final int perPage;
  final ValueChanged<int> onPageChanged;

  const PaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.totalSiswa,
    required this.perPage,
    required this.onPageChanged,
  });

  /// Hitung jumlah siswa yang sedang ditampilkan
  int get _displayedCount {
    final end = currentPage * perPage;
    return end > totalSiswa ? totalSiswa : end;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Row(
        children: [
          // Teks "Menampilkan X dari Y siswa"
          Expanded(
            child: Text(
              'Menampilkan $_displayedCount dari $totalSiswa siswa',
              style: AppTextStyles.paginationText,
            ),
          ),
          const SizedBox(width: 8),
          // Tombol navigasi
          Row(
            children: [
              _PageButton(
                icon: Icons.chevron_left_rounded,
                onTap: currentPage > 1
                    ? () => onPageChanged(currentPage - 1)
                    : null,
              ),
              const SizedBox(width: 4),
              // Tampilkan maksimal 3 tombol halaman
              ..._buildPageButtons(),
              const SizedBox(width: 4),
              _PageButton(
                icon: Icons.chevron_right_rounded,
                onTap: currentPage < totalPages
                    ? () => onPageChanged(currentPage + 1)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build tombol nomor halaman
  List<Widget> _buildPageButtons() {
    final List<Widget> buttons = [];
    final int start = (currentPage - 1).clamp(1, totalPages);
    final int end = (start + 1).clamp(1, totalPages);

    for (int page = start; page <= end; page++) {
      buttons.add(_NumberPageButton(
        page: page,
        isActive: page == currentPage,
        onTap: () => onPageChanged(page),
      ));
      if (page != end) buttons.add(const SizedBox(width: 4));
    }
    return buttons;
  }
}

/// Tombol icon navigasi (prev/next)
class _PageButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _PageButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isEnabled ? AppColors.textPrimary : AppColors.disabledGrey,
        ),
      ),
    );
  }
}

/// Tombol nomor halaman
class _NumberPageButton extends StatelessWidget {
  final int page;
  final bool isActive;
  final VoidCallback onTap;

  const _NumberPageButton({
    required this.page,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryBlue : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? AppColors.primaryBlue : AppColors.borderLight,
          ),
        ),
        child: Center(
          child: Text(
            '$page',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}