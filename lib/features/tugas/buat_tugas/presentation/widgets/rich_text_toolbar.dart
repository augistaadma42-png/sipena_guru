import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';

class RichTextToolbar extends StatelessWidget {
  final TextEditingController controller;
  final ValueNotifier<Set<String>> activeFormats;

  const RichTextToolbar({
    super.key,
    required this.controller,
    required this.activeFormats,
  });

  void _toggleFormat(String openTag, String closeTag) {
    final text = controller.text;
    final selection = controller.selection;

    if (!selection.isValid) return;

    final selectedText = selection.textInside(text);
    final before = selection.textBefore(text);
    final after = selection.textAfter(text);

    // Cek apakah teks yang dipilih sudah dibungkus dengan format ini
    final alreadyWrapped = selectedText.startsWith(openTag) &&
        selectedText.endsWith(closeTag) &&
        selectedText.length > openTag.length + closeTag.length;

    String newText;
    int newStart;
    int newEnd;

    if (alreadyWrapped) {
      // Hapus format
      final inner = selectedText.substring(
          openTag.length, selectedText.length - closeTag.length);
      newText = before + inner + after;
      newStart = before.length;
      newEnd = before.length + inner.length;
    } else if (selectedText.isNotEmpty) {
      // Bungkus teks terpilih
      newText = before + openTag + selectedText + closeTag + after;
      newStart = before.length + openTag.length;
      newEnd = newStart + selectedText.length;
    } else {
      // Tidak ada teks terpilih — sisipkan placeholder
      const placeholder = 'teks';
      newText = before + openTag + placeholder + closeTag + after;
      newStart = before.length + openTag.length;
      newEnd = newStart + placeholder.length;
    }

    controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection(baseOffset: newStart, extentOffset: newEnd),
    );
  }

  void _insertList() {
    final text = controller.text;
    final selection = controller.selection;
    if (!selection.isValid) return;

    final before = selection.textBefore(text);
    final after = selection.textAfter(text);
    final selectedText = selection.textInside(text);

    String inserted;
    if (selectedText.isNotEmpty) {
      // Ubah setiap baris jadi bullet
      inserted = selectedText
          .split('\n')
          .map((line) => line.startsWith('• ') ? line : '• $line')
          .join('\n');
    } else {
      inserted = '• ';
    }

    final newText = before + inserted + after;
    final newOffset = before.length + inserted.length;

    controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }

  void _insertLink() {
    final text = controller.text;
    final selection = controller.selection;
    if (!selection.isValid) return;

    final before = selection.textBefore(text);
    final after = selection.textAfter(text);
    final selectedText = selection.textInside(text);

    final label = selectedText.isNotEmpty ? selectedText : 'teks tautan';
    const linkTemplate = '[{label}](https://)';
    final inserted = '[${label}](https://)';

    final newText = before + inserted + after;
    // Posisikan kursor di dalam URL
    final urlStart = before.length + label.length + 3; // setelah "]("
    final urlEnd = urlStart + 8; // panjang "https://"

    controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection(baseOffset: urlStart, extentOffset: urlEnd),
    );
  }

  void _clearFormat() {
    final text = controller.text;
    final selection = controller.selection;
    if (!selection.isValid) return;

    final before = selection.textBefore(text);
    final after = selection.textAfter(text);
    final selectedText = selection.textInside(text);

    if (selectedText.isEmpty) return;

    // Hapus semua format markdown dari teks terpilih
    final cleaned = selectedText
        .replaceAll(RegExp(r'\*\*(.*?)\*\*'), r'$1')
        .replaceAll(RegExp(r'\*(.*?)\*'), r'$1')
        .replaceAll(RegExp(r'_(.*?)_'), r'$1')
        .replaceAll(RegExp(r'~~(.*?)~~'), r'$1')
        .replaceAll(RegExp(r'`(.*?)`'), r'$1')
        .replaceAll(RegExp(r'• '), '');

    final newText = before + cleaned + after;
    controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection(
        baseOffset: before.length,
        extentOffset: before.length + cleaned.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<String>>(
      valueListenable: activeFormats,
      builder: (context, active, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _ToolbarButton(
              icon: Icons.format_bold,
              tooltip: 'Bold',
              isActive: active.contains('bold'),
              onPressed: () => _toggleFormat('**', '**'),
            ),
            _ToolbarButton(
              icon: Icons.format_italic,
              tooltip: 'Italic',
              isActive: active.contains('italic'),
              onPressed: () => _toggleFormat('*', '*'),
            ),
            _ToolbarButton(
              icon: Icons.format_underline,
              tooltip: 'Underline',
              isActive: active.contains('underline'),
              onPressed: () => _toggleFormat('_', '_'),
            ),
            _ToolbarButton(
              icon: Icons.format_strikethrough,
              tooltip: 'Strikethrough',
              isActive: active.contains('strikethrough'),
              onPressed: () => _toggleFormat('~~', '~~'),
            ),
            Container(height: 20, width: 1, color: AppColors.borderLight),
            _ToolbarButton(
              icon: Icons.format_list_bulleted,
              tooltip: 'Daftar bullet',
              isActive: false,
              onPressed: _insertList,
            ),
            _ToolbarButton(
              icon: Icons.link,
              tooltip: 'Sisipkan tautan',
              isActive: false,
              onPressed: _insertLink,
            ),
            Container(height: 20, width: 1, color: AppColors.borderLight),
            _ToolbarButton(
              icon: Icons.format_clear,
              tooltip: 'Hapus format',
              isActive: false,
              onPressed: _clearFormat,
            ),
          ],
        );
      },
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final bool isActive;
  final VoidCallback onPressed;

  const _ToolbarButton({
    required this.icon,
    required this.tooltip,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primaryBlue.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 18,
            color: isActive ? AppColors.primaryBlue : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
