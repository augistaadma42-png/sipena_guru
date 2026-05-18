import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class DetailAbsensiPage extends StatefulWidget {
  final String className;
  final String subject;
  final String time;
  final String jamKe;
  final bool isReadOnly;
  final bool isEditMode;

  const DetailAbsensiPage({
    Key? key,
    required this.className,
    required this.subject,
    required this.time,
    required this.jamKe,
    this.isReadOnly = false,
    this.isEditMode = false,
  }) : super(key: key);

  @override
  State<DetailAbsensiPage> createState() => _DetailAbsensiPageState();
}

class _DetailAbsensiPageState extends State<DetailAbsensiPage> {
  int _resetCount = 0;

  final List<Map<String, dynamic>> _dummyStudents = [
    {'initials': 'EF', 'name': 'Esa Farellio', 'nisn': '2021001', 'status': 'Hadir'},
    {'initials': 'AA', 'name': 'Augista A.Z', 'nisn': '2021002', 'status': 'Izin'},
    {'initials': 'FS', 'name': 'Feby Shandy I.', 'nisn': '2021003', 'status': 'Sakit'},
    {'initials': 'GK', 'name': 'Gavin K.H', 'nisn': '2021004', 'status': 'Alpha'},
    {'initials': 'FA', 'name': 'Fariskha A.F', 'nisn': '2021005', 'status': 'Hadir'},
    {'initials': 'DA', 'name': 'Devita A.V.P', 'nisn': '2021006', 'status': 'Hadir'},
    {'initials': 'AF', 'name': 'Anindya F.A', 'nisn': '2021007', 'status': 'Hadir'},
    {'initials': 'HA', 'name': 'Helmalia A', 'nisn': '2021008', 'status': 'Hadir'},
    {'initials': 'ER', 'name': 'Eka Rara A.A', 'nisn': '2021009', 'status': 'Hadir'},
  ];

  late List<String> _statuses;

  @override
  void initState() {
    super.initState();
    _statuses = _dummyStudents.map((s) => s['status'] as String).toList();
  }

  void _simpan() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.isEditMode
            ? 'Perubahan absensi berhasil disimpan! (Simulasi)'
            : 'Absensi berhasil disimpan! (Simulasi)'),
        backgroundColor: AppColors.successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    Navigator.pop(context);
  }

  void _reset() {
    setState(() {
      _statuses =
          _dummyStudents.map((s) => s['status'] as String).toList();
      _resetCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String appBarTitle =
        widget.isEditMode ? 'Edit Absensi' : 'Detail Absensi';

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: CustomAppBar(title: appBarTitle, showBackButton: true),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                if (widget.isReadOnly) ...[
                  _buildSummary(),
                  const SizedBox(height: 20),
                ],
                _buildStudentList(),
                if (!widget.isReadOnly) const SizedBox(height: 100),
              ],
            ),
          ),
          if (!widget.isReadOnly) _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.className,
                  style:
                      AppTextStyles.sectionTitle.copyWith(fontSize: 22)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(widget.subject,
                    style: AppTextStyles.labelStyle.copyWith(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('${widget.jamKe} (${widget.time})',
              style: AppTextStyles.cardSubtitle),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF002369),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today_outlined,
                    color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text('Senin, 24 Mei 2024',
                    style: AppTextStyles.cardTitle
                        .copyWith(color: Colors.white, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    final hadir = _statuses.where((s) => s == 'Hadir').length;
    final sakit = _statuses.where((s) => s == 'Sakit').length;
    final izin = _statuses.where((s) => s == 'Izin').length;
    final alpha = _statuses.where((s) => s == 'Alpha').length;
    final dispen = _statuses.where((s) => s == 'Dispen').length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Rekapitulasi Absensi',
              style: AppTextStyles.cardTitle.copyWith(fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _summaryItem('Hadir', '$hadir', const Color(0xFFE8F5E9),
                  const Color(0xFF2E7D32)),
              _summaryItem('Sakit', '$sakit', const Color(0xFFE3F2FD),
                  const Color(0xFF1565C0)),
              _summaryItem('Izin', '$izin', const Color(0xFFFFF9C4),
                  const Color(0xFFF57F17)),
              _summaryItem('Alpha', '$alpha', const Color(0xFFFFEBEE),
                  const Color(0xFFC62828)),
              if (dispen > 0)
                _summaryItem('Dispen', '$dispen',
                    const Color(0xFFF3E5F5), const Color(0xFF6A1B9A)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(
      String label, String count, Color bg, Color textColor) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
          child: Center(
              child: Text(count,
                  style: AppTextStyles.sectionTitle
                      .copyWith(color: textColor, fontSize: 18))),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: AppTextStyles.cardSubtitle
                .copyWith(fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildStudentList() {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Daftar Siswa',
                  style: AppTextStyles.sectionTitle.copyWith(fontSize: 16)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.secondaryOrange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('${_dummyStudents.length} Siswa',
                    style: AppTextStyles.cardTitle
                        .copyWith(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('NAMA SISWA', style: AppTextStyles.labelStyle),
                Text('STATUS', style: AppTextStyles.labelStyle),
              ],
            ),
          ),
          const SizedBox(height: 4),
          ..._dummyStudents.asMap().entries.map((entry) {
            final index = entry.key;
            final student = entry.value;
            return _DetailStudentRow(
              key: ValueKey('detail_${index}_$_resetCount'),
              index: index + 1,
              initials: student['initials'],
              name: student['name'],
              nisn: student['nisn'],
              initialStatus: _statuses[index],
              isReadOnly: widget.isReadOnly,
              onStatusChanged: widget.isReadOnly
                  ? null
                  : (val) => setState(() => _statuses[index] = val),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border:
              const Border(top: BorderSide(color: AppColors.borderLight)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: OutlinedButton(
                onPressed: _reset,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: AppColors.primaryBlue),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                ),
                child: Text('Reset',
                    style: AppTextStyles.cardTitle
                        .copyWith(color: AppColors.primaryBlue)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _simpan,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: AppColors.secondaryOrange,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                ),
                child: Text(
                    widget.isEditMode
                        ? 'Simpan Perubahan'
                        : 'Simpan Absensi',
                    style: AppTextStyles.cardTitle
                        .copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailStudentRow extends StatefulWidget {
  final int index;
  final String initials;
  final String name;
  final String nisn;
  final String initialStatus;
  final bool isReadOnly;
  final ValueChanged<String>? onStatusChanged;

  const _DetailStudentRow({
    Key? key,
    required this.index,
    required this.initials,
    required this.name,
    required this.nisn,
    required this.initialStatus,
    required this.isReadOnly,
    this.onStatusChanged,
  }) : super(key: key);

  @override
  State<_DetailStudentRow> createState() => _DetailStudentRowState();
}

class _DetailStudentRowState extends State<_DetailStudentRow> {
  late String _status;

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus;
  }

  Color get _bgColor {
    switch (_status) {
      case 'Hadir': return const Color(0xFFE8F5E9);
      case 'Izin': return const Color(0xFFFFF9C4);
      case 'Sakit': return const Color(0xFFE3F2FD);
      case 'Alpha': return const Color(0xFFFFEBEE);
      case 'Dispen': return const Color(0xFFF3E5F5);
      default: return Colors.grey[200]!;
    }
  }

  Color get _textColor {
    switch (_status) {
      case 'Hadir': return const Color(0xFF2E7D32);
      case 'Izin': return const Color(0xFFF57F17);
      case 'Sakit': return const Color(0xFF1565C0);
      case 'Alpha': return const Color(0xFFC62828);
      case 'Dispen': return const Color(0xFF6A1B9A);
      default: return Colors.grey[800]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pill = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_status,
              style: AppTextStyles.labelStyle.copyWith(
                  color: _textColor, fontWeight: FontWeight.bold)),
          if (!widget.isReadOnly) ...[
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down, size: 16, color: _textColor),
          ],
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: AppColors.borderLight))),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text('${widget.index}.',
                style: AppTextStyles.cardSubtitle.copyWith(fontSize: 13)),
          ),
          const SizedBox(width: 6),
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
            child: Text(widget.initials,
                style: AppTextStyles.cardTitle.copyWith(
                    color: AppColors.primaryBlue, fontSize: 12)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name,
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 13)),
                Text('NISN: ${widget.nisn}',
                    style: AppTextStyles.cardSubtitle
                        .copyWith(fontSize: 11)),
              ],
            ),
          ),
          widget.isReadOnly
              ? pill
              : PopupMenuButton<String>(
                  initialValue: _status,
                  onSelected: (val) {
                    setState(() => _status = val);
                    widget.onStatusChanged?.call(val);
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'Hadir', child: Text('Hadir')),
                    const PopupMenuItem(value: 'Izin', child: Text('Izin')),
                    const PopupMenuItem(value: 'Sakit', child: Text('Sakit')),
                    const PopupMenuItem(value: 'Alpha', child: Text('Alpha')),
                    const PopupMenuItem(value: 'Dispen', child: Text('Dispen')),
                  ],
                  child: pill,
                ),
        ],
      ),
    );
  }
}
