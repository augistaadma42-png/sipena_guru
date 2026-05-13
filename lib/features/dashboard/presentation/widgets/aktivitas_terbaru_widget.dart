import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class AktivitasTerbaruWidget extends StatelessWidget {
  final VoidCallback? onLihatSemua;

  const AktivitasTerbaruWidget({Key? key, this.onLihatSemua}) : super(key: key);

  static const List<Map<String, dynamic>> _aktivitasList = [
    {
      'tanggal': '08 Mei 2026',
      'jam': '07.00',
      'deskripsi': 'Login berhasil',
      'jenis': 'sistem',
      'icon': Icons.login,
    },
    {
      'tanggal': '08 Mei 2026',
      'jam': '13.15',
      'deskripsi': 'Logout',
      'jenis': 'sistem',
      'icon': Icons.logout,
    },
    {
      'tanggal': '07 Mei 2026',
      'jam': '19.00',
      'deskripsi': 'Password diubah',
      'jenis': 'sistem',
      'icon': Icons.lock_outline,
    },
    {
      'tanggal': '07 Mei 2026',
      'jam': '07.00',
      'deskripsi': 'Mengisi Absensi XI RPL 1',
      'jenis': 'absensi',
      'icon': Icons.fact_check_outlined,
    },
    {
      'tanggal': '06 Mei 2026',
      'jam': '08.00',
      'deskripsi': 'Mengedit absensi XI DKV 2',
      'jenis': 'absensi',
      'icon': Icons.edit_note_outlined,
    },
  ];

  Color _jenisColor(String jenis) {
    switch (jenis) {
      case 'absensi': return AppColors.primaryBlue;
      case 'jurnal': return const Color(0xFF6A1B9A);
      case 'tugas': return AppColors.secondaryOrange;
      default: return AppColors.textSecondary;
    }
  }

  Color _jenisBg(String jenis) {
    switch (jenis) {
      case 'absensi': return AppColors.primaryBlue.withOpacity(0.1);
      case 'jurnal': return const Color(0xFFF3E5F5);
      case 'tugas': return const Color(0xFFFFF3E0);
      default: return AppColors.backgroundLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Aktivitas Terbaru',
                  style: AppTextStyles.sectionTitle),
              GestureDetector(
                onTap: onLihatSemua,
                child: Text(
                  'Lihat Semua →',
                  style: AppTextStyles.labelStyle.copyWith(
                    color: AppColors.secondaryOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._aktivitasList.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == _aktivitasList.length - 1;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline line + icon
                Column(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _jenisBg(item['jenis']),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        size: 18,
                        color: _jenisColor(item['jenis']),
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 32,
                        color: AppColors.borderLight,
                      ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['deskripsi'],
                          style: AppTextStyles.cardTitle.copyWith(fontSize: 13),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${item['tanggal']} • ${item['jam']}',
                          style: AppTextStyles.cardSubtitle
                              .copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
