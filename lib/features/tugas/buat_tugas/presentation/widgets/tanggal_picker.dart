import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/constants/colors.dart';

class TanggalPicker extends StatelessWidget {
  final ValueNotifier<DateTime?> tenggatNotifier;
  final bool enabled;
  final bool hasError;
  final String? errorText;

  const TanggalPicker({
    super.key,
    required this.tenggatNotifier,
    this.enabled = true,
    this.hasError = false,
    this.errorText,
  });

  Future<void> _pickDateTime(BuildContext context) async {
    // Pick date first
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: tenggatNotifier.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: const Locale('id', 'ID'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryBlue,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) return;

    // Then pick time
    if (!context.mounted) return;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: tenggatNotifier.value != null
          ? TimeOfDay.fromDateTime(tenggatNotifier.value!)
          : const TimeOfDay(hour: 23, minute: 59),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryBlue,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime == null) return;

    tenggatNotifier.value = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }

  String _disabledLabel() {
    return 'Deadline tidak tersedia untuk Materi';
  }

  String _formatDateTime(DateTime dt) {
    final tgl =
        '${dt.day.toString().padLeft(2, '0')}/'
        '${dt.month.toString().padLeft(2, '0')}/'
        '${dt.year}';
    final jam =
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
    return '$tgl  $jam';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.white : AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasError
              ? Colors.red.shade400
              : enabled
                  ? AppColors.borderLight
                  : AppColors.disabledGrey,
          width: hasError ? 1.5 : 1.0,
        ),
        boxShadow: enabled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tenggat',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          ValueListenableBuilder<DateTime?>(
            valueListenable: tenggatNotifier,
            builder: (_, value, __) {
              final label = value == null
                  ? 'Tak ada batas waktu'
                  : _formatDateTime(value);
              return InkWell(
                onTap: enabled ? () => _pickDateTime(context) : null,
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        enabled ? label : _disabledLabel(),
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: enabled
                              ? (value == null
                                    ? AppColors.disabledGrey
                                    : AppColors.textPrimary)
                              : AppColors.disabledGrey,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 18,
                      color: enabled
                          ? AppColors.textSecondary
                          : AppColors.disabledGrey,
                    ),
                  ],
                ),
              );
            },
          ),
          if (hasError && errorText != null) ...[
            const SizedBox(height: 8),
            Text(
              errorText!,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.red.shade400,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
