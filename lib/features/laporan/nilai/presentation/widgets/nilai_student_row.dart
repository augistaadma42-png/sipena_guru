import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';
import '../../domain/entities/student_nilai_entity.dart';

/// Widget row untuk satu data siswa di tabel nilai
class NilaiStudentRow extends StatelessWidget {
  final StudentNilaiEntity student;
  final int nomor;
  final bool isLast;

  const NilaiStudentRow({
    super.key,
    required this.student,
    required this.nomor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nomor urut
              SizedBox(
                width: 36,
                child: Text(
                  nomor.toString().padLeft(2, '0'),
                  style: AppTextStyles.tableBody,
                ),
              ),
              // Nama siswa
              Expanded(
                flex: 3,
                child: Text(
                  student.nama,
                  style: AppTextStyles.tableBodyBold,
                ),
              ),
              // Kelas
              Expanded(
                flex: 2,
                child: Text(
                  student.kelas,
                  style: AppTextStyles.tableBody,
                ),
              ),
              // Tanggal input
              Expanded(
                flex: 2,
                child: Text(
                  student.tanggalInput,
                  style: AppTextStyles.tableBody,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        // Divider tipis, tidak ditampilkan pada baris terakhir
        if (!isLast)
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.borderLight,
            indent: 0,
            endIndent: 0,
          ),
      ],
    );
  }
}