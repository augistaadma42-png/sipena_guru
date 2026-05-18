import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import 'input_absensi_tab.dart';
import 'detail_absensi_page.dart';

class AbsensiDariJadwalPage extends StatelessWidget {
  final String className;
  final String subject;
  final String time;
  final String jamKe;
  final bool isReadOnly;

  const AbsensiDariJadwalPage({
    Key? key,
    required this.className,
    required this.subject,
    required this.time,
    required this.jamKe,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Jika sudah diisi (isReadOnly = true), tampilkan detail absensi (view)
    // Jika belum diisi (isReadOnly = false), tampilkan form input absensi
    if (isReadOnly) {
      return DetailAbsensiPage(
        className: className,
        subject: subject,
        time: time,
        jamKe: jamKe,
        isReadOnly: true,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Isi Absensi', showBackButton: true),
      body: InputAbsensiTab(prefilledKelas: className),
    );
  }
}
