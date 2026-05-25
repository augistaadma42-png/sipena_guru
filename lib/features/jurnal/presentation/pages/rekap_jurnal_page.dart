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
  State<_RekapJurnalPageContent> createState() => _RekapJurnalPageContentState();
}

class _RekapJurnalPageContentState extends State<_RekapJurnalPageContent> {
  String _selectedFilterKelas = 'Semua Kelas';
  DateTime? _selectedFilterTanggal;

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
                      const Center(child: Text('Tidak ada jurnal yang ditemukan.'))
                    else
                      ...state.rekapList.map((jurnal) => _buildRekapCard(jurnal)),
                  ]
                ],
              ),
            ),
          );
        },
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
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedFilterKelas,
                      hint: Text('Kelas', style: AppTextStyles.cardTitle.copyWith(color: AppColors.primaryBlue)),
                      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.secondaryOrange, size: 20),
                      items: ['Semua Kelas', 'XII IPA 1', 'XII IPA 2', 'XI IPA 1'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: AppTextStyles.cardTitle.copyWith(fontSize: 12)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedFilterKelas = value ?? 'Semua Kelas';
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedFilterTanggal ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedFilterTanggal = pickedDate;
                      });
                    }
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, color: AppColors.primaryBlue, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              _selectedFilterTanggal != null 
                                  ? '${_selectedFilterTanggal!.day.toString().padLeft(2, '0')}/${_selectedFilterTanggal!.month.toString().padLeft(2, '0')}/${_selectedFilterTanggal!.year}'
                                  : 'Pilih Tanggal', 
                              style: AppTextStyles.cardSubtitle
                            ),
                          ],
                        ),
                        const Icon(Icons.keyboard_arrow_down, color: AppColors.secondaryOrange, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _selectedFilterKelas = 'Semua Kelas';
                        _selectedFilterTanggal = null;
                      });
                      context.read<JurnalBloc>().add(const LoadRekapJurnalEvent());
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.borderLight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Reset',
                      style: AppTextStyles.cardTitle.copyWith(color: AppColors.textSecondary),
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
                        filterKelas: _selectedFilterKelas == 'Semua Kelas' ? null : _selectedFilterKelas,
                        filterTanggal: _selectedFilterTanggal,
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Filter diterapkan'),
                          backgroundColor: AppColors.successGreen,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                        const Icon(Icons.filter_list, size: 18, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          'Terapkan',
                          style: AppTextStyles.cardTitle.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
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
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                        const Icon(Icons.access_time, size: 12, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          jurnal.time,
                          style: AppTextStyles.cardSubtitle.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      jurnal.title,
                      style: AppTextStyles.cardTitle.copyWith(
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      jurnal.description,
                      style: AppTextStyles.cardSubtitle.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
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
                                const Icon(Icons.edit_outlined, size: 16, color: AppColors.textSecondary),
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
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Hapus Rekap Jurnal', style: AppTextStyles.sectionTitle),
                                content: Text(
                                  'Apakah Anda yakin ingin menghapus jurnal "${jurnal.title}"? Tindakan ini tidak dapat dibatalkan.',
                                  style: AppTextStyles.cardSubtitle,
                                ),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Batal', style: AppTextStyles.cardTitle.copyWith(color: AppColors.textSecondary)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Tutup dialog
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text('Rekap Jurnal berhasil dihapus (Simulasi Front-End)'),
                                          backgroundColor: AppColors.primaryBlue,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red.withOpacity(0.9),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                    child: const Text('Hapus', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(4),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                          ),
                        ),
                      ],
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
