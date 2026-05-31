import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

class CustomFeedbackField extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;
  final bool readOnly;

  const CustomFeedbackField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.readOnly = false,
  });

  @override
  State<CustomFeedbackField> createState() => _CustomFeedbackFieldState();
}

class _CustomFeedbackFieldState extends State<CustomFeedbackField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(CustomFeedbackField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue &&
        _controller.text != widget.initialValue) {
      _controller.text = widget.initialValue;
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
      decoration: BoxDecoration(
        color: widget.readOnly
            ? AppColors.backgroundLight
            : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.readOnly
              ? AppColors.borderLight.withOpacity(0.5)
              : AppColors.borderLight,
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: _controller,
        maxLines: 5,
        minLines: 4,
        onChanged: widget.readOnly ? null : widget.onChanged,
        readOnly: widget.readOnly,
        style: AppTextStyles.tableBody.copyWith(
          color: widget.readOnly
              ? AppColors.textSecondary
              : AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: widget.readOnly
              ? 'Tidak ada feedback'
              : 'Tulis catatan untuk siswa...',
          hintStyle: AppTextStyles.cardSubtitle.copyWith(fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}