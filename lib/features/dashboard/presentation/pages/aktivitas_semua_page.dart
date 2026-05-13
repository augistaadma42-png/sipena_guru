import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class AktivitasSemua extends StatefulWidget {
  const AktivitasSemua({Key? key}) : super(key: key);

  @override
  State<AktivitasSemua> createState() => _AktivitasSemuaState();
}

class _AktivitasSemuaState extends State<AktivitasSemua> {
  DateTime? _selectedDate;
  String _selectedJenis = 'Semua Aktivitas';

  final List<String> _jenisList = [
    'Semua Aktivitas',
    'Absensi',
    'Tugas',
    'Nilai',
    'Jurnal Mengajar',
    'Pengajuan Absensi',
  ];

  final List<Map<String, dynamic>> _allAktivitas = [
    {'tanggal': DateTime(2026, 5, 8), 'jam': '07.00', 'deskripsi': 'Login berhasil', 'jenis': 'sistem', 'icon': Icons.login},
    {'tanggal': DateTime(2026, 5, 8), 'jam': '13.15', 'deskripsi': 'Logout', 'jenis': 'sistem', 'icon': Icons.logout},
    {'tanggal': DateTime(2026, 5, 7), 'jam': '19.00', 'deskripsi': 'Password diubah', 'jenis': 'sistem', 'icon': Icons.lock_outline},
    {'tanggal': DateTime(2026, 5, 7), 'jam': '07.00', 'deskripsi': 'Mengisi Absensi XI RPL 1', 'jenis': 'absensi', 'icon': Icons.fact_check_outlined},
    {'tanggal': DateTime(2026, 5, 6), 'jam': '08.00', 'deskripsi': 'Mengedit absensi XI DKV 2', 'jenis': 'absensi', 'icon': Icons.edit_note_outlined},
    {'tanggal': DateTime(2026, 5, 6), 'jam': '09.00', 'deskripsi': 'Mengisi Jurnal XI RPL 1', 'jenis': 'jurnal', 'icon': Icons.book_outlined},
    {'tanggal': DateTime(2026, 5, 5), 'jam': '10.00', 'deskripsi': 'Menambah tugas Matematika', 'jenis': 'tugas', 'icon': Icons.assignment_outlined},
    {'tanggal': DateTime(2026, 5, 5), 'jam': '14.00', 'deskripsi': 'Menilai tugas XI RPL 2', 'jenis': 'nilai', 'icon': Icons.grade_outlined},
    {'tanggal': DateTime(2026, 5, 4), 'jam': '08.30', 'deskripsi': 'Menyetujui izin Augusta A.Z', 'jenis': 'pengajuan', 'icon': Icons.check_circle_outline},
  ];

  List<Map<String, dynamic>> get _filtered {
    return _allAktivitas.where((item) {
      final tanggalMatch = _selectedDate == null ||
          (item['tanggal'].year == _selectedDate!.year &&
           item['tanggal'].month == _selectedDate!.month &&
           item['tanggal'].day == _selectedDate!.day);

      final jenisMatch = _selectedJenis == 'Semua Aktivitas' ||
          _jenisMatch(item['jenis'], _selectedJenis);

      return tanggalMatch && jenisMatch;
    }).toList();
  }

  bool _jenisMatch(String jenis, String filter) {
    switch (filter) {
      case 'Absensi': return jenis == 'absensi';
      case 'Jurnal Mengajar': return jenis == 'jurnal';
      case 'Tugas': return jenis == 'tugas';
      case 'Nilai': return jenis == 'nilai';
      case 'Pengajuan Absensi': return jenis == 'pengajuan';
      default: return true;
    }
  }

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

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Semua Aktivitas', showBackButton: true),
      body: Column(
        children: [
          // Filter bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Filter tanggal
                Expanded(
                  child: GestureDetector(
                    onTap: _pickDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined,
                              size: 15, color: AppColors.primaryBlue),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _selectedDate == null
                                  ? 'Pilih Tanggal'
                                  : DateFormat('d MMM yyyy', 'id_ID')
                                      .format(_selectedDate!),
                              style: AppTextStyles.cardSubtitle
                                  .copyWith(fontSize: 12),
                            ),
                          ),
                          if (_selectedDate != null)
                            GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedDate = null),
                              child: const Icon(Icons.close,
                                  size: 14,
                                  color: AppColors.textSecondary),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Filter jenis
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedJenis,
                        icon: const Icon(Icons.keyboard_arrow_down,
                            color: AppColors.secondaryOrange, size: 16),
                        style: AppTextStyles.cardSubtitle
                            .copyWith(fontSize: 12),
                        isExpanded: true,
                        items: _jenisList
                            .map((j) => DropdownMenuItem(
                                  value: j,
                                  child: Text(j,
                                      overflow: TextOverflow.ellipsis),
                                ))
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _selectedJenis = val!),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List aktivitas
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.history,
                            size: 64,
                            color: AppColors.textSecondary.withOpacity(0.3)),
                        const SizedBox(height: 14),
                        Text('Tidak ada aktivitas',
                            style: AppTextStyles.cardSubtitle),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      final isLast = index == filtered.length - 1;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: _jenisBg(item['jenis']),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(item['icon'] as IconData,
                                    size: 18,
                                    color: _jenisColor(item['jenis'])),
                              ),
                              if (!isLast)
                                Container(
                                    width: 2,
                                    height: 36,
                                    color: AppColors.borderLight),
                            ],
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6, bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['deskripsi'],
                                      style: AppTextStyles.cardTitle
                                          .copyWith(fontSize: 13)),
                                  const SizedBox(height: 3),
                                  Text(
                                    '${DateFormat('d MMM yyyy', 'id_ID').format(item['tanggal'])} • ${item['jam']}',
                                    style: AppTextStyles.cardSubtitle
                                        .copyWith(fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
