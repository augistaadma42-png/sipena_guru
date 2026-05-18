import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';

/// Widget file tugas dengan ikon PDF/ZIP dan nama file
class FileTugasWidget extends StatelessWidget {
  final String fileName;

  const FileTugasWidget({super.key, required this.fileName});

  IconData _getFileIcon(String name) {
    final ext = name.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'zip':
      case 'rar':
        return Icons.folder_zip_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          _getFileIcon(fileName),
          size: 14,
          color: AppColors.secondaryOrange,
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            fileName,
            style: AppTextStyles.labelStyle.copyWith(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
