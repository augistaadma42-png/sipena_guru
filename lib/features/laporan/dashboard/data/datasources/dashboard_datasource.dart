import '../models/menu_item_model.dart';
import '../../domain/entities/menu_item.dart';

/// Abstract DataSource Interface
/// Untuk mengambil data dari local/remote
abstract class DashboardDataSource {
  /// Get all menu items
  Future<List<MenuItemModel>> getMenuItems();
  
  /// Get dashboard statistics
  Future<DashboardStatsModel> getDashboardStats();
  
  /// Get user count by menu id
  Future<int> getUserCount(String menuId);
}