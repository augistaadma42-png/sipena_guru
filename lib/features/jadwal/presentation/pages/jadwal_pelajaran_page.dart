import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';
import '../bloc/jadwal_bloc.dart';
import '../bloc/jadwal_event.dart';
import '../bloc/jadwal_state.dart';
import '../widgets/jadwal_header_card.dart';
import '../../data/datasources/jadwal_local_datasource.dart';
import '../../data/repositories/jadwal_repository_impl.dart';
import '../../domain/entities/jadwal_slot_entity.dart';
import '../../domain/entities/jam_slot_entity.dart';
import '../../domain/usecases/get_jadwal_pelajaran.dart';
import '../../domain/usecases/get_jam_slots.dart';

class JadwalPelajaranPage extends StatelessWidget {
  const JadwalPelajaranPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final ds = JadwalLocalDatasourceImpl();
        final repo = JadwalRepositoryImpl(localDatasource: ds);
        return JadwalBloc(
          getJamSlotsUsecase: GetJamSlotsUsecase(repo),
          getJadwalPelajaranUsecase: GetJadwalPelajaranUsecase(repo),
        )..add(LoadJadwalEvent());
      },
      child: const _JadwalPelajaranPageContent(),
    );
  }
}

class _JadwalPelajaranPageContent extends StatelessWidget {
  const _JadwalPelajaranPageContent({Key? key}) : super(key: key);

  static const List<String> _hariList = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];

  // Ukuran kolom
  static const double _colJamKe  = 55;
  static const double _colSenKam = 110;
  static const double _colJumat  = 100;
  static const double _colHari   = 130;
  static const double _rowHeight = 56;
  static const double _headerH1  = 36;
  static const double _headerH2  = 30;

  JadwalSlotEntity? _getJadwal(
    List<JadwalSlotEntity> jadwalData,
    String hari,
    int jamKe,
  ) {
    try {
      return jadwalData.firstWhere((j) => j.hari == hari && j.jamKe == jamKe);
    } catch (_) {
      return null;
    }
  }

  int _slotToJamKe(JamSlotEntity slot) => int.tryParse(slot.label) ?? -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Jadwal Pelajaran'),
      drawer: const CustomDrawer(),
      body: BlocBuilder<JadwalBloc, JadwalState>(
        builder: (context, state) {
          if (state is JadwalLoading || state is JadwalInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is JadwalError) {
            return Center(child: Text(state.message));
          } else if (state is JadwalLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const JadwalHeaderCard(),
                    const SizedBox(height: 24),
                    Container(
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: _buildCustomTable(state.slots, state.jadwalData),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCustomTable(
    List<JamSlotEntity> slots,
    List<JadwalSlotEntity> jadwalData,
  ) {
    final totalWidth = _colJamKe + _colSenKam + _colJumat + (_colHari * 5);

    return SizedBox(
      width: totalWidth,
      child: Column(
        children: [
          // HEADER BARIS 1
          SizedBox(
            height: _headerH1,
            child: Row(
              children: [
                _hCell('', _colJamKe, _headerH1, color: const Color(0xFF1B3C73)),
                _hCell('Waktu', _colSenKam + _colJumat, _headerH1, color: const Color(0xFFFF7B3A)),
                _hCell('Hari', _colHari * 5, _headerH1, color: const Color(0xFF1B3C73)),
              ],
            ),
          ),
          // HEADER BARIS 2
          SizedBox(
            height: _headerH2,
            child: Row(
              children: [
                _hCell('Jam\nKe-', _colJamKe, _headerH2, color: const Color(0xFF1B3C73)),
                _hCell('Sen - Kam', _colSenKam, _headerH2, color: const Color.fromARGB(255, 238, 118, 58)),
                _hCell('Jumat', _colJumat, _headerH2, color: const Color.fromARGB(255, 238, 118, 58)),
                ..._hariList.map((h) =>
                    _hCell(h, _colHari, _headerH2, color: const Color(0xFF2d5299))),
              ],
            ),
          ),
          // DATA ROWS

          ...slots.asMap().entries.map((entry) {
            final i = entry.key;
            final slot = entry.value;
            final isIstirahat = slot.isIstirahat;
            final jamKe = _slotToJamKe(slot);
            final isBg = i.isEven;

            if (isIstirahat) {
              return _istirahatRow(slot, totalWidth);
            }

            final senKamKosong = slot.label == '11' || slot.label == '12';

            return Container(
              height: _rowHeight,
              color: isBg ? Colors.white : const Color(0xFFF9FAFB),
              child: Row(
                children: [
                  _jamKeCell(slot.label),
                  _waktuCell(slot.jamSenKam, width: _colSenKam),
                  _waktuCell(slot.jamJumat, width: _colJumat),
                  ..._hariList.map((hari) {
                    final isJumat = hari == 'Jumat';
                    if (senKamKosong && !isJumat) return _emptyCell();
                    final jadwal = _getJadwal(jadwalData, hari, jamKe);
                    return jadwal != null ? _jadwalCell(jadwal) : _emptyCell();
                  }),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _hCell(String text, double width, double height, {Color? color}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? const Color(0xFF002369),
        border: const Border(
          right: BorderSide(color: Color.fromARGB(255, 254, 254, 254), width: 0.5),
          bottom: BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 0.5),
        ),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextStyles.labelStyle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  Widget _jamKeCell(String label) {
    return Container(
      width: _colJamKe,
      height: _rowHeight,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: AppColors.borderLight),
          bottom: BorderSide(color: AppColors.borderLight),
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: 13,
            color: AppColors.primaryBlue,
          ),
        ),
      ),
    );
  }

  Widget _waktuCell(String waktu, {required double width}) {
    return Container(
      width: width,
      height: _rowHeight,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: AppColors.borderLight),
          bottom: BorderSide(color: AppColors.borderLight),
        ),
      ),
      child: Center(
        child: Text(
          waktu == '-' ? '-' : waktu,
          textAlign: TextAlign.center,
          style: AppTextStyles.cardSubtitle.copyWith(
            fontSize: 10,
            color: waktu == '-' ? AppColors.textSecondary : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _jadwalCell(JadwalSlotEntity jadwal) {
    return Container(
      width: _colHari,
      height: _rowHeight,
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.07),
        border: const Border(
          right: BorderSide(color: AppColors.borderLight),
          bottom: BorderSide(color: AppColors.borderLight),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.menu_book_outlined,
                  size: 11, color: AppColors.secondaryOrange),
              const SizedBox(width: 3),
              Expanded(
                child: Text(
                  jadwal.mapel,
                  style: AppTextStyles.cardTitle.copyWith(
                    fontSize: 10,
                    color: AppColors.primaryBlue,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(jadwal.kelas,
              style: AppTextStyles.labelStyle.copyWith(fontSize: 10)),
          Text(jadwal.ruang,
              style: AppTextStyles.cardSubtitle.copyWith(fontSize: 9)),
        ],
      ),
    );
  }

  Widget _emptyCell() {
    return Container(
      width: _colHari,
      height: _rowHeight,
      decoration: const BoxDecoration(
        color: Color(0xFFF1F5F9),
        border: Border(
          right: BorderSide(color: AppColors.borderLight),
          bottom: BorderSide(color: AppColors.borderLight),
        ),
      ),
    );
  }

  Widget _istirahatRow(JamSlotEntity slot, double totalWidth) {
    return Container(
      height: 36,
      width: totalWidth,
      color: const Color(0xFFFFF9C4),
      child: Row(
        children: [
          Container(
            width: _colJamKe,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Color(0xFFF5E99A)),
                bottom: BorderSide(color: Color(0xFFF5E99A)),
              ),
            ),
            child: const Center(
              child: Icon(Icons.free_breakfast_outlined,
                  size: 16, color: Color(0xFF92400E)),
            ),
          ),
          Container(
            width: _colSenKam,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Color(0xFFF5E99A)),
                bottom: BorderSide(color: Color(0xFFF5E99A)),
              ),
            ),
            child: Center(
              child: Text(slot.jamSenKam,
                  style: AppTextStyles.labelStyle
                      .copyWith(fontSize: 10, color: const Color(0xFF92400E))),
            ),
          ),
          Container(
            width: _colJumat,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Color(0xFFF5E99A)),
                bottom: BorderSide(color: Color(0xFFF5E99A)),
              ),
            ),
            child: Center(
              child: Text(slot.jamJumat,
                  style: AppTextStyles.labelStyle
                      .copyWith(fontSize: 10, color: const Color(0xFF92400E))),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFF5E99A)),
                ),
              ),
              child: Center(
                child: Text(
                  'I s t i r a h a t',
                  style: AppTextStyles.labelStyle.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF92400E),
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
