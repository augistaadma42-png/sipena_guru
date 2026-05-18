import '../entities/menu_item.dart';
import '../../../../../core/errors/failures.dart';

/// Repository Interface for Dashboard
/// Abstract - harus diimplementasikan di data layer
abstract class DashboardRepository {
  /// Get semua menu items untuk dashboard
  /// Returns: List<MenuItemEntity> atau Failure
  Future<({List<MenuItemEntity> data, Failure? error})> getMenuItems();
  
  /// Get dashboard statistics
  /// Returns: DashboardStats atau Failure
  Future<({DashboardStats data, Failure? error})> getDashboardStats();
  
  /// Get user count untuk menu tertentu
  /// Params: menuId
  /// Returns: int atau Failure
  Future<({int data, Failure? error})> getUserCount(String menuId);
}