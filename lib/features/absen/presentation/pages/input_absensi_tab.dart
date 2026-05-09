import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../jurnal/presentation/pages/jurnal_mengajar_page.dart';

class InputAbsensiTab extends StatefulWidget {
  const InputAbsensiTab({Key? key}) : super(key: key);

  @override
  State<InputAbsensiTab> createState() => _InputAbsensiTabState();
}

class _InputAbsensiTabState extends State<InputAbsensiTab> {
  final DateTime _today = DateTime.now();
  String? _selectedKelas;
  bool _tandaiSemuaHadir = false;
  int _resetCount = 0;

  final List<String> _kelasList = [
    'XI-RPL 1',
    'XI-PSPT 2',
    'XI-MP 4',
    'X-RPL 1',
    'X-TKJ 2',
    'XI-MP 4',
  ];

  final List<Map<String, dynamic>> _dummyStudents = [
    {'initials': 'EF', 'name': 'Esa Farelio', 'nisn': '2001001', 'status': 'Hadir'},
    {'initials': 'AA', 'name': 'Augista A.Z', 'nisn': '2001001', 'status': 'Hadir'},
    {'initials': 'RS', 'name': 'Feby Shandy I.', 'nisn': '2022002', 'status': 'Hadir'},
    {'initials': 'GK', 'name': 'Gavin K.H', 'nisn': '2022992', 'status': 'Hadir'},
    {'initials': 'FA', 'name': 'FarisKha F.A', 'nisn': '2001001', 'status': 'Hadir'},
    {'initials': 'DA', 'name': 'Devita A.V.P', 'nisn': '2002991', 'status': 'Hadir'},
    {'initials': 'AF', 'name': 'Anindya F.A', 'nisn': '2001007', 'status': 'Hadir'},
    {'initials': 'HA', 'name': 'Helmalia A', 'nisn': '2001008', 'status': 'Hadir'},
    {'initials': 'ER', 'name': 'Eka Rara A.A', 'nisn': '2001009', 'status': 'Hadir'},
  ];

  // Track per-student status
  late List<String> _studentStatuses;

  @override
  void initState() {
    super.initState();
    _studentStatuses =
        _dummyStudents.map((s) => s['status'] as String).toList();
  }

  String get _formattedDate =>
      DateFormat('d MMMM yyyy', 'id_ID').format(_today);

  void _onTandaiSemuaHadir(bool? val) {
    setState(() {
      _tandaiSemuaHadir = val ?? false;
      if (_tandaiSemuaHadir) {
        _studentStatuses =
            List.filled(_dummyStudents.length, 'Hadir');
      }
      _resetCount++;
    });
  }

  void _resetAbsensi() {
    setState(() {
      _selectedKelas = null;
      _tandaiSemuaHadir = false;
      _studentStatuses =
          _dummyStudents.map((s) => s['status'] as String).toList();
      _resetCount++;
    });
  }

  void _simpanAbsensi() {
    if (_selectedKelas == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Pilih kelas terlebih dahulu'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    // Simpan absensi, lalu arahkan ke jurnal dengan data terisi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Absensi berhasil disimpan! Mengarahkan ke Jurnal...'),
        backgroundColor: AppColors.successGreen,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => JurnalMengajarPage(
            initialData: {
              'className': _selectedKelas ?? '',
              'subject': 'Bahasa Indonesia',
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Panduan Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF002369), Color(0xFF1E3A8A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.lightbulb_outline,
                          color: AppColors.secondaryOrange, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'Absensi dilakukan per sesi mata pelajaran. Pastikan mengisi daftar hadir pada jam yang sedang berlangsung.',
                        style: AppTextStyles.cardSubtitle
                            .copyWith(color: Colors.white.withOpacity(0.9)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Tanggal (otomatis)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 18, color: AppColors.primaryBlue),
                    const SizedBox(width: 10),
                    Text(
                      _formattedDate,
                      style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Pilih Kelas Dropdown
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedKelas,
                    hint: Row(
                      children: [
                        const Icon(Icons.apartment_outlined,
                            size: 18, color: AppColors.primaryBlue),
                        const SizedBox(width: 10),
                        Text('Pilih Kelas',
                            style: AppTextStyles.cardSubtitle
                                .copyWith(fontSize: 14)),
                      ],
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: AppColors.secondaryOrange),
                    isExpanded: true,
                    items: _kelasList
                        .map((k) => DropdownMenuItem(
                              value: k,
                              child: Row(
                                children: [
                                  const Icon(Icons.apartment_outlined,
                                      size: 18,
                                      color: AppColors.primaryBlue),
                                  const SizedBox(width: 10),
                                  Text(k,
                                      style: AppTextStyles.cardTitle
                                          .copyWith(fontSize: 14)),
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedKelas = val;
                        _tandaiSemuaHadir = false;
                        _studentStatuses = _dummyStudents
                            .map((s) => s['status'] as String)
                            .toList();
                        _resetCount++;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Tabel Siswa (muncul setelah kelas dipilih)
              if (_selectedKelas != null) ...[
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
                      // Header Daftar Siswa
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Daftar Siswa',
                            style: AppTextStyles.sectionTitle
                                .copyWith(fontSize: 16),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryOrange,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${_dummyStudents.length} Siswa',
                                  style: AppTextStyles.cardTitle
                                      .copyWith(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Checklist Tandai Semua Hadir
                      InkWell(
                        onTap: () => _onTandaiSemuaHadir(!_tandaiSemuaHadir),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: _tandaiSemuaHadir
                                ? const Color(0xFFE8F5E9)
                                : AppColors.backgroundLight,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: _tandaiSemuaHadir
                                  ? const Color(0xFF2E7D32)
                                  : AppColors.borderLight,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _tandaiSemuaHadir
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: _tandaiSemuaHadir
                                    ? const Color(0xFF2E7D32)
                                    : AppColors.textSecondary,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Tandai semua hadir (Nihil)',
                                style: AppTextStyles.cardTitle.copyWith(
                                  fontSize: 13,
                                  color: _tandaiSemuaHadir
                                      ? const Color(0xFF2E7D32)
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Table Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('NAMA SISWA',
                                style: AppTextStyles.labelStyle),
                            Text('STATUS', style: AppTextStyles.labelStyle),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Student List
                      ..._dummyStudents.asMap().entries.map((entry) {
                        final index = entry.key;
                        final student = entry.value;
                        return _StudentRow(
                          key: ValueKey(
                              'input_student_${index}_$_resetCount'),
                          index: index + 1,
                          initials: student['initials'],
                          name: student['name'],
                          nisn: student['nisn'],
                          initialStatus: _studentStatuses[index],
                          onStatusChanged: (newStatus) {
                            setState(() {
                              _studentStatuses[index] = newStatus;
                              if (_tandaiSemuaHadir &&
                                  newStatus != 'Hadir') {
                                _tandaiSemuaHadir = false;
                              }
                            });
                          },
                        );
                      }).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ] else ...[
                // Empty state
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.groups_outlined,
                        size: 72,
                        color: AppColors.textSecondary.withOpacity(0.4),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Belum Ada Kelas Terpilih',
                        style: AppTextStyles.sectionTitle
                            .copyWith(color: AppColors.primaryBlue),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Daftar siswa akan muncul di sini setelah\nAnda menentukan kelas yang ingin\ndiproses presensinya.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.cardSubtitle,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

        // Bottom Action Bar (hanya tampil jika kelas sudah dipilih)
        if (_selectedKelas != null)
          Align(
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
                      onPressed: _resetAbsensi,
                      style: OutlinedButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: AppColors.primaryBlue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                      child: Text(
                        'Reset',
                        style: AppTextStyles.cardTitle
                            .copyWith(color: AppColors.primaryBlue),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _simpanAbsensi,
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: AppColors.secondaryOrange,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                      child: Text(
                        'Simpan Absensi',
                        style: AppTextStyles.cardTitle
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

// Widget baris siswa dengan dropdown status
class _StudentRow extends StatefulWidget {
  final int index;
  final String initials;
  final String name;
  final String nisn;
  final String initialStatus;
  final ValueChanged<String> onStatusChanged;

  const _StudentRow({
    Key? key,
    required this.index,
    required this.initials,
    required this.name,
    required this.nisn,
    required this.initialStatus,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  State<_StudentRow> createState() => _StudentRowState();
}

class _StudentRowState extends State<_StudentRow> {
  late String _status;

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus;
  }

  @override
  void didUpdateWidget(_StudentRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialStatus != widget.initialStatus) {
      _status = widget.initialStatus;
    }
  }

  Color get _bgColor {
    switch (_status) {
      case 'Hadir':
        return const Color(0xFFE8F5E9);
      case 'Izin':
        return const Color(0xFFFFF9C4);
      case 'Sakit':
        return const Color(0xFFE3F2FD);
      case 'Alpha':
        return const Color(0xFFFFEBEE);
      case 'Dispen':
        return const Color(0xFFF3E5F5);
      default:
        return Colors.grey[200]!;
    }
  }

  Color get _textColor {
    switch (_status) {
      case 'Hadir':
        return const Color(0xFF2E7D32);
      case 'Izin':
        return const Color(0xFFF57F17);
      case 'Sakit':
        return const Color(0xFF1565C0);
      case 'Alpha':
        return const Color(0xFFC62828);
      case 'Dispen':
        return const Color(0xFF6A1B9A);
      default:
        return Colors.grey[800]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderLight)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '${widget.index}.',
              style: AppTextStyles.cardSubtitle.copyWith(fontSize: 13),
            ),
          ),
          const SizedBox(width: 6),
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
            child: Text(
              widget.initials,
              style: AppTextStyles.cardTitle.copyWith(
                  color: AppColors.primaryBlue, fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name,
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 13)),
                Text('NISN ${widget.nisn}',
                    style:
                        AppTextStyles.cardSubtitle.copyWith(fontSize: 11)),
              ],
            ),
          ),
          PopupMenuButton<String>(
            initialValue: _status,
            onSelected: (val) {
              setState(() => _status = val);
              widget.onStatusChanged(val);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Hadir', child: Text('Hadir')),
              const PopupMenuItem(value: 'Izin', child: Text('Izin')),
              const PopupMenuItem(value: 'Sakit', child: Text('Sakit')),
              const PopupMenuItem(value: 'Alpha', child: Text('Alpha')),
              const PopupMenuItem(value: 'Dispen', child: Text('Dispen')),
            ],
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _bgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _status,
                    style: AppTextStyles.labelStyle.copyWith(
                        color: _textColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down,
                      size: 16, color: _textColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
