/// MenuItem Entity
/// Represents a menu item displayed on the dashboard
class MenuItemEntity {
  final String id;
  final String title;
  final String icon;
  final int userCount;
  final String route;
  
  const MenuItemEntity({
    required this.id,
    required this.title,
    required this.icon,
    required this.userCount,
    required this.route,
  });
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MenuItemEntity && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}

/// Dashboard Statistics Entity
/// Represents overall dashboard statistics
class DashboardStats {
  final int totalAbsensi;
  final int totalNilaiAkhir;
  final int totalTugas;
  final int totalAktivitas;
  final List<MenuItemEntity> menuItems;
  
  const DashboardStats({
    required this.totalAbsensi,
    required this.totalNilaiAkhir,
    required this.totalTugas,
    required this.totalAktivitas,
    required this.menuItems,
  });
  
  /// Empty dashboard stats
  static const DashboardStats empty = DashboardStats(
    totalAbsensi: 0,
    totalNilaiAkhir: 0,
    totalTugas: 0,
    totalAktivitas: 0,
    menuItems: [],
  );
}