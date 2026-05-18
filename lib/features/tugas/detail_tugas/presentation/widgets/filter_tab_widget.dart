import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';
import '../bloc/rekap_pengumpulan_bloc.dart';
import '../bloc/rekap_pengumpulan_event.dart';
import '../bloc/rekap_pengumpulan_state.dart';

/// Tab filter: Diserahkan / Ditugaskan
class FilterTabWidget extends StatelessWidget {
  final int submittedCount;
  final int pendingCount;

  const FilterTabWidget({
    super.key,
    required this.submittedCount,
    required this.pendingCount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RekapPengumpulanBloc, RekapPengumpulanState>(
      builder: (context, state) {
        final isSubmittedActive =
            state is RekapPengumpulanLoaded ? state.showSubmitted : true;

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              children: [
                _TabItem(
                  label: 'Diserahkan',
                  count: submittedCount,
                  isActive: isSubmittedActive,
                  onTap: () => context
                      .read<RekapPengumpulanBloc>()
                      .add(const FilterSubmissionEvent(true)),
                ),
                _TabItem(
                  label: 'Ditugaskan',
                  count: pendingCount,
                  isActive: !isSubmittedActive,
                  onTap: () => context
                      .read<RekapPengumpulanBloc>()
                      .add(const FilterSubmissionEvent(false)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final int count;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.count,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppTextStyles.labelStyle.copyWith(
                  fontWeight:
                      isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive
                      ? AppColors.primaryBlue
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.primaryBlue
                      : AppColors.disabledGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
