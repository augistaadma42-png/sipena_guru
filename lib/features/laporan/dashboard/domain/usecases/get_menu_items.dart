import '../entities/menu_item.dart';
import '../repositories/dashboard_repository.dart';

/// UseCase: Get Menu Items
/// Mendapatkan semua menu item untuk dashboard
class GetMenuItemsUseCase {
  final DashboardRepository repository;
  
  GetMenuItemsUseCase(this.repository);
  
  /// Execute use case
  /// Returns: List<MenuItemEntity>
  Future<({List<MenuItemEntity> data, String? error})> call() async {
    final result = await repository.getMenuItems();
    
    if (result.error != null) {
      return (data: <MenuItemEntity>[], error: result.error!.message);
    }
    
    return (data: result.data, error: null);
  }
}

/// UseCase: Get Dashboard Stats
/// Mendapatkan statistik keseluruhan dashboard
class GetDashboardStatsUseCase {
  final DashboardRepository repository;
  
  GetDashboardStatsUseCase(this.repository);
  
  /// Execute use case
  /// Returns: DashboardStats
  Future<({DashboardStats data, String? error})> call() async {
    final result = await repository.getDashboardStats();
    
    if (result.error != null) {
      return (data: DashboardStats.empty, error: result.error!.message);
    }
    
    return (data: result.data, error: null);
  }
}

/// UseCase: Get User Count
/// Mendapatkan jumlah user untuk menu tertentu
class GetUserCountUseCase {
  final DashboardRepository repository;
  
  GetUserCountUseCase(this.repository);
  
  /// Execute use case
  /// Params: menuId
  /// Returns: int
  Future<({int data, String? error})> call(String menuId) async {
    final result = await repository.getUserCount(menuId);
    
    if (result.error != null) {
      return (data: 0, error: result.error!.message);
    }
    
    return (data: result.data, error: null);
  }
}