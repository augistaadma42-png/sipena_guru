import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({Key? key}) : super(key: key);

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  final _formKey = GlobalKey<FormState>();

  final _passwordLamaController = TextEditingController();
  final _passwordBaruController = TextEditingController();
  final _konfirmasiController = TextEditingController();

  bool _showPasswordLama = false;
  bool _showPasswordBaru = false;
  bool _showKonfirmasi = false;
  bool _isLoading = false;

  String? _errorPasswordLama;
  String? _errorPasswordBaru;
  String? _errorKonfirmasi;

  // Dummy password lama untuk validasi simulasi
  final String _passwordLamaBenar = 'password123';

  @override
  void dispose() {
    _passwordLamaController.dispose();
    _passwordBaruController.dispose();
    _konfirmasiController.dispose();
    super.dispose();
  }

  void _clearErrors() {
    setState(() {
      _errorPasswordLama = null;
      _errorPasswordBaru = null;
      _errorKonfirmasi = null;
    });
  }

  Future<void> _simpan() async {
    _clearErrors();

    final lama = _passwordLamaController.text;
    final baru = _passwordBaruController.text;
    final konfirmasi = _konfirmasiController.text;

    bool hasError = false;

    if (lama.isEmpty) {
      setState(() => _errorPasswordLama = 'Password lama tidak boleh kosong');
      hasError = true;
    } else if (lama != _passwordLamaBenar) {
      setState(() => _errorPasswordLama = 'Password lama tidak sesuai');
      hasError = true;
    }

    if (baru.isEmpty) {
      setState(() => _errorPasswordBaru = 'Password baru tidak boleh kosong');
      hasError = true;
    } else if (baru.length < 8) {
      setState(() => _errorPasswordBaru = 'Password baru minimal 8 karakter');
      hasError = true;
    }

    if (konfirmasi.isEmpty) {
      setState(() => _errorKonfirmasi = 'Konfirmasi password tidak boleh kosong');
      hasError = true;
    } else if (baru != konfirmasi) {
      setState(() => _errorKonfirmasi = 'Konfirmasi password tidak cocok');
      hasError = true;
    }

    if (hasError) return;

    // Simulasi loading
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    // Reset form
    _passwordLamaController.clear();
    _passwordBaruController.clear();
    _konfirmasiController.clear();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Password berhasil diubah'),
        backgroundColor: AppColors.successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Pengaturan', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul section
            Text('Ubah Kata Sandi',
                style: AppTextStyles.sectionTitle.copyWith(fontSize: 22)),
            const SizedBox(height: 6),
            Text(
              'Pastikan kata sandi baru Anda kuat dan sulit ditebak\nuntuk menjaga keamanan akun Sipena Anda.',
              style: AppTextStyles.cardSubtitle.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 24),

            // Info hubungi admin
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9C4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF59E0B)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline,
                      size: 18, color: Color(0xFFF59E0B)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Untuk mengubah password, hubungi Admin terlebih dahulu agar password direset. Setelah itu kamu bisa mengatur password baru di sini.',
                      style: AppTextStyles.cardSubtitle.copyWith(
                          fontSize: 12, color: const Color(0xFF92400E)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Form
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Password Lama
                  _buildLabel('Masukkan Password Lama'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _passwordLamaController,
                    showPassword: _showPasswordLama,
                    onToggle: () => setState(
                        () => _showPasswordLama = !_showPasswordLama),
                    errorText: _errorPasswordLama,
                    onChanged: (_) =>
                        setState(() => _errorPasswordLama = null),
                  ),
                  const SizedBox(height: 20),

                  // Password Baru
                  _buildLabel('Masukkan Password Baru'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _passwordBaruController,
                    showPassword: _showPasswordBaru,
                    onToggle: () => setState(
                        () => _showPasswordBaru = !_showPasswordBaru),
                    errorText: _errorPasswordBaru,
                    onChanged: (_) =>
                        setState(() => _errorPasswordBaru = null),
                  ),
                  if (_errorPasswordBaru == null) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Minimal 8 karakter dengan kombinasi angka.',
                      style: AppTextStyles.cardSubtitle
                          .copyWith(fontSize: 11),
                    ),
                  ],
                  const SizedBox(height: 20),

                  // Konfirmasi Password
                  _buildLabel('Konfirmasi Password Baru'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _konfirmasiController,
                    showPassword: _showKonfirmasi,
                    onToggle: () =>
                        setState(() => _showKonfirmasi = !_showKonfirmasi),
                    errorText: _errorKonfirmasi,
                    onChanged: (_) =>
                        setState(() => _errorKonfirmasi = null),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _simpan,
                icon: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : const Icon(Icons.save_outlined,
                        color: Colors.white, size: 20),
                label: Text(
                  _isLoading ? 'Menyimpan...' : 'Simpan Perubahan',
                  style: AppTextStyles.cardTitle.copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryOrange,
                  disabledBackgroundColor:
                      AppColors.secondaryOrange.withOpacity(0.6),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text,
        style: AppTextStyles.cardTitle.copyWith(fontSize: 13));
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required bool showPassword,
    required VoidCallback onToggle,
    String? errorText,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: errorText != null
                  ? Colors.redAccent
                  : AppColors.borderLight,
              width: errorText != null ? 1.5 : 1,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: !showPassword,
            onChanged: onChanged,
            style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              suffixIcon: IconButton(
                onPressed: onToggle,
                icon: Icon(
                  showPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.error_outline,
                  size: 14, color: Colors.redAccent),
              const SizedBox(width: 5),
              Text(
                errorText,
                style: AppTextStyles.cardSubtitle.copyWith(
                    fontSize: 12, color: Colors.redAccent),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
