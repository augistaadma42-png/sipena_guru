import 'package:flutter/material.dart';
import 'package:fitur_guru/core/widgets/custom_app_bar.dart';

class LaporanAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LaporanAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return const CustomAppBar(
      title: 'Laporan Nilai',
      showBackButton: true,
    );
  }
}
