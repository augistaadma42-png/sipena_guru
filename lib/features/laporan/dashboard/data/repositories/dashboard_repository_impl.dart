import '../../domain/entities/menu_item.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../models/menu_item_model.dart';
import '../datasources/dashboard_local_datasource.dart';
import '../../../../../core/errors/failures.dart';

/// Repository Implementation
/// Mengimplementasikan DashboardRepository interface
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalDataSource localDataSource;
  
  DashboardRepositoryImpl({required this.localDataSource});
  
  /// Get menu items
  @override
  Future<({List<MenuItemEntity> data, Failure? error})> getMenuItems() async {
    try {
      final models = await localDataSource.getMenuItems();
      return (data: models.map((m) => m.toEntity()).toList(), error: null);
    } catch (e) {
      return (data: <MenuItemEntity>[], error: ServerFailure(message: e.toString()));
    }
  }
  
  /// Get dashboard stats
  @override
  Future<({DashboardStats data, Failure? error})> getDashboardStats() async {
    try {
      final stats = await localDataSource.getDashboardStats();
      return (data: stats, error: null);
    } catch (e) {
      return (data: DashboardStats.empty, error: ServerFailure(message: e.toString()));
    }
  }
  
  /// Get user count by menu id
  @override
  Future<({int data, Failure? error})> getUserCount(String menuId) async {
    try {
      final count = await localDataSource.getUserCount(menuId);
      return (data: count, error: null);
    } catch (e) {
      return (data: 0, error: ServerFailure(message: e.toString()));
    }
  }
}