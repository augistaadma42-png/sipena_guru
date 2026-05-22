import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../bloc/absen_bloc.dart';
import '../bloc/absen_event.dart';
import '../bloc/absen_state.dart';
import '../../domain/entities/riwayat_absensi_entity.dart';
import 'detail_absensi_page.dart';

class RiwayatAbsensiTab extends StatefulWidget {
  const RiwayatAbsensiTab({Key? key}) : super(key: key);

  @override
  State<RiwayatAbsensiTab> createState() => _RiwayatAbsensiTabState();
}

class _RiwayatAbsensiTabState extends State<RiwayatAbsensiTab> {
  DateTime _selectedDate = DateTime(2026, 5, 4);
  String? _selectedKelas;

  final List<String> _kelasList = [
    'Semua Kelas',
    'XII IPA 1',
    'XII IPA 2',
    'XI IPA 1',
  ];

  @override
  void initState() {
    super.initState();
    // Gunakan post frame callback agar konteks tersedia saat provider sudah siap
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    context.read<AbsenBloc>().add(LoadRiwayatAbsensiEvent(
      date: _selectedDate,
      kelas: _selectedKelas,
    ));
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
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {

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
                      onChanged: (val) {
                        setState(() => _selectedKelas = val);
                        _loadData();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Hasil List
          BlocBuilder<AbsenBloc, AbsenState>(
            builder: (context, state) {
              if (state is AbsenLoading || state is AbsenInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AbsenError) {
                return Center(child: Text(state.message));
              } else if (state is RiwayatAbsensiLoaded) {
                if (state.riwayatList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
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
                  );
                }
                return Column(
                  children: state.riwayatList
                      .map((item) => _RiwayatCard(item: item))
                      .toList(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class _RiwayatCard extends StatelessWidget {
  final RiwayatAbsensiEntity item;

  const _RiwayatCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final bool lengkap = item.lengkap;
    final String tanggalStr =
        '${item.hari}, ${DateFormat('d MMMM yyyy', 'id_ID').format(item.tanggal)}';

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
                item.kelas,
                style: AppTextStyles.sectionTitle.copyWith(fontSize: 18),
              ),
              Text(
                '${item.jamMulai} - ${item.jamSelesai}',
                style: AppTextStyles.cardTitle.copyWith(fontSize: 13),
              ),
            ],
          ),

          // Mapel & Jam Ke
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.mapel,
                  style: AppTextStyles.cardSubtitle.copyWith(fontSize: 12)),
              Text(item.jamKe,
                  style: AppTextStyles.cardSubtitle.copyWith(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 6),

          // Jumlah hadir
          Text(
            '${item.jumlahHadir} / ${item.totalSiswa} siswa hadir',
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
                          className: item.kelas,
                          subject: item.mapel,
                          time:
                              '${item.jamMulai} - ${item.jamSelesai}',
                          jamKe: item.jamKe,
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
                          className: item.kelas,
                          subject: item.mapel,
                          time:
                              '${item.jamMulai} - ${item.jamSelesai}',
                          jamKe: item.jamKe,
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
