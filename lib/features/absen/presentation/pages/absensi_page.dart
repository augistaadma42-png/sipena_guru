import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';
import 'input_absensi_tab.dart';
import 'riwayat_absensi_tab.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/absen_bloc.dart';
import '../bloc/absen_event.dart';
import '../bloc/absen_state.dart';
import '../../domain/entities/leave_request_entity.dart';
import '../../data/datasources/absen_local_datasource.dart';
import '../../data/repositories/absen_repository_impl.dart';
import '../../domain/usecases/get_riwayat_absensi_usecase.dart';
import '../../domain/usecases/get_student_attendance_usecase.dart';
import '../../domain/usecases/get_leave_requests_usecase.dart';
import '../../domain/usecases/update_leave_request_status_usecase.dart';

class AbsensiPage extends StatelessWidget {
  const AbsensiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final ds = AbsenLocalDatasourceImpl();
        final repo = AbsenRepositoryImpl(localDatasource: ds);
        return AbsenBloc(
          getRiwayatAbsensiUsecase: GetRiwayatAbsensiUsecase(repo),
          getStudentAttendanceUsecase: GetStudentAttendanceUsecase(repo),
          getLeaveRequestsUsecase: GetLeaveRequestsUsecase(repo),
          updateLeaveRequestStatusUsecase: UpdateLeaveRequestStatusUsecase(repo),
        );
      },
      child: const _AbsensiPageContent(),
    );
  }
}

class _AbsensiPageContent extends StatefulWidget {
  const _AbsensiPageContent({Key? key}) : super(key: key);

  @override
  State<_AbsensiPageContent> createState() => _AbsensiPageContentState();
}

class _AbsensiPageContentState extends State<_AbsensiPageContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Absensi'),
      drawer: const CustomDrawer(),
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
              labelStyle: AppTextStyles.cardTitle.copyWith(fontSize: 13),
              unselectedLabelStyle:
                  AppTextStyles.cardSubtitle.copyWith(fontSize: 13),
              tabs: const [
                Tab(text: 'Input Absensi'),
                Tab(text: 'Riwayat'),
                Tab(text: 'Izin/Sakit'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                InputAbsensiTab(),
                RiwayatAbsensiTab(),
                _ManajemenIzinWrapper(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Wrapper agar ManajemenIzinPage bisa ditampilkan sebagai tab (tanpa Scaffold baru)
class _ManajemenIzinWrapper extends StatefulWidget {
  const _ManajemenIzinWrapper({Key? key}) : super(key: key);

  @override
  State<_ManajemenIzinWrapper> createState() => _ManajemenIzinWrapperState();
}

class _ManajemenIzinWrapperState extends State<_ManajemenIzinWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _ManajemenIzinTabContent();
  }
}

class _ManajemenIzinTabContent extends StatefulWidget {
  const _ManajemenIzinTabContent({Key? key}) : super(key: key);

  @override
  State<_ManajemenIzinTabContent> createState() =>
      _ManajemenIzinTabContentState();
}

class _ManajemenIzinTabContentState extends State<_ManajemenIzinTabContent>
    with SingleTickerProviderStateMixin {
  late TabController _innerTab;

  @override
  void initState() {
    super.initState();
    _innerTab = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AbsenBloc>().add(LoadLeaveRequestsEvent());
    });
  }

  @override
  void dispose() {
    _innerTab.dispose();
    super.dispose();
  }

  void _setujui(String id) {
    context.read<AbsenBloc>().add(UpdateLeaveRequestStatusEvent(id: id, status: 'approved'));
    _snack('Pengajuan berhasil disetujui', AppColors.successGreen);
  }

  void _tolak(String id) {
    context.read<AbsenBloc>().add(UpdateLeaveRequestStatusEvent(id: id, status: 'rejected'));
    _snack('Pengajuan telah ditolak', Colors.redAccent);
  }

  void _snack(String msg, Color color) {
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

  void _lihatBukti(LeaveRequestEntity item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => _BuktiSheet(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenBloc, AbsenState>(
      builder: (context, state) {
        List<LeaveRequestEntity> listMenunggu = [];
        List<LeaveRequestEntity> listDisetujui = [];
        List<LeaveRequestEntity> listDitolak = [];

        if (state is LeaveRequestsLoaded) {
          listMenunggu = state.leaveRequests.where((p) => p.status == 'pending').toList();
          listDisetujui = state.leaveRequests.where((p) => p.status == 'approved').toList();
          listDitolak = state.leaveRequests.where((p) => p.status == 'rejected').toList();
        }

        return Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _innerTab,
                labelColor: AppColors.primaryBlue,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.secondaryOrange,
                indicatorWeight: 2,
                labelStyle: AppTextStyles.cardTitle.copyWith(fontSize: 12),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Menunggu'),
                        const SizedBox(width: 5),
                        if (listMenunggu.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryOrange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${listMenunggu.length}',
                              style: AppTextStyles.cardTitle
                                  .copyWith(color: Colors.white, fontSize: 10),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const Tab(text: 'Disetujui'),
                  const Tab(text: 'Ditolak'),
                ],
              ),
            ),
            Expanded(
              child: state is AbsenLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state is AbsenError
                      ? Center(child: Text(state.message))
                      : TabBarView(
                          controller: _innerTab,
                          children: [
                            _IzinList(
                                items: listMenunggu,
                                onSetujui: _setujui,
                                onTolak: _tolak,
                                onBukti: _lihatBukti,
                                empty: 'Tidak ada pengajuan menunggu'),
                            _IzinList(
                                items: listDisetujui,
                                onBukti: _lihatBukti,
                                empty: 'Belum ada pengajuan disetujui'),
                            _IzinList(
                                items: listDitolak,
                                onBukti: _lihatBukti,
                                empty: 'Belum ada pengajuan ditolak'),
                          ],
                        ),
            ),
          ],
        );
      },
    );
  }
}

// ─── List 

class _IzinList extends StatelessWidget {
  final List<LeaveRequestEntity> items;
  final void Function(String)? onSetujui;
  final void Function(String)? onTolak;
  final void Function(LeaveRequestEntity) onBukti;
  final String empty;

  const _IzinList({
    required this.items,
    this.onSetujui,
    this.onTolak,
    required this.onBukti,
    required this.empty,
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
            const SizedBox(height: 14),
            Text(empty, style: AppTextStyles.cardSubtitle),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (_, i) => _IzinCard(
        item: items[i],
        onSetujui: onSetujui != null ? () => onSetujui!(items[i].id) : null,
        onTolak: onTolak != null ? () => onTolak!(items[i].id) : null,
        onBukti: () => onBukti(items[i]),
      ),
    );
  }
}

// ─── Card 

class _IzinCard extends StatelessWidget {
  final LeaveRequestEntity item;
  final VoidCallback? onSetujui;
  final VoidCallback? onTolak;
  final VoidCallback onBukti;

  const _IzinCard({
    required this.item,
    this.onSetujui,
    this.onTolak,
    required this.onBukti,
  });

  Color get _jenisColor {
    switch (item.type) {
      case 'Sakit': return const Color(0xFF1565C0);
      case 'Izin': return const Color(0xFFF57F17);
      case 'Dispen': return const Color(0xFF6A1B9A);
      default: return AppColors.textSecondary;
    }
  }

  Color get _jenisBg {
    switch (item.type) {
      case 'Sakit': return const Color(0xFFE3F2FD);
      case 'Izin': return const Color(0xFFFFF9C4);
      case 'Dispen': return const Color(0xFFF3E5F5);
      default: return Colors.grey[200]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String status = item.status;
    final menunggu = status == 'pending';

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
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                child: Text(item.initials,
                    style: AppTextStyles.cardTitle
                        .copyWith(color: AppColors.primaryBlue, fontSize: 14)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.studentName,
                        style: AppTextStyles.cardTitle.copyWith(fontSize: 14)),
                    Text(
                        'NISN: ${item.nisn} • ${item.className}',
                        style:
                            AppTextStyles.cardSubtitle.copyWith(fontSize: 12)),
                    const SizedBox(height: 2),
                    Text(
                        '${item.date.day}-${item.date.month}-${item.date.year}',
                        style:
                            AppTextStyles.cardSubtitle.copyWith(fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: _jenisBg,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(item.type,
                    style: AppTextStyles.labelStyle.copyWith(
                        color: _jenisColor, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.borderLight),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.notes_outlined,
                  size: 15, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(item.reason,
                    style: AppTextStyles.cardSubtitle.copyWith(fontSize: 13)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                item.suratAda ? Icons.attach_file : Icons.cancel_outlined,
                size: 15,
                color: item.suratAda ? AppColors.primaryBlue : Colors.redAccent,
              ),
              const SizedBox(width: 6),
              Text(
                item.suratAda
                    ? 'Surat keterangan tersedia'
                    : 'Tidak ada surat keterangan',
                style: AppTextStyles.cardSubtitle.copyWith(
                    fontSize: 12,
                    color: item.suratAda
                        ? AppColors.primaryBlue
                        : Colors.redAccent),
              ),
              if (item.suratAda) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: onBukti,
                  child: Text('— Lihat Bukti',
                      style: AppTextStyles.labelStyle.copyWith(
                          color: AppColors.secondaryOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ],
          ),
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
                    icon: const Icon(Icons.check, size: 16, color: Colors.white),
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
          ] else ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  status == 'approved'
                      ? Icons.check_circle
                      : Icons.cancel,
                  size: 16,
                  color: status == 'approved'
                      ? AppColors.successGreen
                      : Colors.redAccent,
                ),
                const SizedBox(width: 6),
                Text(
                  status == 'approved'
                      ? 'Pengajuan disetujui'
                      : 'Pengajuan ditolak',
                  style: AppTextStyles.labelStyle.copyWith(
                    color: status == 'approved'
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

// ─── Bottom Sheet Bukti

class _BuktiSheet extends StatelessWidget {
  final LeaveRequestEntity item;
  const _BuktiSheet({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 20),
          Text('Bukti Surat Keterangan',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 18)),
          const SizedBox(height: 6),
          Text('${item.studentName} • ${item.type} • ${item.date.day}-${item.date.month}-${item.date.year}',
              style: AppTextStyles.cardSubtitle),
          const SizedBox(height: 20),
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
                  item.type == 'Sakit'
                      ? Icons.local_hospital_outlined
                      : Icons.description_outlined,
                  size: 56,
                  color: AppColors.primaryBlue.withOpacity(0.4),
                ),
                const SizedBox(height: 12),
                Text(
                  'surat_${item.type.toLowerCase()}_${item.nisn}.pdf',
                  style: AppTextStyles.cardSubtitle,
                ),
                const SizedBox(height: 6),
                Text('Pratinjau dokumen (Simulasi)',
                    style: AppTextStyles.labelStyle.copyWith(fontSize: 11)),
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