import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/jurnal_entity.dart';
import '../bloc/jurnal_bloc.dart';
import '../bloc/jurnal_event.dart';
import '../bloc/jurnal_state.dart';
import '../../data/datasources/jurnal_local_datasource.dart';
import '../../data/repositories/jurnal_repository_impl.dart';
import '../../domain/usecases/get_jurnal_terbaru_usecase.dart';
import '../../domain/usecases/get_rekap_jurnal_usecase.dart';

/// Model helper untuk pilihan bulan di filter
class _BulanOption {
  final String label;
  final int bulan;

  const _BulanOption({required this.label, required this.bulan});

  @override
  bool operator ==(Object other) =>
      other is _BulanOption && other.bulan == bulan;

  @override
  int get hashCode => bulan.hashCode;
}

class RekapJurnalPage extends StatelessWidget {
  const RekapJurnalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final ds = JurnalLocalDatasourceImpl();
        final repo = JurnalRepositoryImpl(localDatasource: ds);
        return JurnalBloc(
          getJurnalTerbaruUsecase: GetJurnalTerbaruUsecase(repo),
          getRekapJurnalUsecase: GetRekapJurnalUsecase(repo),
        )..add(const LoadRekapJurnalEvent());
      },
      child: const _RekapJurnalPageContent(),
    );
  }
}

class _RekapJurnalPageContent extends StatefulWidget {
  const _RekapJurnalPageContent({Key? key}) : super(key: key);

  @override
  State<_RekapJurnalPageContent> createState() =>
      _RekapJurnalPageContentState();
}

class _RekapJurnalPageContentState extends State<_RekapJurnalPageContent> {
  String _selectedFilterKelas = 'Semua Kelas';
  _BulanOption? _selectedFilterBulan;

  static final List<_BulanOption> _bulanOptions = [
    const _BulanOption(label: 'Januari',   bulan: 1),
    const _BulanOption(label: 'Februari',  bulan: 2),
    const _BulanOption(label: 'Maret',     bulan: 3),
    const _BulanOption(label: 'April',     bulan: 4),
    const _BulanOption(label: 'Mei',       bulan: 5),
    const _BulanOption(label: 'Juni',      bulan: 6),
    const _BulanOption(label: 'Juli',      bulan: 7),
    const _BulanOption(label: 'Agustus',   bulan: 8),
    const _BulanOption(label: 'September', bulan: 9),
    const _BulanOption(label: 'Oktober',   bulan: 10),
    const _BulanOption(label: 'November',  bulan: 11),
    const _BulanOption(label: 'Desember',  bulan: 12),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Rekap Jurnal'),
      body: BlocBuilder<JurnalBloc, JurnalState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildFilterSection(context),
                  const SizedBox(height: 24),
                  if (state is JurnalLoading || state is JurnalInitial)
                    const Center(child: CircularProgressIndicator())
                  else if (state is JurnalError)
                    Center(child: Text(state.message))
                  else if (state is RekapJurnalLoaded) ...[
                    if (state.rekapList.isEmpty)
                      _buildEmptyState()
                    else
                      ...state.rekapList
                          .map((jurnal) => _buildRekapCard(jurnal)),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Icon(Icons.inbox_outlined,
              size: 48, color: AppColors.textSecondary.withOpacity(0.5)),
          const SizedBox(height: 12),
          Text(
            'Tidak ada jurnal ditemukan.',
            style: AppTextStyles.cardSubtitle,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris pertama: Filter Kelas + Filter Bulan
          Row(
            children: [
              // Dropdown Kelas
              Expanded(
                child: _buildFilterDropdown<String>(
                  value: _selectedFilterKelas,
                  hint: 'Semua Kelas',
                  icon: Icons.class_outlined,
                  items: [
                    'Semua Kelas',
                    'XII IPA 1',
                    'XII IPA 2',
                    'XI IPA 1',
                    'XI IPA 2',
                    'X IPA 1',
                    'X IPA 2',
                  ],
                  labelBuilder: (v) => v,
                  onChanged: (value) {
                    setState(() {
                      _selectedFilterKelas = value ?? 'Semua Kelas';
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),

              // Dropdown Bulan (GANTI DARI FILTER TANGGAL)
              Expanded(
                flex: 2,
                child: _buildFilterDropdown<_BulanOption?>(
                  value: _selectedFilterBulan,
                  hint: 'Semua Bulan',
                  icon: Icons.calendar_month_outlined,
                  items: [null, ..._bulanOptions],
                  labelBuilder: (v) => v == null ? 'Semua Bulan' : v.label,
                  onChanged: (value) {
                    setState(() {
                      _selectedFilterBulan = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Baris kedua: Tombol Reset + Terapkan
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _selectedFilterKelas = 'Semua Kelas';
                        _selectedFilterBulan = null;
                      });
                      context
                          .read<JurnalBloc>()
                          .add(const LoadRekapJurnalEvent());
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.borderLight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Reset',
                      style: AppTextStyles.cardTitle
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<JurnalBloc>().add(LoadRekapJurnalEvent(
                            filterKelas: _selectedFilterKelas == 'Semua Kelas'
                                ? null
                                : _selectedFilterKelas,
                            filterBulan: _selectedFilterBulan?.bulan,
                          ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Filter diterapkan'),
                          backgroundColor: AppColors.successGreen,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryOrange,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.filter_list,
                            size: 18, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          'Terapkan',
                          style: AppTextStyles.cardTitle
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Chip indikator filter aktif
          if (_selectedFilterBulan != null ||
              _selectedFilterKelas != 'Semua Kelas') ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                if (_selectedFilterKelas != 'Semua Kelas')
                  _buildActiveChip(_selectedFilterKelas, () {
                    setState(() => _selectedFilterKelas = 'Semua Kelas');
                  }),
                if (_selectedFilterBulan != null)
                  _buildActiveChip(_selectedFilterBulan!.label, () {
                    setState(() => _selectedFilterBulan = null);
                  }),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActiveChip(String label, VoidCallback onRemove) {
    return Chip(
      label: Text(label,
          style: AppTextStyles.labelStyle
              .copyWith(color: AppColors.primaryBlue, fontSize: 11)),
      backgroundColor: AppColors.primaryBlue.withOpacity(0.08),
      deleteIcon:
          const Icon(Icons.close, size: 14, color: AppColors.primaryBlue),
      onDeleted: onRemove,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  Widget _buildFilterDropdown<T>({
    required T value,
    required String hint,
    required IconData icon,
    required List<T> items,
    required String Function(T) labelBuilder,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          hint: Row(
            children: [
              Icon(icon, size: 15, color: AppColors.primaryBlue),
              const SizedBox(width: 6),
              Flexible(
                child: Text(hint,
                    style: AppTextStyles.cardSubtitle
                        .copyWith(fontSize: 12),
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColors.secondaryOrange, size: 18),
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                labelBuilder(item),
                style: AppTextStyles.cardTitle.copyWith(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildRekapCard(JurnalEntity jurnal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sisi kiri berwarna
            Container(
              width: 4,
              decoration: const BoxDecoration(
                color: AppColors.secondaryOrange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Baris atas: kelas + waktu
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            jurnal.className,
                            style: AppTextStyles.labelStyle.copyWith(
                              color: AppColors.primaryBlue,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.access_time,
                            size: 12, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            jurnal.time,
                            style: AppTextStyles.cardSubtitle
                                .copyWith(fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Mapel badge (NEW)
                    if (jurnal.mapel.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color:
                              AppColors.secondaryOrange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.menu_book_outlined,
                                size: 12,
                                color: AppColors.secondaryOrange),
                            const SizedBox(width: 4),
                            Text(
                              jurnal.mapel,
                              style: AppTextStyles.labelStyle.copyWith(
                                color: AppColors.secondaryOrange,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Judul
                    Text(
                      jurnal.title,
                      style: AppTextStyles.cardTitle.copyWith(
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Deskripsi
                    Text(
                      jurnal.description,
                      style: AppTextStyles.cardSubtitle.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Tombol Edit
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, jurnal);
                      },
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.edit_outlined,
                                size: 16,
                                color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              'Edit',
                              style: AppTextStyles.labelStyle.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
