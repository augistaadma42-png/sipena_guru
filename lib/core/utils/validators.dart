/// Validator Utility Functions
class Validators {
  Validators._();
  
  /// Validasi nama tidak kosong
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    return null;
  }
  
  /// Validasi email format Indonesia
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }
  
  /// Validasi password (min 8 karakter)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }
    return null;
  }
  
  /// Validasi nomor telepon Indonesia
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }
    // Format: 081234567890 atau +6281234567890
    final phoneRegex = RegExp(r'^(\+62|0)[0-9]{9,12}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Format nomor telepon tidak valid';
    }
    return null;
  }
  
  /// Validasi nilai (0-100)
  static String? validateNilai(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nilai tidak boleh kosong';
    }
    final nilai = int.tryParse(value);
    if (nilai == null || nilai < 0 || nilai > 100) {
      return 'Nilai harus antara 0-100';
    }
    return null;
  }
  
  /// Validasi URL
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null; // URL optional
    }
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$'
    );
    if (!urlRegex.hasMatch(value)) {
      return 'Format URL tidak valid';
    }
    return null;
  }
}