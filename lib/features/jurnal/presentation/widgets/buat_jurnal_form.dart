import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/confirmation_dialog.dart';

class BuatJurnalForm extends StatefulWidget {
  final Map<String, String>? initialData;
  final VoidCallback? onCancelEdit;
  final VoidCallback? onSaveSuccess;
  final bool isEditMode;

  const BuatJurnalForm({
    Key? key,
    this.initialData,
    this.onCancelEdit,
    this.onSaveSuccess,
    this.isEditMode = false,
  }) : super(key: key);

  @override
  State<BuatJurnalForm> createState() => BuatJurnalFormState();
}

class BuatJurnalFormState extends State<BuatJurnalForm> {
  final quill.QuillController _quillController = quill.QuillController.basic();
  final TextEditingController _materiController = TextEditingController();

  String? _selectedKelas;
  String? _selectedMapel;
  DateTime _selectedTanggal = DateTime.now();
  bool _showErrors = false;

  // Daftar kelas yang tersedia
  static const List<String> _kelasList = [
    'XII IPA 1',
    'XII IPA 2',
    'XI IPA 1',
    'XI IPA 2',
    'X IPA 1',
    'X IPA 2',
  ];

  // Daftar mata pelajaran yang tersedia
  static const List<String> _mapelList = [
    'Matematika Wajib',
    'Matematika Peminatan',
  ];

  @override
  void initState() {
    super.initState();
    _initData();
    _materiController.addListener(() {
      if (_showErrors) setState(() {});
    });
    _quillController.changes.listen((_) {
      if (_showErrors) setState(() {});
    });
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
      final data = widget.initialData!;

      _selectedKelas = data['className'];
      _selectedMapel = data['mapel'];

      // Parse tanggal dari string "dd/MM/yyyy"
      final tanggalStr = data['tanggal'];
      if (tanggalStr != null && tanggalStr.isNotEmpty) {
        try {
          final parts = tanggalStr.split('/');
          if (parts.length == 3) {
            _selectedTanggal = DateTime(
              int.parse(parts[2]),
              int.parse(parts[1]),
              int.parse(parts[0]),
            );
          }
        } catch (_) {
          _selectedTanggal = DateTime.now();
        }
      } else {
        _selectedTanggal = DateTime.now();
      }

      _materiController.text = data['title'] ?? '';

      final description = data['description'] ?? '';
      final cleanDesc = description.replaceAll('"', '');
      _quillController.document =
          quill.Document()..insert(0, '$cleanDesc\n');
    } else {
      _clearForm();
    }
  }

  void clearForm() {
    _clearForm();
  }

  void _clearForm() {
    setState(() {
      _selectedKelas = null;
      _selectedMapel = null;
      _selectedTanggal = DateTime.now();
      _showErrors = false;
    });

    _materiController.clear();
    _quillController.document = quill.Document()..insert(0, '\n');
  }

  String _formatTanggal(DateTime dt) {
    const hariMap = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    const bulanMap = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    // weekday: 1=Mon ... 7=Sun
    final hari = hariMap[dt.weekday - 1];
    final bulan = bulanMap[dt.month - 1];
    return '$hari, ${dt.day.toString().padLeft(2, '0')} $bulan ${dt.year}';
  }

  String _tanggalToStorage(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
  }

  Future<void> _pickTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedTanggal,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: const Locale('id', 'ID'),
    );
    if (picked != null) {
      setState(() {
        _selectedTanggal = picked;
      });
    }
  }

  @override
  void dispose() {
    _quillController.dispose();
    _materiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            widget.isEditMode ? 'Edit Jurnal' : 'Buat Jurnal Baru',
            style: AppTextStyles.sectionTitle.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            widget.isEditMode
                ? 'Ubah detail kegiatan jurnal yang telah dibuat.'
                : 'Catat kegiatan belajar mengajar hari ini.',
            style: AppTextStyles.cardSubtitle,
          ),
          const SizedBox(height: 20),

          // Tanggal 
          _buildLabel('Tanggal'),
          const SizedBox(height: 8),
          _buildDatePickerField(),
          const SizedBox(height: 16),

          // Kelas 
          _buildLabel('Kelas'),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdown<String>(
                value: _selectedKelas,
                items: _kelasList,
                hint: 'Pilih Kelas',
                hasError: _showErrors && _selectedKelas == null,
                onChanged: (value) {
                  setState(() {
                    _selectedKelas = value;
                  });
                },
              ),
              if (_showErrors && _selectedKelas == null) ...[
                const SizedBox(height: 6),
                Text(
                  '* Kelas wajib dipilih!',
                  style: AppTextStyles.cardSubtitle.copyWith(
                    fontSize: 11,
                    color: Colors.red.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // Mata Pelajaran 
          _buildLabel('Mata Pelajaran'),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdown<String>(
                value: _selectedMapel,
                items: _mapelList,
                hint: 'Pilih Mapel',
                hasError: _showErrors && _selectedMapel == null,
                onChanged: (value) {
                  setState(() {
                    _selectedMapel = value;
                  });
                },
              ),
              if (_showErrors && _selectedMapel == null) ...[
                const SizedBox(height: 6),
                Text(
                  '* Mapel wajib dipilih!',
                  style: AppTextStyles.cardSubtitle.copyWith(
                    fontSize: 11,
                    color: Colors.red.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // Materi 
          _buildLabel('Materi Yang Diajarkan'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _materiController,
            hintText: 'Contoh : Bab 6 Cerpen',
          ),
          const SizedBox(height: 16),

          // Catatan Guru 
          _buildLabel('Catatan Guru'),
          const SizedBox(height: 8),
          _buildRichTextEditor(),
          const SizedBox(height: 24),

          // Tombol Aksi 
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _handleCancel,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: AppColors.primaryBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'Batalkan',
                    style: AppTextStyles.cardTitle.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _handleSave,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
                        size: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          widget.isEditMode ? 'Simpan Perubahan' : 'Simpan Jurnal',
                          style: AppTextStyles.cardTitle.copyWith(
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
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

  bool get isDirty => _isDirty;

  bool get _isDirty {
    if (widget.isEditMode && widget.initialData != null) {
      final data = widget.initialData!;
      final currentKelas = _selectedKelas;
      final currentMapel = _selectedMapel;
      final currentTanggal = _tanggalToStorage(_selectedTanggal);
      final currentMateri = _materiController.text.trim();
      final currentCatatan = _quillController.document.toPlainText().trim();

      final initialKelas = data['className'];
      final initialMapel = data['mapel'];
      final initialTanggal = data['tanggal'];
      final initialMateri = (data['title'] ?? '').trim();
      final initialCatatan = (data['description'] ?? '').replaceAll('"', '').trim();

      return currentKelas != initialKelas ||
          currentMapel != initialMapel ||
          currentTanggal != initialTanggal ||
          currentMateri != initialMateri ||
          currentCatatan != initialCatatan;
    } else {
      return _selectedKelas != null ||
          _selectedMapel != null ||
          _materiController.text.trim().isNotEmpty ||
          _quillController.document.toPlainText().trim().isNotEmpty;
    }
  }

  Future<void> _handleCancel() async {
    if (_isDirty) {
      final shouldCancel = await showConfirmationDialog(
        context: context,
        title: 'Batalkan Perubahan?',
        message: 'Perubahan yang belum disimpan akan hilang. Apakah Anda yakin ingin kembali?',
        cancelText: 'Tetap di Halaman',
        confirmText: 'Kembali',
        isDestructive: true,
      );
      if (shouldCancel != true) return;
    }
    
    if (widget.onCancelEdit != null && widget.initialData != null) {
      widget.onCancelEdit!();
    } else {
      _clearForm();
    }
  }

  Future<void> _handleSave() async {
    final isKelasValid = _selectedKelas != null;
    final isMapelValid = _selectedMapel != null;
    final isMateriValid = _materiController.text.trim().isNotEmpty;
    final isCatatanValid = _quillController.document.toPlainText().trim().isNotEmpty;

    if (!isKelasValid || !isMapelValid || !isMateriValid || !isCatatanValid) {
      setState(() {
        _showErrors = true;
      });

      final List<String> missingFields = [];
      if (!isKelasValid) missingFields.add('Kelas');
      if (!isMapelValid) missingFields.add('Mata Pelajaran');
      if (!isMateriValid) missingFields.add('Materi');
      if (!isCatatanValid) missingFields.add('Catatan Guru');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan! Field berikut wajib diisi: ${missingFields.join(", ")}'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      return;
    }

    final String title = widget.isEditMode ? 'Simpan Perubahan Jurnal?' : 'Simpan Jurnal?';
    final String message = widget.isEditMode 
        ? 'Perubahan jurnal akan diterapkan pada data yang ada.'
        : 'Jurnal mengajar akan disimpan ke dalam riwayat pembelajaran.';

    final shouldSave = await showConfirmationDialog(
      context: context,
      title: title,
      message: message,
      cancelText: 'Batal',
      confirmText: 'Simpan',
    );
    if (shouldSave == true && mounted) {
      _simpanJurnal();
    }
  }

  void _simpanJurnal() {
    final isKelasValid = _selectedKelas != null;
    final isMapelValid = _selectedMapel != null;
    final isMateriValid = _materiController.text.trim().isNotEmpty;
    final isCatatanValid = _quillController.document.toPlainText().trim().isNotEmpty;

    if (!isKelasValid || !isMapelValid || !isMateriValid || !isCatatanValid) {
      setState(() {
        _showErrors = true;
      });

      final List<String> missingFields = [];
      if (!isKelasValid) missingFields.add('Kelas');
      if (!isMapelValid) missingFields.add('Mata Pelajaran');
      if (!isMateriValid) missingFields.add('Materi');
      if (!isCatatanValid) missingFields.add('Catatan Guru');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan! Field berikut wajib diisi: ${missingFields.join(", ")}'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.isEditMode
              ? 'Jurnal berhasil diperbarui'
              : 'Jurnal berhasil disimpan',
        ),
        backgroundColor: AppColors.successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    _clearForm();

    if (widget.onSaveSuccess != null) {
      widget.onSaveSuccess!();
    } else if (widget.onCancelEdit != null && widget.initialData != null) {
      widget.onCancelEdit!();
    }
  }

  Widget _buildLabel(String text) {
    return Text(text, style: AppTextStyles.cardTitle.copyWith(fontSize: 12));
  }

  // Date Picker Field 
  Widget _buildDatePickerField() {
    return InkWell(
      onTap: _pickTanggal,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderLight),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _formatTanggal(_selectedTanggal),
                style: AppTextStyles.cardTitle.copyWith(
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    String? hintText,
    bool isReadOnly = false,
  }) {
    final bool hasError = _showErrors && (controller?.text.trim().isEmpty ?? false);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: hasError ? Colors.red.shade400 : AppColors.borderLight,
          width: hasError ? 1.5 : 1.0,
        ),
      ),
      child: TextFormField(
        controller: controller,
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

  Widget _buildDropdown<T>({
    required T? value,
    required List<T> items,
    required String hint,
    required ValueChanged<T?> onChanged,
    bool hasError = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: hasError ? Colors.red.shade400 : AppColors.borderLight,
          width: hasError ? 1.5 : 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          hint: Text(hint, style: AppTextStyles.cardSubtitle),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.secondaryOrange,
          ),
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(item.toString(), style: AppTextStyles.cardTitle),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildRichTextEditor() {
    final bool hasError = _showErrors && _quillController.document.toPlainText().trim().isEmpty;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: hasError ? Colors.red.shade400 : AppColors.borderLight,
          width: hasError ? 1.5 : 1.0,
        ),
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
                multiRowsDisplay: true,
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