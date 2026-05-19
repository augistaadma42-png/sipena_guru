import 'package:flutter/material.dart';
import 'package:fitur_guru/core/widgets/custom_app_bar.dart';

class LaporanAbsensiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LaporanAbsensiAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return const CustomAppBar(
      title: 'Laporan Absensi',
      showBackButton: true,
    );
  }
}
