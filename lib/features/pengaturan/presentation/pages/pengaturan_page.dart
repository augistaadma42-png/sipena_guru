import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../bloc/pengaturan_bloc.dart';
import '../bloc/pengaturan_event.dart';
import '../bloc/pengaturan_state.dart';
import '../../data/datasources/pengaturan_local_datasource.dart';
import '../../data/repositories/pengaturan_repository_impl.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/ubah_password_usecase.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final ds = PengaturanLocalDatasourceImpl();
        final repo = PengaturanRepositoryImpl(localDatasource: ds);
        return PengaturanBloc(
          getProfileUsecase: GetProfileUsecase(repo),
          ubahPasswordUsecase: UbahPasswordUsecase(repo),
        )..add(LoadProfileEvent());
      },
      child: const _PengaturanPageContent(),
    );
  }
}

class _PengaturanPageContent extends StatefulWidget {
  const _PengaturanPageContent({Key? key}) : super(key: key);

  @override
  State<_PengaturanPageContent> createState() => _PengaturanPageContentState();
}

class _PengaturanPageContentState extends State<_PengaturanPageContent> {
  final _passwordLamaController = TextEditingController();
  final _passwordBaruController = TextEditingController();
  final _konfirmasiController = TextEditingController();

  bool _showPasswordLama = false;
  bool _showPasswordBaru = false;
  bool _showKonfirmasi = false;

  String? _errorPasswordLama;
  String? _errorPasswordBaru;
  String? _errorKonfirmasi;

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

  void _handleError(String message) {
    _clearErrors();
    final parts = message.split(':');
    if (parts.length >= 2) {
      final field = parts[0];
      final msg = parts.sublist(1).join(':');
      setState(() {
        if (field == 'lama') _errorPasswordLama = msg;
        else if (field == 'baru') _errorPasswordBaru = msg;
        else if (field == 'konfirmasi') _errorKonfirmasi = msg;
        else _errorPasswordLama = msg;
      });
    }
  }

  void _simpan() {
    _clearErrors();
    context.read<PengaturanBloc>().add(
      UbahPasswordEvent(
        passwordLama: _passwordLamaController.text,
        passwordBaru: _passwordBaruController.text,
        konfirmasi: _konfirmasiController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Pengaturan', showBackButton: true),
      body: BlocConsumer<PengaturanBloc, PengaturanState>(
        listener: (context, state) {
          if (state is PasswordChanged) {
            _passwordLamaController.clear();
            _passwordBaruController.clear();
            _konfirmasiController.clear();
            _clearErrors();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Password berhasil diubah'),
                backgroundColor: AppColors.successGreen,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            );
          } else if (state is PengaturanError) {
            _handleError(state.message);
          }
        },
        builder: (context, state) {
          if (state is PengaturanLoading || state is PengaturanInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          final isLoading = state is PasswordSaving;

          // Ambil profil dari berbagai state
          final profile = switch (state) {
            ProfileLoaded s => s.profile,
            PasswordSaving s => s.profile,
            PasswordChanged s => s.profile,
            PengaturanError s => s.profile,
            _ => null,
          };

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Kartu Profil Guru
                if (profile != null) ...[
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1B3C73), Color(0xFF2d5299)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1B3C73).withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          child: Text(
                            profile.nama.isNotEmpty
                                ? profile.nama[0].toUpperCase()
                                : 'G',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.nama,
                                style: AppTextStyles.sectionTitle.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                profile.jabatan,
                                style: AppTextStyles.cardSubtitle.copyWith(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                profile.mapel,
                                style: AppTextStyles.cardSubtitle.copyWith(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'NIP: ${profile.nip}',
                                style: AppTextStyles.labelStyle.copyWith(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // ── Judul Section Ubah Password
                Text('Ubah Kata Sandi',
                    style:
                        AppTextStyles.sectionTitle.copyWith(fontSize: 22)),
                const SizedBox(height: 6),
                Text(
                  'Pastikan kata sandi baru Anda kuat dan sulit ditebak\nuntuk menjaga keamanan akun Sipena Anda.',
                  style:
                      AppTextStyles.cardSubtitle.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 24),

                // ── Info hubungi admin
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
                              fontSize: 12,
                              color: const Color(0xFF92400E)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Form
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderLight),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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

                // ── Tombol Simpan
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : _simpan,
                    icon: isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : const Icon(Icons.save_outlined,
                            color: Colors.white, size: 20),
                    label: Text(
                      isLoading ? 'Menyimpan...' : 'Simpan Perubahan',
                      style: AppTextStyles.cardTitle
                          .copyWith(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryOrange,
                      disabledBackgroundColor:
                          AppColors.secondaryOrange.withValues(alpha: 0.6),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTextStyles.cardTitle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required bool showPassword,
    required VoidCallback onToggle,
    String? errorText,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      controller: controller,
      obscureText: !showPassword,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: errorText != null
                ? AppColors.errorRed
                : AppColors.borderLight,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: errorText != null
                ? AppColors.errorRed
                : AppColors.primaryBlue,
            width: 1.5,
          ),
        ),
        errorText: errorText,
        errorStyle: AppTextStyles.labelStyle.copyWith(
          color: AppColors.errorRed,
          fontSize: 11,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: AppColors.textSecondary,
            size: 20,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}
