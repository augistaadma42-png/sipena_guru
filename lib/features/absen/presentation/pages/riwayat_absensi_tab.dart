import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import 'detail_absensi_page.dart';

class RiwayatAbsensiTab extends StatefulWidget {
  const RiwayatAbsensiTab({Key? key}) : super(key: key);

  @override
  State<RiwayatAbsensiTab> createState() => _RiwayatAbsensiTabState();
}

class _RiwayatAbsensiTabState extends State<RiwayatAbsensiTab> {
  DateTime _selectedDate = DateTime(2024, 5, 24);
  String? _selectedKelas;

  final List<String> _kelasList = [
    'Semua Kelas',
    'X DKV 1',
    'XI RPL 1',
    'XI RPL 2',
    'XI TKJT 2',
    'XII TKJ 1',
  ];

  final List<Map<String, dynamic>> _riwayatList = [
    {
      'tanggal': DateTime(2024, 5, 24),
      'hari': 'Senin',
      'kelas': 'XI RPL 1',
      'mapel': 'Bahasa Indonesia',
      'jamMulai': '10:00',
      'jamSelesai': '11:20',
      'jamKe': 'Jam Ke 5-7',
      'jumlahHadir': 36,
      'totalSiswa': 38,
      'lengkap': true,
    },
    {
      'tanggal': DateTime(2024, 5, 24),
      'hari': 'Senin',
      'kelas': 'XI RPL 2',
      'mapel': 'Bahasa Indonesia',
      'jamMulai': '12:00',
      'jamSelesai': '14:20',
      'jamKe': 'Jam Ke 8-10',
      'jumlahHadir': 38,
      'totalSiswa': 38,
      'lengkap': true,
    },
    {
      'tanggal': DateTime(2024, 5, 21),
      'hari': 'Jumat',
      'kelas': 'X DKV 1',
      'mapel': 'Bahasa Indonesia',
      'jamMulai': '07:00',
      'jamSelesai': '08:20',
      'jamKe': 'Jam Ke 1-2',
      'jumlahHadir': 30,
      'totalSiswa': 35,
      'lengkap': false,
    },
    {
      'tanggal': DateTime(2024, 5, 20),
      'hari': 'Kamis',
      'kelas': 'XI TKJT 2',
      'mapel': 'Bahasa Indonesia',
      'jamMulai': '08:20',
      'jamSelesai': '09:40',
      'jamKe': 'Jam Ke 2-3',
      'jumlahHadir': 32,
      'totalSiswa': 32,
      'lengkap': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredList {
    return _riwayatList.where((item) {
      final tanggalMatch =
          item['tanggal'].year == _selectedDate.year &&
          item['tanggal'].month == _selectedDate.month &&
          item['tanggal'].day == _selectedDate.day;
      final kelasMatch = _selectedKelas == null ||
          _selectedKelas == 'Semua Kelas' ||
          item['kelas'] == _selectedKelas;
      return tanggalMatch && kelasMatch;
    }).toList();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredList;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Row
          Row(
            children: [
              // Filter Tanggal
              Expanded(
                child: GestureDetector(
                  onTap: _pickDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined,
                            size: 16, color: AppColors.primaryBlue),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            DateFormat('d MMM yyyy', 'id_ID')
                                .format(_selectedDate),
                            style: AppTextStyles.cardTitle
                                .copyWith(fontSize: 13),
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down,
                            color: AppColors.secondaryOrange, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Filter Kelas
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedKelas ?? 'Semua Kelas',
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: AppColors.secondaryOrange, size: 18),
                      style: AppTextStyles.cardTitle.copyWith(fontSize: 13),
                      isExpanded: true,
                      items: _kelasList
                          .map((k) => DropdownMenuItem(
                                value: k,
                                child: Row(
                                  children: [
                                    const Icon(Icons.apartment_outlined,
                                        size: 15,
                                        color: AppColors.primaryBlue),
                                    const SizedBox(width: 6),
                                    Flexible(
                                      child: Text(k,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _selectedKelas = val),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Hasil List
          if (filtered.isEmpty) ...[
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  Icon(Icons.history,
                      size: 64,
                      color: AppColors.textSecondary.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  Text('Tidak ada riwayat absensi',
                      style: AppTextStyles.sectionTitle
                          .copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  Text('Coba ubah filter tanggal atau kelas',
                      style: AppTextStyles.cardSubtitle),
                ],
              ),
            ),
          ] else
            ...filtered.map((item) => _RiwayatCard(item: item)).toList(),
        ],
      ),
    );
  }
}

class _RiwayatCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const _RiwayatCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final bool lengkap = item['lengkap'] as bool;
    final String tanggalStr =
        '${item['hari']}, ${DateFormat('d MMMM yyyy', 'id_ID').format(item['tanggal'])}';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
          // Header: Tanggal & Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tanggalStr,
                style: AppTextStyles.cardSubtitle.copyWith(fontSize: 12),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: lengkap
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  lengkap ? 'Lengkap' : 'Belum Lengkap',
                  style: AppTextStyles.labelStyle.copyWith(
                    color: lengkap
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFE65100),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Kelas & Jam
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['kelas'],
                style: AppTextStyles.sectionTitle.copyWith(fontSize: 18),
              ),
              Text(
                '${item['jamMulai']} - ${item['jamSelesai']}',
                style: AppTextStyles.cardTitle.copyWith(fontSize: 13),
              ),
            ],
          ),

          // Mapel & Jam Ke
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item['mapel'],
                  style: AppTextStyles.cardSubtitle.copyWith(fontSize: 12)),
              Text(item['jamKe'],
                  style: AppTextStyles.cardSubtitle.copyWith(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 6),

          // Jumlah hadir
          Text(
            '${item['jumlahHadir']} / ${item['totalSiswa']} siswa hadir',
            style: AppTextStyles.labelStyle.copyWith(
                color: AppColors.primaryBlue, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 14),

          // Tombol Lihat & Edit
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailAbsensiPage(
                          className: item['kelas'],
                          subject: item['mapel'],
                          time:
                              '${item['jamMulai']} - ${item['jamSelesai']}',
                          jamKe: item['jamKe'],
                          isReadOnly: true,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.visibility_outlined,
                      size: 16, color: AppColors.primaryBlue),
                  label: Text('Lihat',
                      style: AppTextStyles.cardTitle
                          .copyWith(color: AppColors.primaryBlue)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primaryBlue),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailAbsensiPage(
                          className: item['kelas'],
                          subject: item['mapel'],
                          time:
                              '${item['jamMulai']} - ${item['jamSelesai']}',
                          jamKe: item['jamKe'],
                          isReadOnly: false,
                          isEditMode: true,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined,
                      size: 16, color: Colors.white),
                  label: Text('Edit',
                      style: AppTextStyles.cardTitle
                          .copyWith(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
