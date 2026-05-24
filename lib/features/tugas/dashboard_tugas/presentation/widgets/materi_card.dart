import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';
import '../../domain/entities/materi_entity.dart';

class MateriCard extends StatelessWidget {
  final MateriEntity materi;
  final VoidCallback? onTap;
  final double width;

  const MateriCard({
    super.key,
    required this.materi,
    this.onTap,
    this.width = 260,
  });

  IconData get _icon {
    switch (materi.category.toLowerCase()) {
      case 'fisika':
        return Icons.science_rounded;
      case 'kimia':
        return Icons.biotech_rounded;
      case 'biologi':
        return Icons.eco_rounded;
      default:
        return Icons.menu_book_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.only(right: width == double.infinity ? 0 : 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // ── Ikon mapel
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),

              // ── Info
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul materi
                    Text(
                      materi.title,
                      style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),

                    // Mapel • Kelas
                    Text(
                      materi.kelas.isNotEmpty
                          ? '${materi.category} · ${materi.kelas}'
                          : materi.category,
                      style: AppTextStyles.cardSubtitle.copyWith(fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),

                    // Baris bawah: tanggal pembuatan + lampiran
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 11,
                          color: AppColors.disabledGrey,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          'Dibuat: ${_formatToDDMMYY(materi.tanggal)}',
                          style: AppTextStyles.cardSubtitle.copyWith(
                            fontSize: 11,
                          ),
                        ),
                        if (materi.lampiranCount > 0) ...[
                          const SizedBox(width: 8),
                          Icon(
                            Icons.attach_file_rounded,
                            size: 11,
                            color: AppColors.primaryBlue,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${materi.lampiranCount}',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.disabledGrey,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatToDDMMYY(String input) {
    try {
      final trimmed = input.trim();
      if (trimmed.isEmpty) return '';
      final parts = trimmed.split(RegExp(r'\s+'));
      final monthMap = {
        'jan': 1,
        'feb': 2,
        'mar': 3,
        'apr': 4,
        'mei': 5,
        'jun': 6,
        'jul': 7,
        'agu': 8,
        'agt': 8,
        'sep': 9,
        'okt': 10,
        'nov': 11,
        'des': 12,
      };

      int day = 1;
      int month = DateTime.now().month;
      int year = DateTime.now().year;

      final firstNum = int.tryParse(parts[0]);
      if (firstNum != null) {
        day = firstNum;
        if (parts.length >= 2) {
          final key = parts[1].toLowerCase().replaceAll('.', '');
          month = monthMap[key] ?? month;
        }
        if (parts.length >= 3) {
          final y = int.tryParse(parts[2]);
          if (y != null) year = y;
        }
      } else {
        final key = parts[0].toLowerCase().replaceAll('.', '');
        month = monthMap[key] ?? month;
        if (parts.length >= 2) {
          final y = int.tryParse(parts[1]);
          if (y != null) year = y;
        }
      }

      final two = (int n) => n.toString().padLeft(2, '0');
      final yy = (year % 100).toString().padLeft(2, '0');
      return '${two(day)}/${two(month)}/$yy';
    } catch (_) {
      return input;
    }
  }
}
