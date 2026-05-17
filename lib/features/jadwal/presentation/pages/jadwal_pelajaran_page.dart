import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';
import '../widgets/jadwal_header_card.dart';

class JamSlot {
  final String label;
  final String jamSenKam;
  final String jamJumat;
  final bool isIstirahat;

  const JamSlot({
    required this.label,
    required this.jamSenKam,
    required this.jamJumat,
    this.isIstirahat = false,
  });
}

class JadwalSlot {
  final String hari;
  final int jamKe;
  final String mapel;
  final String kelas;
  final String ruang;

  const JadwalSlot({
    required this.hari,
    required this.jamKe,
    required this.mapel,
    required this.kelas,
    required this.ruang,
  });
}

class JadwalPelajaranPage extends StatefulWidget {
  const JadwalPelajaranPage({Key? key}) : super(key: key);

  @override
  State<JadwalPelajaranPage> createState() => _JadwalPelajaranPageState();
}

class _JadwalPelajaranPageState extends State<JadwalPelajaranPage> {
  static const List<JamSlot> _slots = [
    JamSlot(label: '1',  jamSenKam: '07:00 - 07:40', jamJumat: '07:00 - 07:30'),
    JamSlot(label: '2',  jamSenKam: '07:40 - 08:20', jamJumat: '07:30 - 08:00'),
    JamSlot(label: '3',  jamSenKam: '08:20 - 09:00', jamJumat: '08:00 - 08:30'),
    JamSlot(label: '4',  jamSenKam: '09:00 - 09:40', jamJumat: '08:30 - 09:00'),
    JamSlot(label: 'Istirahat', jamSenKam: '09:40 - 10:00', jamJumat: '09:00 - 09:30', isIstirahat: true),
    JamSlot(label: '5',  jamSenKam: '10:00 - 10:40', jamJumat: '09:30 - 09:50'),
    JamSlot(label: '6',  jamSenKam: '10:40 - 11:20', jamJumat: '09:50 - 10:20'),
    JamSlot(label: '7',  jamSenKam: '11:20 - 12:00', jamJumat: '10:20 - 10:50'),
    JamSlot(label: 'Istirahat', jamSenKam: '12:00 - 13:00', jamJumat: '11:20 - 13:00', isIstirahat: true),
    JamSlot(label: '8',  jamSenKam: '13:00 - 13:40', jamJumat: '13:00 - 13:30'),
    JamSlot(label: '9',  jamSenKam: '13:40 - 14:20', jamJumat: '13:30 - 14:00'),
    JamSlot(label: '10', jamSenKam: '14:20 - 15:00', jamJumat: '14:00 - 14:30'),
    JamSlot(label: '11', jamSenKam: '-',              jamJumat: '14:30 - 15:00'),
    JamSlot(label: '12', jamSenKam: '-',              jamJumat: '14:30 - 15:00'),
  ];

  static const List<String> _hariList = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];

  static const List<JadwalSlot> _jadwalData = [
    JadwalSlot(hari: 'Senin',  jamKe: 1,  mapel: 'Bahasa Indonesia', kelas: 'XI-RPL 1', ruang: 'R.04'),
    JadwalSlot(hari: 'Senin',  jamKe: 2,  mapel: 'Bahasa Indonesia', kelas: 'XI-RPL 1', ruang: 'R.04'),
    JadwalSlot(hari: 'Senin',  jamKe: 5,  mapel: 'Bahasa Indonesia', kelas: 'X-RPL 1',  ruang: 'R.12'),
    JadwalSlot(hari: 'Senin',  jamKe: 6,  mapel: 'Bahasa Indonesia', kelas: 'X-RPL 1',  ruang: 'R.12'),
    JadwalSlot(hari: 'Selasa', jamKe: 1,  mapel: 'Bahasa Indonesia', kelas: 'XI-RPL 2', ruang: 'Lab RPL 1'),
    JadwalSlot(hari: 'Selasa', jamKe: 2,  mapel: 'Bahasa Indonesia', kelas: 'XI-RPL 2', ruang: 'Lab RPL 1'),
    JadwalSlot(hari: 'Selasa', jamKe: 3,  mapel: 'Bahasa Indonesia', kelas: 'XI-RPL 2', ruang: 'Lab RPL 1'),
    JadwalSlot(hari: 'Selasa', jamKe: 5,  mapel: 'Bahasa Indonesia', kelas: 'XI-TKJ 2', ruang: 'Lab TKJ 1'),
    JadwalSlot(hari: 'Rabu',   jamKe: 3,  mapel: 'Bahasa Indonesia', kelas: 'X-TKJ 3',  ruang: 'R.17'),
    JadwalSlot(hari: 'Kamis',  jamKe: 1,  mapel: 'Bahasa Indonesia', kelas: 'XI-ULW 1', ruang: 'R.54'),
    JadwalSlot(hari: 'Kamis',  jamKe: 2,  mapel: 'Bahasa Indonesia', kelas: 'XI-ULW 1', ruang: 'R.54'),
    JadwalSlot(hari: 'Jumat',  jamKe: 1,  mapel: 'Bahasa Indonesia', kelas: 'XI-BD 1',  ruang: 'R.40'),
    JadwalSlot(hari: 'Jumat',  jamKe: 2,  mapel: 'Bahasa Indonesia', kelas: 'XI-BD 1',  ruang: 'R.40'),
    JadwalSlot(hari: 'Jumat',  jamKe: 5,  mapel: 'Bahasa Indonesia', kelas: 'XI-MP 2',  ruang: 'R.19'),
    JadwalSlot(hari: 'Jumat',  jamKe: 6,  mapel: 'Bahasa Indonesia', kelas: 'XI-MP 2',  ruang: 'R.19'),
  ];

  // Ukuran kolom
  static const double _colJamKe   = 55;
  static const double _colSenKam  = 110;
  static const double _colJumat   = 100;
  static const double _colHari    = 130;
  static const double _rowHeight  = 56;
  static const double _headerH1   = 36;
  static const double _headerH2   = 30;

  JadwalSlot? _getJadwal(String hari, int jamKe) {
    try {
      return _jadwalData.firstWhere((j) => j.hari == hari && j.jamKe == jamKe);
    } catch (_) {
      return null;
    }
  }

  int _slotToJamKe(JamSlot slot) => int.tryParse(slot.label) ?? -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Jadwal Pelajaran'),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
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
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildCustomTable(),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTable() {
    final totalWidth = _colJamKe + _colSenKam + _colJumat + (_colHari * 5);

    return SizedBox(
      width: totalWidth,
      child: Column(
        children: [
          // ── HEADER BARIS 1 
          
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
          // ── HEADER BARIS 2 
          SizedBox(
            height: _headerH2,
            child: Row(
              children: [
                _hCell('Jam\nKe-', _colJamKe, _headerH2, color: const Color(0xFF1B3C73)),
                _hCell('Sen - Kam', _colSenKam, _headerH2, color: const Color(0xFFE06020)),
                _hCell('Jumat', _colJumat, _headerH2, color: const Color(0xFFE06020)),
                ..._hariList.map((h) =>
                    _hCell(h, _colHari, _headerH2, color: const Color(0xFF2d5299))),
              ],
            ),
          ),
          // ── DATA ROWS 
          ..._slots.asMap().entries.map((entry) {
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
                    final jadwal = _getJadwal(hari, jamKe);
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

  // ── Header cell 

  Widget _hCell(String text, double width, double height, {Color? color}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? const Color(0xFF002369),
        border: const Border(
          right: BorderSide(color: Color(0xFF2d5299), width: 0.5),
          bottom: BorderSide(color: Color(0xFF2d5299), width: 0.5),
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

  // ── Jam ke cell

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

  // ── Waktu cell 

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
            color: waktu == '-'
                ? AppColors.textSecondary
                : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  // ── Jadwal cell 

  Widget _jadwalCell(JadwalSlot jadwal) {
    return Container(
      width: _colHari,
      height: _rowHeight,
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.07),
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

  // ── Empty cell 

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

  // ── Istirahat row ────────────────────────────────────────────────────

  Widget _istirahatRow(JamSlot slot, double totalWidth) {
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

