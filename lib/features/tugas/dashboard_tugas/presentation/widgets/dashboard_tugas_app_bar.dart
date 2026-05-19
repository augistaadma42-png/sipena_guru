import 'package:flutter/material.dart';
import '../../../../../../core/widgets/custom_app_bar.dart';

class DashboardTugasAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardTugasAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return const CustomAppBar(
      title: 'Tugas',
      showBackButton: false,
    );
  }
}
