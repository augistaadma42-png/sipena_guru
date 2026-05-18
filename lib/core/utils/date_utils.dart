import 'package:intl/intl.dart';

/// DateTime Utility Functions
class DateUtils {
  DateUtils._();
  
  /// Format tanggal Indonesia: 28/04/2026
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy', 'id_ID').format(date);
  }
  
  /// Format tanggal dengan waktu: 28 Apr 2026, 08:00
  static String formatDateTime(DateTime date) {
    return DateFormat('dd MMM yyyy, HH:mm', 'id_ID').format(date);
  }
  
  /// Format waktu HH:mm: 08:00
  static String formatTime(DateTime date) {
    return DateFormat('HH:mm', 'id_ID').format(date);
  }
  
  /// Format bulan saja: April 2026
  static String formatMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy', 'id_ID').format(date);
  }
  
  /// Format bulan pendek: Apr 2026
  static String formatMonthShort(DateTime date) {
    return DateFormat('MMM yyyy', 'id_ID').format(date);
  }
  
  /// Get nama hari Indonesia
  static String getDayName(DateTime date) {
    const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    return days[date.weekday - 1];
  }
  
  /// Get nama bulan Indonesia
  static String getMonthName(int month) {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return months[month - 1];
  }
  
  /// Parse tanggal dari string Indonesia
  static DateTime? parseDate(String dateStr) {
    try {
      return DateFormat('dd/MM/yyyy', 'id_ID').parse(dateStr);
    } catch (_) {
      return null;
    }
  }
  
  /// Hitung selisih hari
  static int daysBetween(DateTime from, DateTime to) {
    return to.difference(from).inDays;
  }
  
  /// Check apakah tanggal hari ini
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }
  
  /// Check apakah sudah overdue (lewat deadline)
  static bool isOverdue(DateTime deadline) {
    return DateTime.now().isAfter(deadline);
  }
  
  /// Get relative time string (misal: "2 hari lagi", "3 hari lalu")
  static String getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now);
    
    if (diff.isNegative) {
      // Yang akan datang
      if (diff.inDays == 0) {
        if (diff.inHours == 0) {
          return '${diff.inMinutes} menit lagi';
        }
        return '${diff.inHours} jam lagi';
      } else if (diff.inDays < 7) {
        return '${diff.inDays} hari lagi';
      } else if (diff.inDays < 30) {
        return '${(diff.inDays / 7).floor()} minggu lagi';
      } else {
        return '${(diff.inDays / 30).floor()} bulan lagi';
      }
    } else {
      // Yang lalu
      if (diff.inDays == 0) {
        if (diff.inHours == 0) {
          return '${diff.inMinutes} menit lalu';
        }
        return '${diff.inHours} jam lalu';
      } else if (diff.inDays < 7) {
        return '${diff.inDays} hari lalu';
      } else if (diff.inDays < 30) {
        return '${(diff.inDays / 7).floor()} minggu lalu';
      } else {
        return '${(diff.inDays / 30).floor()} bulan lalu';
      }
    }
  }
}