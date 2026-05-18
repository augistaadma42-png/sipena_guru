import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';
import '../../domain/entities/student_nilai_entity.dart';
import 'nilai_table_header.dart';
import 'nilai_student_row.dart';
import 'pagination_widget.dart';
import 'empty_nilai_widget.dart';

/// Card utama yang berisi daftar nilai siswa lengkap dengan tabel dan pagination
class DaftarNilaiCard extends StatelessWidget {
  final List<StudentNilaiEntity> students;
  final int currentPage;
  final int totalPages;
  final int totalSiswa;
  final int perPage;
  final ValueChanged<int> onPageChanged;
  final String semester;

  const DaftarNilaiCard({
    super.key,
    required this.students,
    required this.currentPage,
    required this.totalPages,
    required this.totalSiswa,
    required this.perPage,
    required this.onPageChanged,
    this.semester = 'Semester Ganjil 2023/2024',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header card: judul + semester
          _buildCardHeader(),
          // Header tabel
          const NilaiTableHeader(),
          // Daftar siswa atau empty state
          students.isEmpty
              ? const EmptyNilaiWidget()
              : _buildStudentList(),
          // Divider sebelum pagination
          const Divider(height: 1, color: AppColors.borderLight),
          // Pagination
          PaginationWidget(
            currentPage: currentPage,
            totalPages: totalPages,
            totalSiswa: totalSiswa,
            perPage: perPage,
            onPageChanged: onPageChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildCardHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul kiri
          Expanded(
            child: Text(
              'Daftar Nilai\nSiswa',
              style: AppTextStyles.sectionTitle,
            ),
          ),
          // Semester kanan dengan icon kalender
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                semester,
                style: AppTextStyles.cardSubtitle,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStudentList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        final nomor = ((currentPage - 1) * perPage) + index + 1;
        return NilaiStudentRow(
          student: student,
          nomor: nomor,
          isLast: index == students.length - 1,
        );
      },
    );
  }
}