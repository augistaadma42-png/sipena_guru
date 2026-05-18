/// Base Failure Class
/// Abstract class untuk semua jenis failures dalam aplikasi
abstract class Failure {
  final String message;
  final int? code;
  
  const Failure({required this.message, this.code});
  
  @override
  String toString() => ' Failure: $message (code: $code)';
}

/// Server Failure - Untuk error dari API/server
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

/// Cache Failure - Untuk error saat mengambil/menyimpan data lokal
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

/// Network Failure - Untuk error koneksi internet
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Tidak ada koneksi internet',
    super.code,
  });
}

/// Validation Failure - Untuk error validasi input
class ValidationFailure extends Failure {
  final String field;
  
  const ValidationFailure({
    required super.message,
    required this.field,
    super.code,
  });
  
  @override
  String toString() => 'Validation Error pada field "$field": $message';
}

/// Not Found Failure - Untuk data yang tidak ditemukan
class NotFoundFailure extends Failure {
  final String resource;
  
  const NotFoundFailure({
    required super.message,
    required this.resource,
    super.code,
  });
  
  @override
  String toString() => '$resource tidak ditemukan: $message';
}

/// Permission Failure - Untuk error akses/permission
class PermissionFailure extends Failure {
  const PermissionFailure({
    super.message = 'Akses ditolak',
    super.code,
  });
}

/// Unknown Failure - Untuk error yang tidak diketahui
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'Terjadi kesalahan yang tidak terduga',
    super.code,
  });
}