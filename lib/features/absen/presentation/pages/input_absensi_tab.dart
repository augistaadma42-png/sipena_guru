import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/main_layout.dart';
import '../bloc/absen_bloc.dart';
import '../bloc/absen_event.dart';
import '../bloc/absen_state.dart';
import '../bloc/absen_draft_cache.dart';
import '../../domain/entities/student_attendance_entity.dart';
import '../../data/datasources/absen_local_datasource.dart';
import '../../data/models/riwayat_absensi_model.dart';

class InputAbsensiTab extends StatefulWidget {
  final String? prefilledKelas;
  final String? prefilledSubject;
  const InputAbsensiTab({Key? key, this.prefilledKelas, this.prefilledSubject}) : super(key: key);

  @override
  State<InputAbsensiTab> createState() => _InputAbsensiTabState();
}

class _InputAbsensiTabState extends State<InputAbsensiTab> with AutomaticKeepAliveClientMixin {
  final DateTime _today = DateTime.now();
  String? _selectedKelas;
  bool _tandaiSemuaHadir = false;
  int _resetCount = 0;

  @override
  bool get wantKeepAlive => true;

  final List<Map<String, String>> _kelasList = [
    {'id': 'XII IPA 1', 'name': 'XII IPA 1 — Matematika Wajib',    'subject': 'Matematika Wajib'},
    {'id': 'XII IPA 2', 'name': 'XII IPA 2 — Matematika Wajib',    'subject': 'Matematika Wajib'},
    {'id': 'XI IPA 1',  'name': 'XI IPA 1 — Matematika Peminatan', 'subject': 'Matematika Peminatan'},
  ];

  /// Mapel aktif: dari jadwal (prefilledSubject) or dari dropdown pilihan kelas.
  String get _activeSubject {
    if (widget.prefilledSubject != null) return widget.prefilledSubject!;
    final match = _kelasList.firstWhere(
      (k) => k['id'] == _selectedKelas,
      orElse: () => {},
    );
    return match['subject'] ?? '';
  }

  String get _selectedJamPelajaran {
    if (_selectedKelas == 'XII IPA 1') return '07:00 - 08:40';
    if (_selectedKelas == 'XII IPA 2') return '10:00 - 11:40';
    if (_selectedKelas == 'XI IPA 1') return '07:00 - 09:00';
    return '07:00 - 08:30';
  }

  String get _selectedJamKe {
    if (_selectedKelas == 'XII IPA 1') return 'Jam Ke 1-2';
    if (_selectedKelas == 'XII IPA 2') return 'Jam Ke 5-6';
    if (_selectedKelas == 'XI IPA 1') return 'Jam Ke 1-3';
    return 'Jam Ke 1-2';
  }

  // Track per-student status by ID
  Map<String, String> _studentStatusMap = {};
  List<StudentAttendanceEntity> _currentStudents = [];
  final Set<String> _userModifiedStudentIds = {};

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  @override
  void initState() {
    super.initState();
    // Restore from cache if available
    if (AbsenDraftCache.selectedKelas != null) {
      _selectedKelas = AbsenDraftCache.selectedKelas;
      _tandaiSemuaHadir = AbsenDraftCache.tandaiSemuaHadir ?? false;
      _studentStatusMap = Map.from(AbsenDraftCache.studentStatusMap);
      _userModifiedStudentIds.addAll(AbsenDraftCache.userModifiedStudentIds);
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<AbsenBloc>().add(LoadStudentAttendanceEvent(kelas: _selectedKelas!));
      });
    } else if (widget.prefilledKelas != null) {
      _selectedKelas = widget.prefilledKelas;
      AbsenDraftCache.selectedKelas = _selectedKelas;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<AbsenBloc>().add(LoadStudentAttendanceEvent(kelas: _selectedKelas!));
      });
    }
  }

  String get _formattedDate =>
      DateFormat('d MMMM yyyy', 'id_ID').format(_today);

  void _onTandaiSemuaHadir(bool? val) {
    setState(() {
      _tandaiSemuaHadir = val ?? false;
      AbsenDraftCache.tandaiSemuaHadir = _tandaiSemuaHadir;
      if (_tandaiSemuaHadir) {
        for (var s in _currentStudents) {
          _studentStatusMap[s.id] = 'Hadir';
          AbsenDraftCache.studentStatusMap[s.id] = 'Hadir';
          _userModifiedStudentIds.add(s.id);
          AbsenDraftCache.userModifiedStudentIds.add(s.id);
        }
      }
      _resetCount++;
    });
  }

  void _resetAbsensi() {
    setState(() {
      _selectedKelas = null;
      _tandaiSemuaHadir = false;
      _studentStatusMap.clear();
      _currentStudents.clear();
      _userModifiedStudentIds.clear();
      _resetCount++;
      AbsenDraftCache.reset();
    });
  }

  bool _isLoading = false;

  void _simpanAbsensi() {
    if (_selectedKelas == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Gagal menyimpan! Silakan pilih kelas terlebih dahulu.'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    final bool allStudentsHaveStatus = _currentStudents.isNotEmpty && 
        _currentStudents.every((s) => _studentStatusMap[s.id] != null && _studentStatusMap[s.id]!.isNotEmpty);

    if (!allStudentsHaveStatus) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Gagal menyimpan! Seluruh siswa wajib memiliki status absensi.'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });

      // Simpan ke riwayat lokal agar data ter-update secara global di aplikasi
      final countHadir = _studentStatusMap.values.where((v) => v == 'Hadir').length;
      final times = _selectedJamPelajaran.split(' - ');
      final jamMulai = times.first;
      final jamSelesai = times.last;
      
      AbsenLocalDatasourceImpl.addRiwayat(
        RiwayatAbsensiModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          tanggal: DateTime.now(),
          hari: DateFormat('EEEE', 'id_ID').format(DateTime.now()),
          kelas: _selectedKelas ?? '',
          mapel: _activeSubject,
          jamMulai: jamMulai,
          jamSelesai: jamSelesai,
          jamKe: _selectedJamKe,
          jumlahHadir: countHadir,
          totalSiswa: _currentStudents.length,
          lengkap: true,
        ),
      );

      // Clear draft cache upon saving
      AbsenDraftCache.reset();
      
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
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MainLayout(
              initialIndex: 1, // Index tab Jurnal
              initialData: {
                'className': _selectedKelas ?? '',
                'mapel': _activeSubject,
              },
            ),
          ),
          (route) => false, // Bersihkan semua rute sebelumnya agar tab bawah kembali normal
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        RefreshIndicator(
          color: AppColors.secondaryOrange,
          onRefresh: () async {
            if (_selectedKelas != null) {
              context.read<AbsenBloc>().add(LoadStudentAttendanceEvent(kelas: _selectedKelas!));
              await Future.delayed(const Duration(milliseconds: 500));
            }
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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

              if (widget.prefilledKelas == null)
                // Pilih Kelas Dropdown (hanya tampil jika tidak ada prefilledKelas)
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
                                value: k['id'],
                                child: Row(
                                  children: [
                                    const Icon(Icons.apartment_outlined,
                                        size: 18,
                                        color: AppColors.primaryBlue),
                                    const SizedBox(width: 10),
                                    Text(k['name']!,
                                        style: AppTextStyles.cardTitle
                                            .copyWith(fontSize: 14)),
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _selectedKelas = val;
                            _tandaiSemuaHadir = false;
                            _studentStatusMap.clear();
                            _resetCount++;
                            
                            AbsenDraftCache.selectedKelas = val;
                            AbsenDraftCache.tandaiSemuaHadir = false;
                            AbsenDraftCache.studentStatusMap.clear();
                          });
                          context.read<AbsenBloc>().add(LoadStudentAttendanceEvent(kelas: val));
                        }
                      },
                    ),
                  ),
                )
              else
                // Tampilan statis kelas yang sudah terdeteksi
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.4)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.apartment_outlined,
                              size: 18, color: AppColors.primaryBlue),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _selectedKelas ?? '',
                              style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Dari jadwal',
                              style: AppTextStyles.labelStyle.copyWith(
                                color: AppColors.primaryBlue,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.prefilledSubject != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.book_outlined,
                                size: 18, color: AppColors.secondaryOrange),
                            const SizedBox(width: 10),
                            Text(
                              widget.prefilledSubject!,
                              style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              const SizedBox(height: 20),

              // Tabel Siswa (muncul setelah kelas dipilih)
              if (_selectedKelas != null) ...[
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryOrange.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.access_time_outlined,
                          color: AppColors.secondaryOrange,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jam Pelajaran',
                              style: AppTextStyles.cardSubtitle.copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$_selectedJamPelajaran ($_selectedJamKe)',
                              style: AppTextStyles.cardTitle.copyWith(
                                  fontSize: 14,
                                  color: AppColors.primaryBlue),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                BlocConsumer<AbsenBloc, AbsenState>(
                  listener: (context, state) {
                    if (state is StudentAttendanceLoaded) {
                      setState(() {
                        _currentStudents = state.studentList;
                        for (var student in state.studentList) {
                          if (_userModifiedStudentIds.contains(student.id)) {
                            // Pelanggan sudah merubah status secara manual, pertahankan draft
                            if (_studentStatusMap[student.id] == null) {
                              _studentStatusMap[student.id] = AbsenDraftCache.studentStatusMap[student.id]!;
                            }
                          } else {
                            // Update dengan data sumber/API yang paling segar
                            final cleanStatus = _capitalize(student.status);
                            _studentStatusMap[student.id] = cleanStatus;
                            AbsenDraftCache.studentStatusMap[student.id] = cleanStatus;
                          }
                        }
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is AbsenLoading) {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: CircularProgressIndicator(),
                      ));
                    } else if (state is AbsenError) {
                      return Center(child: Text(state.message));
                    } else if (state is StudentAttendanceLoaded) {
                      final students = state.studentList;
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
                                  '${students.length} Siswa',
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
                      ...students.asMap().entries.map((entry) {
                        final index = entry.key;
                        final student = entry.value;
                        return _StudentRow(
                          key: ValueKey(
                              'input_student_${student.id}_$_resetCount'),
                          index: index + 1,
                          initials: student.initials,
                          name: student.name,
                          nisn: student.nisn,
                          initialStatus: _studentStatusMap[student.id] ?? _capitalize(student.status),
                          onStatusChanged: (newStatus) {
                            setState(() {
                              _studentStatusMap[student.id] = newStatus;
                              AbsenDraftCache.studentStatusMap[student.id] = newStatus;
                              _userModifiedStudentIds.add(student.id);
                              AbsenDraftCache.userModifiedStudentIds.add(student.id);
                              if (_tandaiSemuaHadir &&
                                  newStatus != 'Hadir') {
                                _tandaiSemuaHadir = false;
                                AbsenDraftCache.tandaiSemuaHadir = false;
                              }
                            });
                          },
                        );
                      }).toList(),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
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
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
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
