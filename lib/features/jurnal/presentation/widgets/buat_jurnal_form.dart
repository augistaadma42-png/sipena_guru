import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class BuatJurnalForm extends StatefulWidget {
  final Map<String, String>? initialData;
  final VoidCallback? onCancelEdit;

  const BuatJurnalForm({Key? key, this.initialData, this.onCancelEdit})
    : super(key: key);

  @override
  State<BuatJurnalForm> createState() => _BuatJurnalFormState();
}

class _BuatJurnalFormState extends State<BuatJurnalForm> {
  final quill.QuillController _quillController = quill.QuillController.basic();
  final TextEditingController _materiController = TextEditingController();
  String? _selectedKelas;
  String? _subject;
  String? _jam;

  String _getDescription() {
    return _quillController.document.toPlainText().trim();
  }

  @override
  void initState() {
   super.initState();
    _initData();
  }

  @override
  void didUpdateWidget(covariant BuatJurnalForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialData != oldWidget.initialData) {
      _initData();
    }
  }

  void _initData() {
    if (widget.initialData != null) {

      _selectedKelas =
          widget.initialData!['className'];

      _subject =
          widget.initialData!['subject'];

      _jam =
          widget.initialData!['time'];

      _materiController.text =
          widget.initialData!['title'] ?? '';

      final description =
          widget.initialData!['description'] ?? '';

      final cleanDesc =
          description.replaceAll('"', '');

      _quillController.document =
          quill.Document()
            ..insert(0, '$cleanDesc\n');

    } else {

      _clearForm();
    }
  }

  void _clearForm() {
  setState(() {
    _selectedKelas = null;
    _subject = null;
    _jam = null;
  });

  _materiController.clear();

  _quillController.document =
      quill.Document()..insert(0, '\n');
}

  @override
  void dispose() {
    _quillController.dispose();
    _materiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate =
        '${now.day.toString().padLeft(2, '0')} / ${now.month.toString().padLeft(2, '0')} / ${now.year}';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.initialData != null ? 'Edit Jurnal' : 'Buat Jurnal Baru',
            style: AppTextStyles.sectionTitle.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            widget.initialData != null
                ? 'Ubah detail kegiatan jurnal yang telah dibuat.'
                : 'Catat kegiatan belajar mengajar hari ini.',
            style: AppTextStyles.cardSubtitle,
          ),
          const SizedBox(height: 20),
          _buildLabel('Tanggal'),
          const SizedBox(height: 8),
          _buildTextField(initialValue: formattedDate, isReadOnly: true),
          const SizedBox(height: 16),
          _buildLabel('Kelas'),
          const SizedBox(height: 8),
          _buildDropdown(),
          if (_subject != null || _jam != null) ...[
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  if (_subject != null)
                    Row(
                      children: [
                        const Icon(
                          Icons.menu_book_outlined,
                          size: 18,
                          color: AppColors.primaryBlue,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _subject!,
                            style: AppTextStyles.cardTitle.copyWith(
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                      ],
                    ),

                  if (_subject != null &&
                      _jam != null)
                    const SizedBox(height: 10),

                  if (_jam != null)
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 18,
                          color: AppColors.primaryBlue,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _jam!,
                          style: AppTextStyles.cardSubtitle.copyWith(
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
          const SizedBox(height: 16),
          _buildLabel('Materi Yang Diajarkan'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _materiController,
            hintText: 'Contoh : Bab 6 Cerpen',
          ),
          const SizedBox(height: 16),
          _buildLabel('Catatan Guru'),
          const SizedBox(height: 8),
          _buildRichTextEditor(),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    if (widget.onCancelEdit != null &&
                        widget.initialData != null) {
                      widget.onCancelEdit!();
                    } else {
                      _clearForm();
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: AppColors.primaryBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    widget.initialData != null ? 'Batalkan Edit' : 'Batalkan',
                    style: AppTextStyles.cardTitle.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final isEdit = widget.initialData != null;
                    final result = {
                      'className': _selectedKelas ?? '',
                      'title': _materiController.text,
                      'description': _getDescription(),
                      'date': DateTime.now().toString(),
                    };

                    // kirim data balik
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          widget.initialData != null
                              ? 'Jurnal berhasil diperbarui'
                              : 'Jurnal berhasil disimpan',
                        ),
                        backgroundColor:
                            AppColors.successGreen,
                        behavior:
                            SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                      ),
                    );

                    _clearForm();

                    if (widget.onCancelEdit != null &&
                        widget.initialData != null) {
                      widget.onCancelEdit!();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: AppColors.secondaryOrange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.save_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.initialData != null
                            ? 'Simpan Perubahan'
                            : 'Simpan Jurnal',
                        style: AppTextStyles.cardTitle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: AppTextStyles.cardTitle.copyWith(fontSize: 12));
  }

  Widget _buildTextField({
    TextEditingController? controller,
    String? hintText,
    String? initialValue,
    bool isReadOnly = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        readOnly: isReadOnly,
        style: AppTextStyles.cardTitle.copyWith(
          color: isReadOnly ? AppColors.textSecondary : AppColors.primaryBlue,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.cardSubtitle,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: _selectedKelas,
          hint: Text('Pilih Kelas', style: AppTextStyles.cardSubtitle),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.secondaryOrange,
          ),
          items:
              [
                'XI-RPL 1',
                'XI-PSPT 2',
                'XI-MP 4',
                'X-RPL 1',
                'X-TKJ 2',
                'Apel Pagi',
                'XI-MP 4',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: AppTextStyles.cardTitle),
                );
              }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedKelas = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildRichTextEditor() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.backgroundLight,
              border: Border(bottom: BorderSide(color: AppColors.borderLight)),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: quill.QuillSimpleToolbar(
              controller: _quillController,
              config: const quill.QuillSimpleToolbarConfig(
                multiRowsDisplay:
                    false, // Membuatnya bisa di-scroll ke samping di HP
                showFontFamily: false,
                showFontSize: false,
                showColorButton: false,
                showBackgroundColorButton: false,
                showClearFormat: false,
                showAlignmentButtons: true,
                showDirection: false,
                showDividers: false,
                showInlineCode: false,
                showQuote: false,
                showCodeBlock: false,
                showIndent: false,
                showSearchButton: false,
                showSubscript: false,
                showSuperscript: false,
                showStrikeThrough: false,
                showLink: false,
                showUndo: false,
                showRedo: false,
              ),
            ),
          ),
          Container(
            height: 120,
            padding: const EdgeInsets.all(12),
            child: quill.QuillEditor.basic(
              controller: _quillController,
              config: const quill.QuillEditorConfig(padding: EdgeInsets.zero),
            ),
          ),
        ],
      ),
    );
  }
}
