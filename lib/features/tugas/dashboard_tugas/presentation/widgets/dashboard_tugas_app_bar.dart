import 'package:flutter/material.dart';
import '../../../../../../core/widgets/custom_app_bar.dart';

class DashboardTugasAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget? bottom;

  const DashboardTugasAppBar({super.key, this.bottom});

  @override
  Size get preferredSize => Size.fromHeight(80.0 + (bottom?.preferredSize.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: 'Tugas',
      showBackButton: true,
      bottom: bottom,
    );
  }
}
