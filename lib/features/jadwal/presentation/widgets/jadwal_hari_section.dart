import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class JadwalHariSection extends StatelessWidget {
  final String hari;
  final int jumlahPelajaran;
  final Color warnaPil;
  final List<Map<String, String>> jadwal;

  const JadwalHariSection({
    Key? key,
    required this.hari,
    required this.jumlahPelajaran,
    required this.jadwal,
    this.warnaPil = AppColors.primaryBlue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  hari,
                  style: AppTextStyles.sectionTitle.copyWith(
                    fontSize: 20,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: warnaPil.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$jumlahPelajaran Pelajaran',
                style: AppTextStyles.labelStyle.copyWith(
                  color: warnaPil,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1.2), // Jam
                1: FlexColumnWidth(1.5), // Mata Pelajaran
                2: FlexColumnWidth(1.0), // Kelas
                3: FlexColumnWidth(0.8), // Ruang
              },
              border: TableBorder.symmetric(
                inside: const BorderSide(color: AppColors.borderLight),
              ),
              children: [
                _buildHeaderRow(),
                ...jadwal.map((j) => _buildDataRow(j)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB), // Warna header tabel yang sangat terang
      ),
      children: [
        _buildHeaderCell('Jam'),
        _buildHeaderCell('Mata\nPelajaran'),
        _buildHeaderCell('Kelas'),
        _buildHeaderCell('Ruang'),
      ],
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextStyles.cardSubtitle.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  TableRow _buildDataRow(Map<String, String> data) {
    return TableRow(
      children: [
        _buildDataCell(
          data['jam']!,
          AppTextStyles.cardTitle.copyWith(
            color: AppColors.secondaryOrange,
            fontSize: 11,
          ),
        ),
        _buildDataCell(
          data['mataPelajaran']!,
          AppTextStyles.cardTitle.copyWith(
            color: AppColors.primaryBlue,
            fontSize: 11,
          ),
        ),
        _buildDataCell(
          data['kelas']!,
          AppTextStyles.cardSubtitle.copyWith(
            fontSize: 11,
          ),
        ),
        _buildDataCell(
          data['ruang']!,
          AppTextStyles.cardSubtitle.copyWith(
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildDataCell(String text, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: style,
        ),
      ),
    );
  }
}
