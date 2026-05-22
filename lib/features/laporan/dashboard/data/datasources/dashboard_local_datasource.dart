import 'dashboard_datasource.dart';
import '../models/menu_item_model.dart';

/// Local DataSource Implementation
/// Dummy data - akan diganti dengan API call
class DashboardLocalDataSource implements DashboardDataSource {
  @override
  Future<List<MenuItemModel>> getMenuItems() async {
    // Dummy data - ini akan diganti dengan API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    return const [
      MenuItemModel(
        id: 'absensi',
        title: 'Rekap Absensi',
        icon: 'absensi',
        userCount: 17,
        route: '/absensi',
      ),
      MenuItemModel(
        id: 'nilai_akhir',
        title: 'Rekap Nilai Akhir',
        icon: 'nilai',
        userCount: 8,
        route: '/nilai-akhir',
      ),
      MenuItemModel(
        id: 'tugas',
        title: 'Rekap Tugas',
        icon: 'tugas',
        userCount: 15,
        route: '/tugas',
      ),
      MenuItemModel(
        id: 'aktivitas',
        title: 'Rekap Aktivitas',
        icon: 'aktivitas',
        userCount: 22,
        route: '/aktivitas',
      ),
    ];
  }
  
  @override
  Future<DashboardStatsModel> getDashboardStats() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final menuItems = await getMenuItems();
    
    return DashboardStatsModel(
      totalAbsensi: 17,
      totalNilaiAkhir: 8,
      totalTugas: 15,
      totalAktivitas: 22,
      menuItems: menuItems,
    );
  }
  
  @override
  Future<int> getUserCount(String menuId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final menuItems = await getMenuItems();
    final item = menuItems.firstWhere(
      (m) => m.id == menuId,
      orElse: () => const MenuItemModel(
        id: '',
        title: '',
        icon: '',
        userCount: 0,
        route: '',
      ),
    );
    
    return item.userCount;
  }
}