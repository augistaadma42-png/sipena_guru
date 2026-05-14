import 'package:flutter/material.dart';
import '../../features/jadwal/presentation/pages/jadwal_pelajaran_page.dart';
import '../../features/pengaturan/presentation/pages/pengaturan_page.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: AppColors.borderLight)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 48,
                  errorBuilder: (context, error, stackTrace) => Text(
                    'Sipena',
                    style: AppTextStyles.sectionTitle.copyWith(color: AppColors.secondaryOrange, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Umi Kulsum S.pd',
                  style: AppTextStyles.sectionTitle.copyWith(fontSize: 16),
                ),
                Text(
                  'NIP. 19800101 200501 2 001',
                  style: AppTextStyles.cardSubtitle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context: context,
                  icon: Icons.dashboard_outlined,
                  title: 'Dashboard',
                  onTap: () {
                    // Navigate to MainLayout, clear stack
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.calendar_month_outlined,
                  title: 'Jadwal Pelajaran',
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                    // Push to Jadwal Pelajaran
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const JadwalPelajaranPage()),
                    );
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.settings_outlined,
                  title: 'Pengaturan',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PengaturanPage()),
                    );
                  },
                ),
                const Divider(color: AppColors.borderLight),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.logout,
                  title: 'Keluar',
                  isLogout: true,
                  onTap: () {
                    // TODO: Implement Logout
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    final color = isLogout ? Colors.red : AppColors.primaryBlue;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: AppTextStyles.cardTitle.copyWith(color: color),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }
}
