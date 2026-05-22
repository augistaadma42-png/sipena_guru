import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/notifikasi_entity.dart';
import '../bloc/notifikasi_bloc.dart';
import '../bloc/notifikasi_event.dart';
import '../bloc/notifikasi_state.dart';
import '../../data/datasources/notifikasi_local_datasource.dart';
import '../../data/repositories/notifikasi_repository_impl.dart';
import '../../domain/usecases/get_notifikasi_usecase.dart';
import '../../domain/usecases/mark_as_read_usecase.dart';
import '../../domain/usecases/mark_all_as_read_usecase.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final ds = NotifikasiLocalDatasourceImpl();
        final repo = NotifikasiRepositoryImpl(localDatasource: ds);
        return NotifikasiBloc(
          getNotifikasiUsecase: GetNotifikasiUsecase(repo),
          markAsReadUsecase: MarkAsReadUsecase(repo),
          markAllAsReadUsecase: MarkAllAsReadUsecase(repo),
        )..add(LoadNotifikasiEvent());
      },
      child: const _NotifikasiPageContent(),
    );
  }
}

class _NotifikasiPageContent extends StatefulWidget {
  const _NotifikasiPageContent({Key? key}) : super(key: key);
  @override
  State<_NotifikasiPageContent> createState() => _NotifikasiPageContentState();
}

class _NotifikasiPageContentState extends State<_NotifikasiPageContent> {
  void _tandaiSemuaDibaca(BuildContext context) {
    context.read<NotifikasiBloc>().add(MarkAllAsReadEvent());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Semua notifikasi ditandai sudah dibaca'),
        backgroundColor: AppColors.successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _tandaiDibaca(BuildContext context, String id) {
    context.read<NotifikasiBloc>().add(MarkAsReadEvent(id));
  }

  Widget _buildNotifItem(BuildContext context, NotifikasiEntity notif) {
    IconData icon;
    Color iconColor;
    Color bgColor;

    switch (notif.jenis) {
      case JenisNotif.absensi:
        icon = Icons.fact_check_outlined;
        iconColor = AppColors.secondaryOrange;
        bgColor = const Color(0xFFFFF7ED);
        break;
      case JenisNotif.tugasKumpul:
        icon = Icons.assignment_turned_in_outlined;
        iconColor = AppColors.successGreen;
        bgColor = const Color(0xFFECFDF5);
        break;
      case JenisNotif.tugasBelumDinilai:
        icon = Icons.assignment_late_outlined;
        iconColor = AppColors.primaryBlue;
        bgColor = const Color(0xFFEFF6FF);
        break;
      case JenisNotif.pengajuan:
        icon = Icons.mail_outline_rounded;
        iconColor = AppColors.warningOrange;
        bgColor = const Color(0xFFFEFCE8);
        break;
    }

    return Container(
      color: notif.dibaca ? Colors.white : AppColors.primaryBlue.withOpacity(0.05),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (!notif.dibaca) _tandaiDibaca(context, notif.id);
            _tampilkanBottomSheetNotif(context, notif);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              notif.judul,
                              style: AppTextStyles.cardTitle.copyWith(
                                color: notif.dibaca
                                    ? AppColors.textPrimary
                                    : AppColors.primaryBlue,
                                fontWeight: notif.dibaca
                                    ? FontWeight.w500
                                    : FontWeight.w700,
                              ),
                            ),
                          ),
                          if (!notif.dibaca)
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(top: 6),
                              decoration: const BoxDecoration(
                                color: AppColors.secondaryOrange,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notif.isi,
                        style: AppTextStyles.cardSubtitle.copyWith(
                          color: notif.dibaca
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatWaktu(notif.waktu),
                        style: AppTextStyles.labelStyle.copyWith(
                          color: AppColors.disabledGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _tampilkanBottomSheetNotif(BuildContext context, NotifikasiEntity notif) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notif.judul, style: AppTextStyles.sectionTitle),
            const SizedBox(height: 10),
            Text(notif.isi, style: AppTextStyles.cardSubtitle),
          ],
        ),
      ),
    );
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
      body: BlocBuilder<NotifikasiBloc, NotifikasiState>(
        builder: (context, state) {
          if (state is NotifikasiLoading || state is NotifikasiInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NotifikasiError) {
            return Center(child: Text(state.message));
          }
          if (state is NotifikasiLoaded) {
            final unreadCount = state.notifikasiList.where((n) => !n.dibaca).length;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        unreadCount > 0
                            ? '$unreadCount Belum Dibaca'
                            : 'Semua telah dibaca',
                        style: AppTextStyles.labelStyle.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (unreadCount > 0)
                        InkWell(
                          onTap: () => _tandaiSemuaDibaca(context),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              'Tandai semua dibaca',
                              style: AppTextStyles.labelStyle.copyWith(
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: state.notifikasiList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.notifications_none_outlined, size: 72, color: AppColors.textSecondary.withOpacity(0.3)),
                          const SizedBox(height: 16),
                          Text('Tidak ada notifikasi', style: AppTextStyles.sectionTitle.copyWith(color: AppColors.textSecondary)),
                        ],
                      ),
                    )
                  : ListView.separated(
                    itemCount: state.notifikasiList.length,
                    separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.borderLight),
                    itemBuilder: (context, index) {
                      final notif = state.notifikasiList[index];
                      return _buildNotifItem(context, notif);
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
