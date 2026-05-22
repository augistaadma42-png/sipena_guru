import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';

class DaftarSiswaTab extends StatelessWidget {
  const DaftarSiswaTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for students
    final List<Map<String, String>> dummySiswa = [
      {'absen': '1', 'nisn': '0057281', 'jk': 'L', 'nama': 'Ahmad Fauzan'},
      {'absen': '2', 'nisn': '0057282', 'jk': 'P', 'nama': 'Ananda Aryani'},
      {'absen': '3', 'nisn': '0057283', 'jk': 'L', 'nama': 'Bagus Akbar'},
      {'absen': '4', 'nisn': '0057284', 'jk': 'P', 'nama': 'Bunga Pertiwi'},
      {'absen': '5', 'nisn': '0057285', 'jk': 'L', 'nama': 'Candra Aditama'},
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jumlah siswa di kelas ini: ${dummySiswa.length} orang',
                  style: AppTextStyles.cardSubtitle.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mengunduh PDF Daftar Siswa...')),
                    );
                  },
                  icon: const Icon(Icons.picture_as_pdf, size: 18),
                  label: const Text('Cetak'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    color: Colors.black.withAlpha(10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: AppColors.borderLight,
                    ),
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(AppColors.primaryBlue.withAlpha(20)),
                      dataRowMaxHeight: 56,
                      dataRowMinHeight: 56,
                      columnSpacing: 24,
                      headingTextStyle: AppTextStyles.tableHeader.copyWith(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w800,
                      ),
                      dataTextStyle: AppTextStyles.tableBody,
                      columns: const [
                        DataColumn(label: Text('No')),
                        DataColumn(label: Text('NISN')),
                        DataColumn(label: Text('L/P')),
                        DataColumn(label: Text('Nama Lengkap')),
                      ],
                      rows: dummySiswa.asMap().entries.map((entry) {
                        final index = entry.key;
                        final siswa = entry.value;
                        final isEven = index % 2 == 0;
                        return DataRow(
                          color: WidgetStateProperty.all(
                            isEven ? Colors.white : AppColors.backgroundLight.withAlpha(150),
                          ),
                          cells: [
                            DataCell(Text(
                              siswa['absen']!,
                              style: AppTextStyles.tableBodyBold,
                            )),
                            DataCell(Text(siswa['nisn']!)),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: siswa['jk'] == 'L' 
                                      ? AppColors.primaryBlue.withAlpha(20) 
                                      : AppColors.secondaryOrange.withAlpha(20),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  siswa['jk']!,
                                  style: AppTextStyles.tableBodyBold.copyWith(
                                    color: siswa['jk'] == 'L' 
                                        ? AppColors.primaryBlue 
                                        : AppColors.secondaryOrange,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(Text(
                              siswa['nama']!,
                              style: AppTextStyles.tableBody.copyWith(fontWeight: FontWeight.w600),
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
