import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';
import '../../domain/entities/materi_entity.dart';
import '../../domain/entities/tugas_entity.dart';
import '../widgets/materi_card.dart';
import '../../../buat_tugas/presentation/pages/buat_tugas_page.dart';

class DaftarMateriPage extends StatefulWidget {
  final List<MateriEntity> materiList;
  final String? initialMateriId;

  const DaftarMateriPage({
    super.key,
    required this.materiList,
    this.initialMateriId,
  });

  @override
  State<DaftarMateriPage> createState() => _DaftarMateriPageState();
}

class _DaftarMateriPageState extends State<DaftarMateriPage> {
  bool _hasOpenedInitialDialog = false;
  String? _selectedMonth;

  static const List<String> _allMonths = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasOpenedInitialDialog && widget.initialMateriId != null) {
        final index = widget.materiList.indexWhere(
          (item) => item.id == widget.initialMateriId,
        );
        if (index >= 0) {
          _showMateriDetail(context, widget.materiList[index]);
          _hasOpenedInitialDialog = true;
        }
      }
    });
  }

  void _openEdit(BuildContext context, MateriEntity materi) {
    final tugasToEdit = TugasEntity(
      id: materi.id,
      kelas: materi.kelas,
      title: materi.title,
      subtitle: materi.deskripsi,
      deadline: '',
      totalAnggota: 0,
      submittedCount: 0,
      createdAt: materi.tanggal,
      sisaHari: '',
      isUrgent: false,
      jenisNilai: 'Materi',
      mapel: materi.category,
      siswa: 'Semua pelajar',
      lampiranCount: materi.lampiranCount,
      judulMateri: materi.title,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BuatTugasPage(tugasToEdit: tugasToEdit),
      ),
    );
  }

  List<String> _buildMonthOptions() {
    return _allMonths;
  }

  String _extractMonthFromDate(String dateText) {
    final trimmed = dateText.trim();
    if (trimmed.isEmpty) return '';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length < 2) return parts.last;
    if (RegExp(r'^\d{4}$').hasMatch(parts.last)) {
      return parts[parts.length - 2];
    }
    return parts.last;
  }

  void _showMateriDetail(BuildContext context, MateriEntity materi) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul
              Text(
                materi.title,
                style: AppTextStyles.sectionTitle.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 4),
              Text(
                materi.category,
                style: AppTextStyles.labelStyle.copyWith(
                  color: AppColors.secondaryOrange,
                ),
              ),
              const SizedBox(height: 16),

              // Info singkat
              _buildInfoRow(
                'Kelas',
                materi.kelas.isNotEmpty ? materi.kelas : '-',
              ),
              const SizedBox(height: 12),
              _buildInfoRow('Tanggal', materi.tanggal),
              const SizedBox(height: 16),

              // Deskripsi
              if (materi.deskripsi.isNotEmpty) ...[
                Text(
                  'Deskripsi',
                  style: AppTextStyles.labelStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    materi.deskripsi,
                    style: AppTextStyles.cardSubtitle.copyWith(
                      height: 1.5,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Lampiran
              if (materi.lampiranCount > 0 &&
                  materi.lampiranNames.isNotEmpty) ...[
                Text(
                  'Lampiran',
                  style: AppTextStyles.labelStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: materi.lampiranNames
                        .map(
                          (name) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attach_file_rounded,
                                  size: 14,
                                  color: AppColors.primaryBlue,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    name,
                                    style: AppTextStyles.cardSubtitle.copyWith(
                                      color: AppColors.textPrimary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Preview "$name"'),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.primaryBlue,
                                    minimumSize: const Size(0, 32),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 0,
                                    ),
                                  ),
                                  child: const Text('Preview'),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Tombol Edit
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _openEdit(context, materi);
                  },
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Edit Materi'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.labelStyle),
        Text(
          value,
          style: AppTextStyles.cardSubtitle.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedItem(String label) {
    return Row(
      children: [
        const Icon(Icons.calendar_today_rounded, size: 14, color: AppColors.primaryBlue),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppTextStyles.labelStyle.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownItem(String label, IconData icon, {bool isSelected = false}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: isSelected ? AppColors.primaryBlue : AppColors.textSecondary),
        const SizedBox(width: 10),
        Text(
          label,
          style: AppTextStyles.labelStyle.copyWith(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? AppColors.primaryBlue : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Semua Materi'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primaryBlue,
        elevation: 0,
      ),
      body: Builder(
        builder: (context) {
          final allMonths = widget.materiList
              .map((m) => _extractMonthFromDate(m.tanggal))
              .where((month) => month.isNotEmpty)
              .toList();
          final filterOptions = _buildMonthOptions();
          final filteredMateri =
              (_selectedMonth == null || _selectedMonth == 'Semua')
              ? widget.materiList
              : widget.materiList
                    .where(
                      (m) => _extractMonthFromDate(m.tanggal) == _selectedMonth,
                    )
                    .toList();

          if (widget.materiList.isEmpty) {
            return Center(
              child: Text(
                'Belum ada materi yang tersedia.',
                style: AppTextStyles.cardSubtitle.copyWith(
                  color: AppColors.disabledGrey,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount:
                (filterOptions.isNotEmpty ? 1 : 0) +
                (filteredMateri.isEmpty ? 1 : filteredMateri.length),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              if (filterOptions.isNotEmpty && index == 0) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderLight),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedMonth ?? 'Semua',
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.primaryBlue,
                        size: 20,
                      ),
                      style: AppTextStyles.labelStyle.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      selectedItemBuilder: (context) => [
                        _buildSelectedItem('Semua bulan'),
                        ...filterOptions.map((m) => _buildSelectedItem(m)),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedMonth = value == 'Semua' ? null : value;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'Semua',
                          child: _buildDropdownItem(
                            'Semua bulan',
                            Icons.calendar_month_outlined,
                            isSelected: (_selectedMonth ?? 'Semua') == 'Semua',
                          ),
                        ),
                        ...filterOptions.map(
                          (month) => DropdownMenuItem(
                            value: month,
                            child: _buildDropdownItem(
                              month,
                              Icons.event_note_outlined,
                              isSelected: _selectedMonth == month,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final itemIndex = index - (filterOptions.isNotEmpty ? 1 : 0);

              if (filteredMateri.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.menu_book_outlined,
                        size: 48,
                        color: AppColors.disabledGrey,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _selectedMonth != null && _selectedMonth != 'Semua'
                            ? 'Tidak ada materi di bulan $_selectedMonth'
                            : 'Belum ada materi yang tersedia',
                        style: AppTextStyles.cardSubtitle.copyWith(
                          color: AppColors.disabledGrey,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              final materi = filteredMateri[itemIndex];
              return MateriCard(
                materi: materi,
                width: double.infinity,
                onTap: () => _showMateriDetail(context, materi),
              );
            },
          );
        },
      ),
    );
  }
}
