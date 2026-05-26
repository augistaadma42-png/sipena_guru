import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/text_styles.dart';
import '../bloc/laporan_tugas_bloc.dart';
import '../bloc/laporan_tugas_event.dart';
import '../bloc/laporan_tugas_state.dart';
import 'custom_dropdown_field.dart';

/// Card filter laporan dengan 3 dropdown: Bulan, Kelas, Mata Pelajaran
class FilterLaporanCard extends StatefulWidget {
  const FilterLaporanCard({super.key});

  @override
  State<FilterLaporanCard> createState() => _FilterLaporanCardState();
}

class _FilterLaporanCardState extends State<FilterLaporanCard> {
  // Pilihan dropdown
  final List<String> _bulanOptions = [
    'Oktober 2023',
    'September 2023',
    'Agustus 2023',
  ];
  final List<String> _kelasOptions = [
    'XII IPA 1',
    'XII IPA 2',
    'XII IPS 1',
  ];
  final List<String> _mapelOptions = [
    'Matematika Wajib',
    'Matematika Peminatan',
    'Fisika',
  ];

  String _selectedBulan = LaporanTugasBloc.defaultBulan;
  String _selectedKelas = LaporanTugasBloc.defaultKelas;
  String _selectedMapel = LaporanTugasBloc.defaultMapel;

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      // Sync dengan state awal bloc (bisa sudah di-set dari dashboard)
      final state = context.read<LaporanTugasBloc>().state;
      if (state is LaporanTugasLoaded) {
        _selectedBulan = state.selectedBulan;
        _selectedKelas = state.selectedKelas;
        _selectedMapel = state.selectedMataPelajaran;
      }
    }
  }

  void _applyFilter() {
    context.read<LaporanTugasBloc>().add(FilterAssignmentEvent(
          bulan: _selectedBulan,
          kelas: _selectedKelas,
          mataPelajaran: _selectedMapel,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LaporanTugasBloc, LaporanTugasState>(
      listener: (context, state) {
        if (state is LaporanTugasLoaded) {
          setState(() {
            _selectedBulan = state.selectedBulan;
            _selectedKelas = state.selectedKelas;
            _selectedMapel = state.selectedMataPelajaran;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filter Laporan', style: AppTextStyles.sectionTitle),
            const SizedBox(height: 14),
            CustomDropdownField(
              label: 'Bulan',
              value: _selectedBulan,
              items: _bulanOptions,
              onChanged: (val) {
                if (val != null) {
                  setState(() => _selectedBulan = val);
                  _applyFilter();
                }
              },
            ),
            const SizedBox(height: 12),
            CustomDropdownField(
              label: 'Kelas',
              value: _selectedKelas,
              items: _kelasOptions,
              onChanged: (val) {
                if (val != null) {
                  setState(() => _selectedKelas = val);
                  _applyFilter();
                }
              },
            ),
            const SizedBox(height: 12),
            CustomDropdownField(
              label: 'Mata Pelajaran',
              value: _selectedMapel,
              items: _mapelOptions,
              onChanged: (val) {
                if (val != null) {
                  setState(() => _selectedMapel = val);
                  _applyFilter();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
