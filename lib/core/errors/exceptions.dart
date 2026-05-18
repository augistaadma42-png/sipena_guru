/// Base Exception Class
abstract class AppException implements Exception {
  final String message;
  final int? code;
  
  const AppException({required this.message, this.code});
  
  @override
  String toString() => message;
}

/// Server Exception - Untuk error dari API/server
class ServerException extends AppException {
  const ServerException({required super.message, super.code});
}

/// Cache Exception - Untuk error saat mengambil/menyimpan data lokal
class CacheException extends AppException {
  const CacheException({required super.message, super.code});
}

/// Network Exception - Untuk error koneksi internet
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Tidak ada koneksi internet',
    super.code,
  });
}

/// Validation Exception - Untuk error validasi input
class ValidationException extends AppException {
  final String field;
  
  const ValidationException({
    required super.message,
    required this.field,
    super.code,
  });
  
  @override
  String toString() => 'ValidationError: $field - $message';
}

/// Not Found Exception - Untuk data yang tidak ditemukan
class NotFoundException extends AppException {
  final String resource;
  
  const NotFoundException({
    required super.message,
    required this.resource,
    super.code,
  });
  
  @override
  String toString() => '$resource tidak ditemukan';
}

/// Permission Exception - Untuk error akses/permission
class PermissionException extends AppException {
  const PermissionException({
    super.message = 'Akses ditolak',
    super.code,
  });
}