import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

class CustomNilaiField extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;
  final bool readOnly;

  const CustomNilaiField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.readOnly = false,
  });

  @override
  State<CustomNilaiField> createState() => _CustomNilaiFieldState();
}

class _CustomNilaiFieldState extends State<CustomNilaiField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialValue == 0 ? '00' : widget.initialValue.toString(),
    );
  }

  @override
  void didUpdateWidget(CustomNilaiField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      final text = widget.initialValue == 0
          ? '00'
          : widget.initialValue.toString();
      if (_controller.text != text) _controller.text = text;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: widget.readOnly
            ? AppColors.backgroundLight
            : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.readOnly
              ? AppColors.successGreen.withOpacity(0.4)
              : AppColors.borderLight,
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              readOnly: widget.readOnly,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              textAlign: TextAlign.right,
              textAlignVertical: TextAlignVertical.center,
              onChanged: widget.readOnly
                  ? null
                  : (v) {
                      final parsed = int.tryParse(v) ?? 0;
                      widget.onChanged(parsed.clamp(0, 100));
                    },
              style: AppTextStyles.headerTitle.copyWith(
                fontSize: 48,
                color: widget.readOnly
                    ? AppColors.successGreen
                    : AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: '00',
                hintStyle: const TextStyle(
                  color: AppColors.secondaryOrange,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  '/100',
                  style: AppTextStyles.headerSubtitle.copyWith(
                    fontSize: 22,
                    color: widget.readOnly
                        ? AppColors.successGreen.withOpacity(0.6)
                        : AppColors.disabledGrey,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.readOnly) ...[
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 11,
                      color: AppColors.successGreen.withOpacity(0.7),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      'Sudah dinilai',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.successGreen.withOpacity(0.8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
