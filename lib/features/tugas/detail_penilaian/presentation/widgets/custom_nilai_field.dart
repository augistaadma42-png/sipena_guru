import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

class CustomNilaiField extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;
  const CustomNilaiField({super.key, required this.initialValue,
      required this.onChanged});

  @override
  State<CustomNilaiField> createState() => _CustomNilaiFieldState();
}

class _CustomNilaiFieldState extends State<CustomNilaiField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialValue == 0 ? '00' : widget.initialValue.toString());
  }

  @override
  void didUpdateWidget(CustomNilaiField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      final text = widget.initialValue == 0 ? '00'
          : widget.initialValue.toString();
      if (_controller.text != text) _controller.text = text;
    }
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight, width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              onChanged: (v) {
                final parsed = int.tryParse(v) ?? 0;
                widget.onChanged(parsed.clamp(0, 100));
              },
              style: AppTextStyles.headerTitle.copyWith(fontSize: 48),
              decoration: const InputDecoration(
                border: InputBorder.none, isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: '00',
                hintStyle: TextStyle(color: AppColors.secondaryOrange,
                  fontSize: 40, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Text('/100',
            style: AppTextStyles.headerSubtitle.copyWith(
              fontSize: 22, color: AppColors.disabledGrey,
              fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}