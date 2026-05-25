import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';

class DaftarSiswaTab extends StatefulWidget {
  const DaftarSiswaTab({super.key});

  @override
  State<DaftarSiswaTab> createState() => _DaftarSiswaTabState();
}

class _DaftarSiswaTabState extends State<DaftarSiswaTab> {
  String _searchQuery = '';

  final List<Map<String, String>> _dummySiswa = [
    {'absen': '1', 'nisn': '0057281', 'jk': 'L', 'nama': 'Ahmad Fauzan'},
    {'absen': '2', 'nisn': '0057282', 'jk': 'P', 'nama': 'Ananda Aryani'},
    {'absen': '3', 'nisn': '0057283', 'jk': 'L', 'nama': 'Bagus Akbar'},
    {'absen': '4', 'nisn': '0057284', 'jk': 'P', 'nama': 'Bunga Pertiwi'},
    {'absen': '5', 'nisn': '0057285', 'jk': 'L', 'nama': 'Candra Aditama'},
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _dummySiswa
        .where((s) =>
            s['nama']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            s['nisn']!.contains(_searchQuery))
        .toList();

    final lCount = _dummySiswa.where((s) => s['jk'] == 'L').length;
    final pCount = _dummySiswa.where((s) => s['jk'] == 'P').length;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Stats row ──────────────────────────────────────────
            Row(
              children: [
                _StatChip(
                  label: 'Total',
                  value: '${_dummySiswa.length}',
                  icon: Icons.groups_rounded,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(width: 8),
                _StatChip(
                  label: 'Laki-laki',
                  value: '$lCount',
                  icon: Icons.male_rounded,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(width: 8),
                _StatChip(
                  label: 'Perempuan',
                  value: '$pCount',
                  icon: Icons.female_rounded,
                  color: AppColors.secondaryOrange,
                ),
              ],
            ),

            const SizedBox(height: 14),

            // ── Search + cetak ──────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: TextField(
                      onChanged: (v) => setState(() => _searchQuery = v),
                      style: GoogleFonts.inter(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Cari nama atau NISN...',
                        hintStyle: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.disabledGrey,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          size: 18,
                          color: AppColors.disabledGrey,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 11),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Mengunduh PDF Daftar Siswa...')),
                    );
                  },
                  icon: const Icon(Icons.picture_as_pdf_rounded, size: 16),
                  label: const Text('Cetak'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    textStyle: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // ── Tabel ───────────────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  // Header
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryBlue,
                          AppColors.primaryBlue.withOpacity(0.85),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        _HeaderCell('No', width: 40),
                        _HeaderCell('NISN', width: 90),
                        _HeaderCell('L/P', width: 60),
                        const Expanded(child: _HeaderCell('Nama Lengkap')),
                      ],
                    ),
                  ),

                  // Rows
                  if (filtered.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: [
                          Icon(Icons.search_off_rounded,
                              size: 40,
                              color: AppColors.disabledGrey.withOpacity(0.5)),
                          const SizedBox(height: 8),
                          Text(
                            'Siswa tidak ditemukan',
                            style: AppTextStyles.cardSubtitle
                                .copyWith(color: AppColors.disabledGrey),
                          ),
                        ],
                      ),
                    )
                  else
                    ...filtered.asMap().entries.map((entry) {
                      final i = entry.key;
                      final siswa = entry.value;
                      final isEven = i % 2 == 0;
                      final isLast = i == filtered.length - 1;
                      final isL = siswa['jk'] == 'L';
                      final badgeColor = isL
                          ? AppColors.primaryBlue
                          : AppColors.secondaryOrange;

                      return Column(
                        children: [
                          Container(
                            color: isEven
                                ? Colors.white
                                : AppColors.backgroundLight,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 13),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // No absen
                                SizedBox(
                                  width: 40,
                                  child: Center(
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryBlue
                                            .withOpacity(0.08),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        siswa['absen']!,
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primaryBlue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // NISN
                                SizedBox(
                                  width: 90,
                                  child: Text(
                                    siswa['nisn']!,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),

                                // L/P badge — lebar fixed 60, badge center di dalamnya
                                SizedBox(
                                  width: 60,
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: badgeColor.withOpacity(0.10),
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        siswa['jk']!,
                                        style: GoogleFonts.inter(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: badgeColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Nama — pakai Expanded supaya tidak mepet
                                Expanded(
                                  child: Text(
                                    siswa['nama']!,
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isLast)
                            const Divider(
                                height: 1, color: AppColors.borderLight),
                        ],
                      );
                    }),
                ],
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

// ── Sub-widgets ─────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatChip({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(icon, size: 14, color: color),
            ),
            const SizedBox(width: 7),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  final double? width;

  const _HeaderCell(this.text, {this.width});

  @override
  Widget build(BuildContext context) {
    final child = Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 0.3,
      ),
    );

    if (width != null) {
      return SizedBox(width: width, child: child);
    }
    return child;
  }
}
