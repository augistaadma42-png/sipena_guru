import 'package:flutter/material.dart';
import 'package:fitur_guru/core/widgets/custom_app_bar.dart';

class DetailPenilaianAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int notifCount;
  const DetailPenilaianAppBar({super.key, this.notifCount = 3});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return const CustomAppBar(
      title: 'Detail & Penilaian',
      showBackButton: true,
    );
  }
}
