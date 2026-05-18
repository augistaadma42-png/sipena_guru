import '../../domain/entities/menu_item.dart';

/// MenuItem Model
/// Data model untuk menu item (dari API/Local storage)
class MenuItemModel extends MenuItemEntity {
  const MenuItemModel({
    required super.id,
    required super.title,
    required super.icon,
    required super.userCount,
    required super.route,
  });
  
  /// Create from JSON
  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      icon: json['icon'] as String,
      userCount: json['userCount'] as int,
      route: json['route'] as String,
    );
  }
  
  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'userCount': userCount,
      'route': route,
    };
  }
  
  /// Create from Entity
  factory MenuItemModel.fromEntity(MenuItemEntity entity) {
    return MenuItemModel(
      id: entity.id,
      title: entity.title,
      icon: entity.icon,
      userCount: entity.userCount,
      route: entity.route,
    );
  }
  
  /// Convert to Entity
  MenuItemEntity toEntity() {
    return MenuItemEntity(
      id: id,
      title: title,
      icon: icon,
      userCount: userCount,
      route: route,
    );
  }
  
  /// Copy with
  MenuItemModel copyWith({
    String? id,
    String? title,
    String? icon,
    int? userCount,
    String? route,
  }) {
    return MenuItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      userCount: userCount ?? this.userCount,
      route: route ?? this.route,
    );
  }
}

/// DashboardStats Model
/// Data model untuk statistik dashboard
class DashboardStatsModel extends DashboardStats {
  const DashboardStatsModel({
    required super.totalAbsensi,
    required super.totalNilaiAkhir,
    required super.totalTugas,
    required super.totalAktivitas,
    required super.menuItems,
  });
  
  /// Create from JSON
  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    final menuItemsJson = json['menuItems'] as List<dynamic>? ?? [];
    
    return DashboardStatsModel(
      totalAbsensi: json['totalAbsensi'] as int? ?? 0,
      totalNilaiAkhir: json['totalNilaiAkhir'] as int? ?? 0,
      totalTugas: json['totalTugas'] as int? ?? 0,
      totalAktivitas: json['totalAktivitas'] as int? ?? 0,
      menuItems: menuItemsJson
          .map((item) => MenuItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
  
  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'totalAbsensi': totalAbsensi,
      'totalNilaiAkhir': totalNilaiAkhir,
      'totalTugas': totalTugas,
      'totalAktivitas': totalAktivitas,
      'menuItems': menuItems
          .map((item) => MenuItemModel.fromEntity(item).toJson())
          .toList(),
    };
  }
  
  /// Create from Entity
  factory DashboardStatsModel.fromEntity(DashboardStats entity) {
    return DashboardStatsModel(
      totalAbsensi: entity.totalAbsensi,
      totalNilaiAkhir: entity.totalNilaiAkhir,
      totalTugas: entity.totalTugas,
      totalAktivitas: entity.totalAktivitas,
      menuItems: entity.menuItems,
    );
  }
  
  /// Copy with
  DashboardStatsModel copyWith({
    int? totalAbsensi,
    int? totalNilaiAkhir,
    int? totalTugas,
    int? totalAktivitas,
    List<MenuItemEntity>? menuItems,
  }) {
    return DashboardStatsModel(
      totalAbsensi: totalAbsensi ?? this.totalAbsensi,
      totalNilaiAkhir: totalNilaiAkhir ?? this.totalNilaiAkhir,
      totalTugas: totalTugas ?? this.totalTugas,
      totalAktivitas: totalAktivitas ?? this.totalAktivitas,
      menuItems: menuItems ?? this.menuItems,
    );
  }
}