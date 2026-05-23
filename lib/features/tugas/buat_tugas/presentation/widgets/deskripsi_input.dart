import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/constants/colors.dart';
import 'rich_text_toolbar.dart';

class DeskripsiInput extends StatefulWidget {
  final TextEditingController controller;

  const DeskripsiInput({super.key, required this.controller});

  @override
  State<DeskripsiInput> createState() => _DeskripsiInputState();
}

class _DeskripsiInputState extends State<DeskripsiInput> {
  final ValueNotifier<Set<String>> _activeFormats = ValueNotifier({});
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateActiveFormats);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateActiveFormats);
    _activeFormats.dispose();
    super.dispose();
  }

  /// Deteksi format aktif berdasarkan posisi kursor saat ini
  void _updateActiveFormats() {
    final text = widget.controller.text;
    final selection = widget.controller.selection;
    if (!selection.isValid || text.isEmpty) {
      _activeFormats.value = {};
      return;
    }

    final cursor = selection.baseOffset;
    final active = <String>{};

    // Cek apakah kursor berada di dalam ** ... **
    if (_isCursorInsideTag(text, cursor, '**')) active.add('bold');
    if (_isCursorInsideTag(text, cursor, '*')) active.add('italic');
    if (_isCursorInsideTag(text, cursor, '_')) active.add('underline');
    if (_isCursorInsideTag(text, cursor, '~~')) active.add('strikethrough');

    _activeFormats.value = active;
  }

  bool _isCursorInsideTag(String text, int cursor, String tag) {
    int searchPos = 0;
    while (searchPos < text.length) {
      final openIdx = text.indexOf(tag, searchPos);
      if (openIdx == -1) break;
      final closeIdx = text.indexOf(tag, openIdx + tag.length);
      if (closeIdx == -1) break;

      if (cursor > openIdx && cursor <= closeIdx + tag.length) return true;
      searchPos = closeIdx + tag.length;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isFocused ? AppColors.primaryBlue : AppColors.borderLight,
          width: _isFocused ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: _isFocused
                ? AppColors.primaryBlue.withOpacity(0.08)
                : Colors.black.withOpacity(0.04),
            blurRadius: _isFocused ? 8 : 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Toolbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
              border: Border(
                bottom: BorderSide(color: AppColors.borderLight),
              ),
            ),
            child: RichTextToolbar(
              controller: widget.controller,
              activeFormats: _activeFormats,
            ),
          ),

          // Text field 
          Focus(
            onFocusChange: (focused) => setState(() => _isFocused = focused),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: widget.controller,
                maxLines: 8,
                minLines: 5,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                  height: 1.6,
                ),
                decoration: InputDecoration(
                  hintText: 'Petunjuk \n\nGunakan toolbar di atas untuk memformat teks: bold, italic, underline, strikethrough',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.disabledGrey,
                    height: 1.6,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),

          // Preview bar 
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: widget.controller,
            builder: (context, value, _) {
              if (value.text.trim().isEmpty) return const SizedBox.shrink();
              return _MarkdownPreviewBar(rawText: value.text);
            },
          ),
        ],
      ),
    );
  }
}

// Inline markdown preview (read-only) 

class _MarkdownPreviewBar extends StatelessWidget {
  final String rawText;
  const _MarkdownPreviewBar({required this.rawText});

  /// Ubah markdown sederhana → InlineSpan list
  List<InlineSpan> _parse(String text) {
    final spans = <InlineSpan>[];
    // Pattern: bold(**), italic(*), underline(_), strikethrough(~~), link([text](url))
    final pattern = RegExp(
      r'\*\*(.+?)\*\*|~~(.+?)~~|\*(.+?)\*|_(.+?)_|\[(.+?)\]\((.+?)\)',
      dotAll: true,
    );

    int last = 0;
    for (final match in pattern.allMatches(text)) {
      if (match.start > last) {
        spans.add(TextSpan(text: text.substring(last, match.start)));
      }

      if (match.group(1) != null) {
        // Bold
        spans.add(TextSpan(
          text: match.group(1),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
      } else if (match.group(2) != null) {
        // Strikethrough
        spans.add(TextSpan(
          text: match.group(2),
          style: const TextStyle(decoration: TextDecoration.lineThrough),
        ));
      } else if (match.group(3) != null) {
        // Italic
        spans.add(TextSpan(
          text: match.group(3),
          style: const TextStyle(fontStyle: FontStyle.italic),
        ));
      } else if (match.group(4) != null) {
        // Underline
        spans.add(TextSpan(
          text: match.group(4),
          style: const TextStyle(decoration: TextDecoration.underline),
        ));
      } else if (match.group(5) != null) {
        // Link
        spans.add(TextSpan(
          text: match.group(5),
          style: const TextStyle(
            color: AppColors.primaryBlue,
            decoration: TextDecoration.underline,
          ),
        ));
      }

      last = match.end;
    }

    if (last < text.length) {
      spans.add(TextSpan(text: text.substring(last)));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(11)),
        border: Border(top: BorderSide(color: AppColors.borderLight)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pratinjau',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textPrimary,
                height: 1.6,
              ),
              children: _parse(rawText),
            ),
          ),
        ],
      ),
    );
  }
}
