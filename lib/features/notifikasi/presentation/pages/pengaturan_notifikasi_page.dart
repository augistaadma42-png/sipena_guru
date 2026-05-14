import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class PengaturanNotifikasiPage extends StatefulWidget {
  const PengaturanNotifikasiPage({Key? key}) : super(key: key);

  @override
  State<PengaturanNotifikasiPage> createState() =>
      _PengaturanNotifikasiPageState();
}

class _PengaturanNotifikasiPageState extends State<PengaturanNotifikasiPage> {
  // Toggle states
  bool _notifInternal = true;
  bool _notifEmail = false;

  // Per-jenis internal
  bool _notifAbsensi = true;
  bool _notifTugasKumpul = true;
  bool _notifTugasBelumDinilai = true;
  bool _notifPengajuan = true;

  void _showToast(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        backgroundColor: AppColors.successGreen,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildToggleItem({
    required String judul,
    required String deskripsi,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool enabled = true,
    IconData? icon,
    Color? iconColor,
  }) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.primaryBlue).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon,
                  size: 18, color: iconColor ?? AppColors.primaryBlue),
            ),
            const SizedBox(width: 14),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(judul,
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 14)),
                const SizedBox(height: 2),
                Text(deskripsi,
                    style:
                        AppTextStyles.cardSubtitle.copyWith(fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeColor: Colors.white,
            activeTrackColor: AppColors.successGreen,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: AppColors.borderLight,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(
          title: 'Pengaturan Notifikasi', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Notifikasi Internal
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
                  // Header toggle utama
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.notifications_outlined,
                            color: AppColors.primaryBlue, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Notifikasi Internal',
                                style: AppTextStyles.sectionTitle
                                    .copyWith(fontSize: 15)),
                            Text(
                              'Notifikasi di dalam aplikasi',
                              style: AppTextStyles.cardSubtitle
                                  .copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _notifInternal,
                        onChanged: (val) {
                          setState(() => _notifInternal = val);
                          _showToast(val
                              ? 'Notifikasi internal diaktifkan'
                              : 'Notifikasi internal dinonaktifkan');
                        },
                        activeColor: Colors.white,
                        activeTrackColor: AppColors.successGreen,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: AppColors.borderLight,
                      ),
                    ],
                  ),

                  // Per-jenis (hanya tampil kalau notif internal aktif)
                  if (_notifInternal) ...[
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: AppColors.borderLight),
                    const SizedBox(height: 16),
                    Text('Jenis Notifikasi',
                        style: AppTextStyles.labelStyle
                            .copyWith(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 14),

                    _buildToggleItem(
                      judul: 'Absensi Belum Diisi',
                      deskripsi: 'Ingatkan jika ada kelas yang belum diabsen',
                      value: _notifAbsensi,
                      icon: Icons.fact_check_outlined,
                      iconColor: AppColors.primaryBlue,
                      onChanged: (val) {
                        setState(() => _notifAbsensi = val);
                        _showToast(val
                            ? 'Notifikasi absensi diaktifkan'
                            : 'Notifikasi absensi dinonaktifkan');
                      },
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: AppColors.borderLight),
                    const SizedBox(height: 16),

                    _buildToggleItem(
                      judul: 'Siswa Kumpul Tugas',
                      deskripsi: 'Notif saat siswa mengumpulkan tugas',
                      value: _notifTugasKumpul,
                      icon: Icons.inbox_outlined,
                      iconColor: AppColors.successGreen,
                      onChanged: (val) {
                        setState(() => _notifTugasKumpul = val);
                        _showToast(val
                            ? 'Notifikasi pengumpulan tugas diaktifkan'
                            : 'Notifikasi pengumpulan tugas dinonaktifkan');
                      },
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: AppColors.borderLight),
                    const SizedBox(height: 16),

                    _buildToggleItem(
                      judul: 'Tugas Belum Dinilai',
                      deskripsi: 'Ingatkan jika ada tugas lewat deadline belum dinilai',
                      value: _notifTugasBelumDinilai,
                      icon: Icons.access_time_outlined,
                      iconColor: AppColors.secondaryOrange,
                      onChanged: (val) {
                        setState(() => _notifTugasBelumDinilai = val);
                        _showToast(val
                            ? 'Notifikasi tugas belum dinilai diaktifkan'
                            : 'Notifikasi tugas belum dinilai dinonaktifkan');
                      },
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: AppColors.borderLight),
                    const SizedBox(height: 16),

                    _buildToggleItem(
                      judul: 'Pengajuan Tidak Masuk',
                      deskripsi: 'Notif saat ada siswa mengajukan izin/sakit/dispen',
                      value: _notifPengajuan,
                      icon: Icons.person_off_outlined,
                      iconColor: const Color(0xFF1565C0),
                      onChanged: (val) {
                        setState(() => _notifPengajuan = val);
                        _showToast(val
                            ? 'Notifikasi pengajuan diaktifkan'
                            : 'Notifikasi pengajuan dinonaktifkan');
                      },
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ── Notifikasi Email 
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.email_outlined,
                            color: AppColors.secondaryOrange, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Notifikasi Email',
                                    style: AppTextStyles.sectionTitle
                                        .copyWith(fontSize: 15)),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundLight,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColors.borderLight),
                                  ),
                                  child: Text('Opsional',
                                      style: AppTextStyles.labelStyle
                                          .copyWith(fontSize: 10)),
                                ),
                              ],
                            ),
                            Text(
                              'Kirim ringkasan harian ke email',
                              style: AppTextStyles.cardSubtitle
                                  .copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _notifEmail,
                        onChanged: (val) {
                          setState(() => _notifEmail = val);
                          _showToast(val
                              ? 'Notifikasi email diaktifkan'
                              : 'Notifikasi email dinonaktifkan');
                        },
                        activeColor: Colors.white,
                        activeTrackColor: AppColors.successGreen,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: AppColors.borderLight,
                      ),
                    ],
                  ),
                  if (_notifEmail) ...[
                    const SizedBox(height: 14),
                    const Divider(height: 1, color: AppColors.borderLight),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.alternate_email,
                              size: 16, color: AppColors.textSecondary),
                          const SizedBox(width: 10),
                          Text('umikulsumspd@sekolah.sch.id',
                              style: AppTextStyles.cardSubtitle
                                  .copyWith(fontSize: 13)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ringkasan aktivitas akan dikirim setiap hari pukul 18.00',
                      style: AppTextStyles.cardSubtitle.copyWith(fontSize: 11),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
