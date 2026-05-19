import 'package:flutter/material.dart';
import '../../../../../../core/widgets/custom_app_bar.dart';

class RekapPengumpulanAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RekapPengumpulanAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return const CustomAppBar(
      title: 'Rekap Tugas',
      showBackButton: true,
    );
  }
}
