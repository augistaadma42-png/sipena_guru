import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';

class DashboardBottomNavbar extends StatelessWidget {
  const DashboardBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.borderLight, width: 1),
        ),
      ),
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.secondaryOrange,
        unselectedItemColor: AppColors.disabledGrey,
        currentIndex: 1, // 'Tugas' is active
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: AppTextStyles.labelStyle.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        unselectedLabelStyle: AppTextStyles.labelStyle.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Icon(Icons.grid_view_rounded),
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Icon(Icons.assignment_rounded),
            ),
            label: 'Tugas',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Icon(Icons.group_rounded),
            ),
            label: 'Anggota',
          ),
        ],
      ),
    );
  }
}
