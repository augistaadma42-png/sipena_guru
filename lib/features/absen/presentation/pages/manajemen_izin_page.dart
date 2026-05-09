import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';

enum StatusPengajuan { menunggu, disetujui, ditolak }

class ManajemenIzinPage extends StatefulWidget {
  const ManajemenIzinPage({Key? key}) : super(key: key);

  @override
  State<ManajemenIzinPage> createState() => _ManajemenIzinPageState();
}

class _ManajemenIzinPageState extends State<ManajemenIzinPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _pengajuanList = [
    {
      'id': '001',
      'initials': 'AA',
      'nama': 'Augusta A.Z',
      'nisn': '2001001',
      'kelas': 'XI RPL 1',
      'jenis': 'Izin',
      'tanggal': '24 Mei 2024',
      'alasan': 'Keperluan keluarga mendesak',
      'suratAda': true,
      'status': StatusPengajuan.menunggu,
    },
    {
      'id': '002',
      'initials': 'RS',
      'nama': 'Reby Shandi S.',
      'nisn': '2022002',
      'kelas': 'XI RPL 1',
      'jenis': 'Sakit',
      'tanggal': '24 Mei 2024',
      'alasan': 'Demam dan sakit kepala',
      'suratAda': true,
      'status': StatusPengajuan.menunggu,
    },
    {
      'id': '003',
      'initials': 'GK',
      'nama': 'Savin K.H',
      'nisn': '2022992',
      'kelas': 'XI RPL 2',
      'jenis': 'Dispen',
      'tanggal': '24 Mei 2024',
      'alasan': 'Mewakili sekolah lomba LKS tingkat provinsi',
      'suratAda': true,
      'status': StatusPengajuan.disetujui,
    },
    {
      'id': '004',
      'initials': 'FA',
      'nama': 'Farisalha A.F',
      'nisn': '2001001',
      'kelas': 'X DKV 1',
      'jenis': 'Izin',
      'tanggal': '21 Mei 2024',
      'alasan': 'Acara pernikahan saudara',
      'suratAda': false,
      'status': StatusPengajuan.ditolak,
    },
    {
      'id': '005',
      'initials': 'DA',
      'nama': 'Devita A.V.P',
      'nisn': '2002991',
      'kelas': 'XI RPL 2',
      'jenis': 'Sakit',
      'tanggal': '20 Mei 2024',
      'alasan': 'Gastritis kambuh',
      'suratAda': true,
      'status': StatusPengajuan.menunggu,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _filteredList(StatusPengajuan status) =>
      _pengajuanList.where((p) => p['status'] == status).toList();

  void _setujui(String id) {
    setState(() {
      final idx = _pengajuanList.indexWhere((p) => p['id'] == id);
      if (idx != -1) _pengajuanList[idx]['status'] = StatusPengajuan.disetujui;
    });
    _showSnack('Pengajuan berhasil disetujui', AppColors.successGreen);
  }

  void _tolak(String id) {
    setState(() {
      final idx = _pengajuanList.indexWhere((p) => p['id'] == id);
      if (idx != -1) _pengajuanList[idx]['status'] = StatusPengajuan.ditolak;
    });
    _showSnack('Pengajuan telah ditolak', Colors.redAccent);
  }

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _lihatBukti(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _BuktiBottomSheet(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(
          title: 'Manajemen Izin / Sakit / Dispen',
          showBackButton: true),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primaryBlue,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.secondaryOrange,
              indicatorWeight: 3,
              labelStyle:
                  AppTextStyles.cardTitle.copyWith(fontSize: 13),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Menunggu'),
                      const SizedBox(width: 6),
                      _CountBadge(
                          count: _filteredList(StatusPengajuan.menunggu)
                              .length),
                    ],
                  ),
                ),
                const Tab(text: 'Disetujui'),
                const Tab(text: 'Ditolak'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _PengajuanList(
                  items: _filteredList(StatusPengajuan.menunggu),
                  onSetujui: _setujui,
                  onTolak: _tolak,
                  onLihatBukti: _lihatBukti,
                  emptyLabel: 'Tidak ada pengajuan menunggu',
                ),
                _PengajuanList(
                  items: _filteredList(StatusPengajuan.disetujui),
                  onLihatBukti: _lihatBukti,
                  emptyLabel: 'Belum ada pengajuan disetujui',
                ),
                _PengajuanList(
                  items: _filteredList(StatusPengajuan.ditolak),
                  onLihatBukti: _lihatBukti,
                  emptyLabel: 'Belum ada pengajuan ditolak',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tab Count Badge ────────────────────────────────────────────────────────

class _CountBadge extends StatelessWidget {
  final int count;
  const _CountBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    if (count == 0) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.secondaryOrange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$count',
        style:
            AppTextStyles.cardTitle.copyWith(color: Colors.white, fontSize: 11),
      ),
    );
  }
}

// ─── List Widget ─────────────────────────────────────────────────────────────

class _PengajuanList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final void Function(String id)? onSetujui;
  final void Function(String id)? onTolak;
  final void Function(Map<String, dynamic> item) onLihatBukti;
  final String emptyLabel;

  const _PengajuanList({
    required this.items,
    this.onSetujui,
    this.onTolak,
    required this.onLihatBukti,
    required this.emptyLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined,
                size: 64,
                color: AppColors.textSecondary.withOpacity(0.3)),
            const SizedBox(height: 16),
            Text(emptyLabel,
                style: AppTextStyles.cardSubtitle
                    .copyWith(fontSize: 14)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _PengajuanCard(
          item: item,
          onSetujui: onSetujui != null
              ? () => onSetujui!(item['id'])
              : null,
          onTolak:
              onTolak != null ? () => onTolak!(item['id']) : null,
          onLihatBukti: () => onLihatBukti(item),
        );
      },
    );
  }
}

// ─── Card Widget ─────────────────────────────────────────────────────────────

class _PengajuanCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback? onSetujui;
  final VoidCallback? onTolak;
  final VoidCallback onLihatBukti;

  const _PengajuanCard({
    required this.item,
    this.onSetujui,
    this.onTolak,
    required this.onLihatBukti,
  });

  Color get _jenisColor {
    switch (item['jenis']) {
      case 'Sakit': return const Color(0xFF1565C0);
      case 'Izin': return const Color(0xFFF57F17);
      case 'Dispen': return const Color(0xFF6A1B9A);
      default: return AppColors.textSecondary;
    }
  }

  Color get _jenisBgColor {
    switch (item['jenis']) {
      case 'Sakit': return const Color(0xFFE3F2FD);
      case 'Izin': return const Color(0xFFFFF9C4);
      case 'Dispen': return const Color(0xFFF3E5F5);
      default: return Colors.grey[200]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final StatusPengajuan status = item['status'];
    final bool menunggu = status == StatusPengajuan.menunggu;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
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
          // Baris atas: avatar + info + badge jenis
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                child: Text(item['initials'],
                    style: AppTextStyles.cardTitle.copyWith(
                        color: AppColors.primaryBlue, fontSize: 14)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['nama'],
                        style: AppTextStyles.cardTitle.copyWith(fontSize: 14)),
                    Text('NISN: ${item['nisn']} • ${item['kelas']}',
                        style: AppTextStyles.cardSubtitle
                            .copyWith(fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(item['tanggal'],
                        style: AppTextStyles.cardSubtitle
                            .copyWith(fontSize: 12)),
                  ],
                ),
              ),
              // Badge jenis
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _jenisBgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(item['jenis'],
                    style: AppTextStyles.labelStyle.copyWith(
                        color: _jenisColor, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.borderLight),
          const SizedBox(height: 12),

          // Alasan
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.notes_outlined,
                  size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(item['alasan'],
                    style: AppTextStyles.cardSubtitle.copyWith(fontSize: 13)),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Surat keterangan
          Row(
            children: [
              Icon(
                item['suratAda']
                    ? Icons.attach_file
                    : Icons.cancel_outlined,
                size: 16,
                color: item['suratAda']
                    ? AppColors.primaryBlue
                    : Colors.redAccent,
              ),
              const SizedBox(width: 6),
              Text(
                item['suratAda']
                    ? 'Surat keterangan tersedia'
                    : 'Tidak ada surat keterangan',
                style: AppTextStyles.cardSubtitle.copyWith(
                  fontSize: 12,
                  color: item['suratAda']
                      ? AppColors.primaryBlue
                      : Colors.redAccent,
                ),
              ),
              if (item['suratAda']) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: onLihatBukti,
                  child: Text(
                    '— Lihat Bukti',
                    style: AppTextStyles.labelStyle.copyWith(
                      color: AppColors.secondaryOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ],
          ),

          // Tombol aksi (hanya saat menunggu)
          if (menunggu) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onTolak,
                    icon: const Icon(Icons.close, size: 16,
                        color: Colors.redAccent),
                    label: const Text('Tolak'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      side: const BorderSide(color: Colors.redAccent),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onSetujui,
                    icon: const Icon(Icons.check, size: 16,
                        color: Colors.white),
                    label: const Text('Setujui'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.successGreen,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
          ],

          // Status badge (setelah diproses)
          if (!menunggu) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  status == StatusPengajuan.disetujui
                      ? Icons.check_circle
                      : Icons.cancel,
                  size: 16,
                  color: status == StatusPengajuan.disetujui
                      ? AppColors.successGreen
                      : Colors.redAccent,
                ),
                const SizedBox(width: 6),
                Text(
                  status == StatusPengajuan.disetujui
                      ? 'Pengajuan disetujui'
                      : 'Pengajuan ditolak',
                  style: AppTextStyles.labelStyle.copyWith(
                    color: status == StatusPengajuan.disetujui
                        ? AppColors.successGreen
                        : Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Bottom Sheet Lihat Bukti ─────────────────────────────────────────────

class _BuktiBottomSheet extends StatelessWidget {
  final Map<String, dynamic> item;

  const _BuktiBottomSheet({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text('Bukti Surat Keterangan',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 18)),
          const SizedBox(height: 6),
          Text('${item['nama']} • ${item['jenis']} • ${item['tanggal']}',
              style: AppTextStyles.cardSubtitle),
          const SizedBox(height: 20),

          // Preview surat (simulasi)
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item['jenis'] == 'Sakit'
                      ? Icons.local_hospital_outlined
                      : Icons.description_outlined,
                  size: 56,
                  color: AppColors.primaryBlue.withOpacity(0.5),
                ),
                const SizedBox(height: 12),
                Text(
                  'surat_keterangan_${item['jenis'].toString().toLowerCase()}.pdf',
                  style: AppTextStyles.cardSubtitle,
                ),
                const SizedBox(height: 8),
                Text(
                  'Pratinjau dokumen (Simulasi)',
                  style: AppTextStyles.labelStyle.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.download_outlined, color: Colors.white),
              label: const Text('Unduh Surat'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.borderLight),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
              ),
              child: Text('Tutup',
                  style: AppTextStyles.cardTitle
                      .copyWith(color: AppColors.textSecondary)),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
