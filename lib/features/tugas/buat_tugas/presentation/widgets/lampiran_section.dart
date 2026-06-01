import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/constants/colors.dart';

// Model sederhana untuk item lampiran yang sudah ditambahkan
class _LampiranAdded {
  final IconData icon;
  final Color color;
  final String nama;
  final String tipe;

  const _LampiranAdded({
    required this.icon,
    required this.color,
    required this.nama,
    required this.tipe,
  });
}

// Contoh lampiran per tombol
const _contohLampiran = {
  'Upload': _LampiranAdded(
    icon: Icons.insert_drive_file_outlined,
    color: AppColors.primaryBlue,
    nama: 'Soal_Integral_XII_IPA1.docx',
    tipe: 'File Upload',
  ),
  'Link': _LampiranAdded(
    icon: Icons.link,
    color: Color(0xFF10B981),
    nama: 'https://mathworld.wolfram.com/integral',
    tipe: 'Tautan',
  ),
};

class LampiranSection extends StatefulWidget {
  final ValueNotifier<List<String>>? lampiranNamesNotifier;

  const LampiranSection({super.key, this.lampiranNamesNotifier});

  @override
  State<LampiranSection> createState() => _LampiranSectionState();
}

class _LampiranSectionState extends State<LampiranSection> {
  final List<_LampiranAdded> _addedItems = [];

  @override
  void initState() {
    super.initState();
    if (widget.lampiranNamesNotifier != null) {
      for (final name in widget.lampiranNamesNotifier!.value) {
        final match = _contohLampiran.values.firstWhere(
          (element) => element.nama == name,
          orElse: () => _LampiranAdded(
            icon: Icons.insert_drive_file_outlined,
            color: AppColors.primaryBlue,
            nama: name,
            tipe: 'File Upload',
          ),
        );
        _addedItems.add(match);
      }
    }
  }

  void _tambahLampiran(String label) {
    final contoh = _contohLampiran[label];
    if (contoh == null) return;

    // Cegah duplikat tipe yang sama
    final sudahAda = _addedItems.any((e) => e.tipe == contoh.tipe);
    if (sudahAda) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lampiran $label sudah ditambahkan'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    setState(() {
      _addedItems.add(contoh);
    });
    _updateNotifier();
  }

  void _hapusLampiran(_LampiranAdded item) {
    setState(() {
      _addedItems.remove(item);
    });
    _updateNotifier();
  }

  void _updateNotifier() {
    if (widget.lampiranNamesNotifier != null) {
      widget.lampiranNamesNotifier!.value = _addedItems
          .map((e) => e.nama)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      _ButtonData(
        icon: Icons.upload_outlined,
        label: 'Upload',
        color: AppColors.primaryBlue,
      ),
      _ButtonData(
        icon: Icons.link,
        label: 'Link',
        color: const Color(0xFF10B981),
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(
                Icons.attach_file,
                color: AppColors.primaryBlue,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Lampirkan',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              if (_addedItems.isNotEmpty) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_addedItems.length}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // Tombol-tombol lampiran
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buttons
                .map(
                  (b) => _LampiranButton(
                    icon: b.icon,
                    label: b.label,
                    color: b.color,
                    onTap: () => _tambahLampiran(b.label),
                  ),
                )
                .toList(),
          ),

          // Daftar lampiran yang sudah ditambahkan
          if (_addedItems.isNotEmpty) ...[
            const SizedBox(height: 14),
            const Divider(height: 1),
            const SizedBox(height: 10),
            Text(
              'Lampiran ditambahkan',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            ...(_addedItems.map(
              (item) => _LampiranItem(
                item: item,
                onHapus: () => _hapusLampiran(item),
              ),
            )),
          ],
        ],
      ),
    );
  }
}

class _ButtonData {
  final IconData icon;
  final String label;
  final Color color;
  const _ButtonData({
    required this.icon,
    required this.label,
    required this.color,
  });
}

class _LampiranButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _LampiranButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.25)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: color, size: 26),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LampiranItem extends StatelessWidget {
  final _LampiranAdded item;
  final VoidCallback onHapus;

  const _LampiranItem({required this.item, required this.onHapus});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: item.color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: item.color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(item.icon, color: item.color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nama,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  item.tipe,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onHapus,
            child: Icon(
              Icons.close_rounded,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
