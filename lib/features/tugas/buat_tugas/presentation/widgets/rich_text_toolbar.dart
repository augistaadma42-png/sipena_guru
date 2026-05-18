import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';

class RichTextToolbar extends StatelessWidget {
  const RichTextToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    const icons = [
      Icons.format_bold,
      Icons.format_italic,
      Icons.format_underline,
      Icons.format_list_bulleted,
      Icons.link,
      Icons.format_clear,
    ];

    return Row(
      children: icons.map((icon) {
        return IconButton(
          onPressed: () {},
          icon: Icon(icon, size: 18, color: AppColors.textSecondary),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          constraints: const BoxConstraints(),
          splashRadius: 16,
          tooltip: icon.toString(),
        );
      }).toList(),
    );
  }
}
