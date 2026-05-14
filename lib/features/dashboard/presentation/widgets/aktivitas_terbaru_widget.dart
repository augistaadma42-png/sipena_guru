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
    {
      'tanggal': '06 Mei 2026',
      'jam': '09.00',
      'deskripsi': 'Membuat jurnal XI RPL 1',
      'jenis': 'jurnal',
      'icon': Icons.book_outlined,
    },
    {
      'tanggal': '05 Mei 2026',
      'jam': '10.00',
      'deskripsi': 'Membuat tugas baru — Latihan Soal Bab 3',
      'jenis': 'tugas',
      'icon': Icons.assignment_outlined,
    },
    {
      'tanggal': '05 Mei 2026',
      'jam': '10.30',
      'deskripsi': 'Mengubah deadline tugas — Kuis Harian',
      'jenis': 'tugas',
      'icon': Icons.edit_calendar_outlined,
    },
    {
      'tanggal': '05 Mei 2026',
      'jam': '11.00',
      'deskripsi': 'Menginput nilai tugas XI RPL 2',
      'jenis': 'nilai',
      'icon': Icons.grade_outlined,
    },
    {
      'tanggal': '04 Mei 2026',
      'jam': '12.00',
      'deskripsi': 'Menyetujui pengajuan izin — Augusta A.Z',
      'jenis': 'pengajuan',
      'icon': Icons.check_circle_outline,
    },
    {
      'tanggal': '04 Mei 2026',
      'jam': '13.00',
      'deskripsi': 'Membuat jurnal X RPL 1',
      'jenis': 'jurnal',
      'icon': Icons.book_outlined,
    },
    {
      'tanggal': '03 Mei 2026',
      'jam': '14.00',
      'deskripsi': 'Mengedit jurnal XI RPL 2',
      'jenis': 'jurnal',
      'icon': Icons.edit_note_outlined,
    },
  ];

  Color _jenisColor(String jenis) {
    switch (jenis) {
      case 'absensi': return AppColors.primaryBlue;
      case 'jurnal': return const Color(0xFF6A1B9A);
      case 'tugas': return AppColors.secondaryOrange;
      case 'nilai': return const Color(0xFF2E7D32);
      case 'pengajuan': return const Color(0xFF1565C0);
      default: return AppColors.textSecondary;
    }
  }

  Color _jenisBg(String jenis) {
    switch (jenis) {
      case 'absensi': return AppColors.primaryBlue.withOpacity(0.1);
      case 'jurnal': return const Color(0xFFF3E5F5);
      case 'tugas': return const Color(0xFFFFF3E0);
      case 'nilai': return const Color(0xFFE8F5E9);
      case 'pengajuan': return const Color(0xFFE3F2FD);
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
