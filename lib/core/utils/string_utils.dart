import 'package:intl/intl.dart';

/// String Utility Functions
class StringUtils {
  StringUtils._();
  
  /// Format angka Indonesia (1.000.000)
  static String formatNumber(num number) {
    return NumberFormat('#,###', 'id_ID').format(number);
  }
  
  /// Format mata uang Rupiah (Rp 1.000.000)
  static String formatCurrency(num number) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(number);
  }
  
  /// Format persentase (85%)
  static String formatPercentage(double value) {
    return '${value.toStringAsFixed(0)}%';
  }
  
  /// Capitalize kata pertama
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
  
  /// Capitalize setiap kata
  static String capitalizeEach(String text) {
    return text.split(' ').map((word) => capitalize(word)).join(' ');
  }
  
  /// Ambil inisial nama (John Doe -> JD)
  static String getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.isEmpty) return '';
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words[0][0]}${words[words.length - 1][0]}'.toUpperCase();
  }
  
  /// Potong teks panjang (ellipsis)
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength - 3)}...';
  }
  
  /// Validasi string kosong
  static bool isEmpty(String? text) {
    return text == null || text.trim().isEmpty;
  }
  
  /// Validasi string tidak kosong
  static bool isNotEmpty(String? text) {
    return !isEmpty(text);
  }
  
  /// Replace multiple spaces dengan single space
  static String normalize(String text) {
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
  
  /// Generate random string
  static String generateRandom({int length = 8}) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    return List.generate(
      length,
      (index) => chars[(random + index) % chars.length],
    ).join();
  }
}