import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import 'pengaturan_notifikasi_page.dart';

enum JenisNotif { absensi, tugasKumpul, tugasBelumDinilai, pengajuan }

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({Key? key}) : super(key: key);

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  final List<Map<String, dynamic>> _notifList = [
    {
      'id': '001',
      'judul': 'Absensi belum diisi',
      'isi': 'Absensi kelas XI-PSPT 2 belum diisi hari ini.',
      'jenis': JenisNotif.absensi,
      'waktu': DateTime.now().subtract(const Duration(minutes: 10)),
      'dibaca': false,
    },
    {
      'id': '002',
      'judul': 'Tugas dikumpulkan',
      'isi': 'Augista A.Z telah mengumpulkan tugas Latihan Soal Bab 3.',
      'jenis': JenisNotif.tugasKumpul,
      'waktu': DateTime.now().subtract(const Duration(hours: 1)),
      'dibaca': false,
    },
    {
      'id': '003',
      'judul': 'Tugas belum dinilai',
      'isi': 'Tugas Matematika Bab 2 belum dinilai — deadline sudah lewat.',
      'jenis': JenisNotif.tugasBelumDinilai,
      'waktu': DateTime.now().subtract(const Duration(hours: 3)),
      'dibaca': false,
    },
    {
      'id': '004',
      'judul': 'Pengajuan tidak masuk',
      'isi': 'Terdapat pengajuan tidak masuk dari Feby Shandi S. — Sakit.',
      'jenis': JenisNotif.pengajuan,
      'waktu': DateTime.now().subtract(const Duration(hours: 5)),
      'dibaca': false,
    },
    {
      'id': '005',
      'judul': 'Absensi belum diisi',
      'isi': 'Absensi kelas X-RPL 2 belum diisi hari ini.',
      'jenis': JenisNotif.absensi,
      'waktu': DateTime.now().subtract(const Duration(days: 1)),
      'dibaca': true,
    },
    {
      'id': '006',
      'judul': 'Pengajuan tidak masuk',
      'isi': 'Terdapat pengajuan tidak masuk dari Fariskha A.F — Izin.',
      'jenis': JenisNotif.pengajuan,
      'waktu': DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      'dibaca': true,
    },
    {
      'id': '007',
      'judul': 'Tugas belum dinilai',
      'isi': 'Tugas Kuis Harian XI RPL 2 belum dinilai — deadline sudah lewat.',
      'jenis': JenisNotif.tugasBelumDinilai,
      'waktu': DateTime.now().subtract(const Duration(days: 2)),
      'dibaca': true,
    },
  ];

  int get _jumlahBelumDibaca =>
      _notifList.where((n) => !(n['dibaca'] as bool)).length;

  void _tandaiSemuaDibaca() {
    setState(() {
      for (final n in _notifList) n['dibaca'] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Semua notifikasi ditandai sudah dibaca'),
        backgroundColor: AppColors.successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _tandaiDibaca(String id) {
    setState(() {
      final idx = _notifList.indexWhere((n) => n['id'] == id);
      if (idx != -1) _notifList[idx]['dibaca'] = true;
    });
  }

  void _hapus(String id) {
    setState(() => _notifList.removeWhere((n) => n['id'] == id));
  }

  Color _jenisColor(JenisNotif jenis) {
    switch (jenis) {
      case JenisNotif.absensi: return AppColors.primaryBlue;
      case JenisNotif.tugasKumpul: return AppColors.successGreen;
      case JenisNotif.tugasBelumDinilai: return AppColors.secondaryOrange;
      case JenisNotif.pengajuan: return const Color(0xFF1565C0);
    }
  }

  Color _jenisBg(JenisNotif jenis) {
    switch (jenis) {
      case JenisNotif.absensi: return AppColors.primaryBlue.withOpacity(0.1);
      case JenisNotif.tugasKumpul: return const Color(0xFFE8F5E9);
      case JenisNotif.tugasBelumDinilai: return const Color(0xFFFFF3E0);
      case JenisNotif.pengajuan: return const Color(0xFFE3F2FD);
    }
  }

  IconData _jenisIcon(JenisNotif jenis) {
    switch (jenis) {
      case JenisNotif.absensi: return Icons.fact_check_outlined;
      case JenisNotif.tugasKumpul: return Icons.inbox_outlined;
      case JenisNotif.tugasBelumDinilai: return Icons.access_time_outlined;
      case JenisNotif.pengajuan: return Icons.person_off_outlined;
    }
  }

  String _formatWaktu(DateTime waktu) {
    final diff = DateTime.now().difference(waktu);
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    if (diff.inDays == 1) return 'Kemarin';
    return DateFormat('d MMM yyyy', 'id_ID').format(waktu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Notifikasi', showBackButton: true),
      body: Column(
        children: [
          // Header: tandai semua + pengaturan
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Jumlah belum dibaca
                Text(
                  _jumlahBelumDibaca > 0
                      ? '$_jumlahBelumDibaca belum dibaca'
                      : 'Semua sudah dibaca',
                  style: AppTextStyles.cardSubtitle.copyWith(fontSize: 13),
                ),
                Row(
                  children: [
                    if (_jumlahBelumDibaca > 0)
                      GestureDetector(
                        onTap: _tandaiSemuaDibaca,
                        child: Text(
                          'Tandai Semua Dibaca',
                          style: AppTextStyles.labelStyle.copyWith(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    if (_jumlahBelumDibaca > 0) const SizedBox(width: 12),
                    // Tombol pengaturan notifikasi
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PengaturanNotifikasiPage(),
                        ),
                      ),
                      child: const Icon(Icons.tune_outlined,
                          size: 20, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.borderLight),

          // List notifikasi
          Expanded(
            child: _notifList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.notifications_none_outlined,
                            size: 72,
                            color: AppColors.textSecondary.withOpacity(0.3)),
                        const SizedBox(height: 16),
                        Text('Tidak ada notifikasi',
                            style: AppTextStyles.sectionTitle
                                .copyWith(color: AppColors.textSecondary)),
                        const SizedBox(height: 8),
                        Text('Semua notifikasi sudah dibaca',
                            style: AppTextStyles.cardSubtitle),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: _notifList.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, color: AppColors.borderLight),
                    itemBuilder: (context, index) {
                      final notif = _notifList[index];
                      final jenis = notif['jenis'] as JenisNotif;
                      final dibaca = notif['dibaca'] as bool;

                      return Dismissible(
                        key: Key(notif['id']),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          color: Colors.redAccent,
                          child: const Icon(Icons.delete_outline,
                              color: Colors.white),
                        ),
                        onDismissed: (_) => _hapus(notif['id']),
                        child: Container(
                          color: dibaca
                              ? Colors.white
                              : const Color(0xFFEEF4FF),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Icon jenis + dot biru
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: _jenisBg(jenis),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(_jenisIcon(jenis),
                                        size: 22, color: _jenisColor(jenis)),
                                  ),
                                  // Dot biru belum dibaca
                                  if (!dibaca)
                                    Positioned(
                                      right: -2,
                                      top: -2,
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryBlue,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(width: 14),

                              // Konten notif
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            notif['judul'],
                                            style: AppTextStyles.cardTitle
                                                .copyWith(
                                              fontSize: 13,
                                              fontWeight: dibaca
                                                  ? FontWeight.w500
                                                  : FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          _formatWaktu(notif['waktu']),
                                          style: AppTextStyles.cardSubtitle
                                              .copyWith(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      notif['isi'],
                                      style: AppTextStyles.cardSubtitle
                                          .copyWith(fontSize: 12),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    // Tombol tandai dibaca per item
                                    if (!dibaca) ...[
                                      const SizedBox(height: 8),
                                      GestureDetector(
                                        onTap: () =>
                                            _tandaiDibaca(notif['id']),
                                        child: Text(
                                          'Tandai Sudah Dibaca',
                                          style: AppTextStyles.labelStyle
                                              .copyWith(
                                            color: AppColors.primaryBlue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
