import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';
import '../widgets/absensi_card.dart';

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({Key? key}) : super(key: key);

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  DateTime _selectedDate = DateTime(2024, 5, 24);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Filter tanggal diterapkan (Simulasi)'),
          backgroundColor: AppColors.successGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Format date simple like "Senin, 24 Mei 2024"
    final formattedDate = '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Absensi'),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Panduan Absensi Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF002369), Color(0xFF1E3A8A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.lightbulb_outline, color: AppColors.secondaryOrange, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Panduan Absensi',
                            style: AppTextStyles.cardTitle.copyWith(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Absensi dilakukan per sesi mata pelajaran. Pastikan anda mengisi daftar hadir untuk sesi yang sedang berlangsung',
                            style: AppTextStyles.cardSubtitle.copyWith(color: Colors.white.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Date Filter
              InkWell(
                onTap: () => _selectDate(context),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.primaryBlue),
                          const SizedBox(width: 8),
                          Text(
                            formattedDate, // Akan menggunakan package intl untuk format riil nanti
                            style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      const Icon(Icons.keyboard_arrow_down, color: AppColors.secondaryOrange),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Absensi List
              const AbsensiCard(
                initialStatus: AbsensiStatus.berlangsung,
                time: '10:00 - 11:20',
                jamKe: 'Jam Ke 5-7',
                className: 'XI RPL 1',
                subject: 'Bahasa Indonesia',
              ),
              const AbsensiCard(
                initialStatus: AbsensiStatus.mendatang,
                time: '13:00 - 14:20',
                jamKe: 'Jam Ke 8-10',
                className: 'XI RPL 2',
                subject: 'Bahasa Indonesia',
              ),
              const AbsensiCard(
                initialStatus: AbsensiStatus.selesai,
                time: '07:00 - 08:20',
                jamKe: 'Jam Ke 1-2',
                className: 'X DKV 1',
                subject: 'Bahasa Indonesia',
              ),
              const AbsensiCard(
                initialStatus: AbsensiStatus.selesai,
                time: '08:20 - 09:40',
                jamKe: 'Jam Ke 3-4',
                className: 'XI TKJT 2',
                subject: 'Bahasa Indonesia',
              ),
              const SizedBox(height: 80), // bottom padding for sticky nav
            ],
          ),
        ),
      ),
    );
  }
}
