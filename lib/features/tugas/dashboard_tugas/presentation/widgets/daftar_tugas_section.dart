import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';
import '../../domain/entities/tugas_entity.dart';
import 'tugas_card.dart';

class DaftarTugasSection extends StatelessWidget {
  final List<TugasEntity> tugasList;
  final List<String>? monthOptions;
  final String? selectedMonth;
  final void Function(String?)? onMonthSelected;

  const DaftarTugasSection({
    super.key,
    required this.tugasList,
    this.monthOptions,
    this.selectedMonth,
    this.onMonthSelected,
  });

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            'Daftar Tugas',
            style: AppTextStyles.sectionTitle.copyWith(fontSize: 20),
          ),
          if (monthOptions != null && monthOptions!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
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
                  value: selectedMonth ?? 'Semua',
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.primaryBlue,
                    size: 20,
                  ),
                  onChanged: (value) => onMonthSelected?.call(value),
                  style: AppTextStyles.labelStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  selectedItemBuilder: (context) => [
                    _buildSelectedItem('Semua bulan'),
                    ...monthOptions!.map((month) => _buildSelectedItem(month)),
                  ],
                  items: [
                    DropdownMenuItem(
                      value: 'Semua',
                      child: _buildDropdownItem(
                        'Semua bulan',
                        Icons.calendar_month_outlined,
                        isSelected: (selectedMonth ?? 'Semua') == 'Semua',
                      ),
                    ),
                    ...monthOptions!.map(
                      (month) => DropdownMenuItem(
                        value: month,
                        child: _buildDropdownItem(
                          month,
                          Icons.event_note_outlined,
                          isSelected: selectedMonth == month,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          if (tugasList.isEmpty)
            Container(
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
                    Icons.assignment_outlined,
                    size: 48,
                    color: AppColors.disabledGrey,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    selectedMonth != null && selectedMonth != 'Semua'
                        ? 'Tidak ada tugas di bulan $selectedMonth'
                        : 'Belum ada tugas yang tersedia',
                    style: AppTextStyles.labelStyle.copyWith(
                      color: AppColors.disabledGrey,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tugasList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TugasCard(tugas: tugasList[index]),
                );
              },
            ),
          const SizedBox(height: 80), // Space for FAB
        ],
      ),
    );
  }
}
