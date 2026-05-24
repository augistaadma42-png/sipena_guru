import 'package:flutter/material.dart';
import '../../../../../../core/widgets/custom_app_bar.dart';

class DashboardTugasAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  // [CHANGE 1] Tambah parameter namaKelas agar judul jadi "Tugas XII IPA 1"
  final String namaKelas;

  const DashboardTugasAppBar({
    super.key,
    this.bottom,
    required this.namaKelas,
  });

  @override
  Size get preferredSize => Size.fromHeight(80.0 + (bottom?.preferredSize.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: 'Tugas $namaKelas', // [CHANGE 1] judul dinamis
      showBackButton: true,
      bottom: bottom,
    );
  }
}
