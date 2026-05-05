import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/student_attendance_row.dart';

class DetailAbsensiPage extends StatefulWidget {
  final String className;
  final String subject;
  final String time;
  final String jamKe;
  final bool isReadOnly;

  const DetailAbsensiPage({
    Key? key,
    required this.className,
    required this.subject,
    required this.time,
    required this.jamKe,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  State<DetailAbsensiPage> createState() => _DetailAbsensiPageState();
}

class _DetailAbsensiPageState extends State<DetailAbsensiPage> {
  int _resetCount = 0; // Digunakan untuk force rebuild child widgets saat reset

  final List<Map<String, dynamic>> _dummyStudents = [
    {'initials': 'EF', 'name': 'Esa Farellio', 'nis': '2021001', 'status': 'Hadir'},
    {'initials': 'AA', 'name': 'Augista A.Z', 'nis': '2021002', 'status': 'Izin'},
    {'initials': 'FS', 'name': 'Feby Shandy I.', 'nis': '2021003', 'status': 'Sakit'},
    {'initials': 'GK', 'name': 'Gavin K.H', 'nis': '2021004', 'status': 'Alpha'},
    {'initials': 'FA', 'name': 'Fariskha A.F', 'nis': '2021005', 'status': 'Hadir'},
    {'initials': 'DA', 'name': 'Devita A.V.P', 'nis': '2021006', 'status': 'Hadir'},
    {'initials': 'AF', 'name': 'Anindya F.A', 'nis': '2021007', 'status': 'Hadir'},
    {'initials': 'HA', 'name': 'Helmalia A', 'nis': '2021008', 'status': 'Hadir'},
    {'initials': 'ER', 'name': 'Eka Rara A.A', 'nis': '2021009', 'status': 'Hadir'},
  ];

  void _simpanAbsensi() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Absensi berhasil disimpan! (Simulasi Front-End)'),
        backgroundColor: AppColors.successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    Navigator.pop(context);
  }

  void _resetAbsensi() {
    setState(() {
      _resetCount++; // Akan membuat widget row terbuat ulang dengan status default
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Absensi', showBackButton: true),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeaderCard(),
                const SizedBox(height: 24),
                if (widget.isReadOnly) ...[
                  _buildSummaryBox(),
                  const SizedBox(height: 24),
                ],
                _buildStudentList(),
                if (!widget.isReadOnly) const SizedBox(height: 100), // padding untuk bottom bar
              ],
            ),
          ),
          if (!widget.isReadOnly) _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.className,
                style: AppTextStyles.sectionTitle.copyWith(fontSize: 22),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.subject,
                  style: AppTextStyles.labelStyle.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.jamKe} (${widget.time})',
            style: AppTextStyles.cardSubtitle,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF002369), // Dark Blue
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today_outlined, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Senin, 24 Mei 2024',
                  style: AppTextStyles.cardTitle.copyWith(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rekapitulasi Absensi',
            style: AppTextStyles.cardTitle.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem('Hadir', '34', const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
              _buildSummaryItem('Sakit', '2', const Color(0xFFFFF9C4), const Color(0xFFF57F17)),
              _buildSummaryItem('Izin', '2', const Color(0xFFFFF9C4), const Color(0xFFF57F17)),
              _buildSummaryItem('Alpha', '0', const Color(0xFFFFEBEE), const Color(0xFFC62828)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String count, Color bgColor, Color textColor) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              count,
              style: AppTextStyles.sectionTitle.copyWith(color: textColor, fontSize: 18),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.cardSubtitle.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildStudentList() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daftar Siswa',
                style: AppTextStyles.sectionTitle.copyWith(fontSize: 18, color: AppColors.primaryBlue),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.secondaryOrange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '38 Siswa',
                  style: AppTextStyles.cardTitle.copyWith(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('NAMA SISWA', style: AppTextStyles.labelStyle),
                Text('STATUS', style: AppTextStyles.labelStyle),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // List Data
          ..._dummyStudents.asMap().entries.map((entry) {
            final index = entry.key;
            final student = entry.value;
            // Jika reset dipanggil, maka kita berikan status 'Hadir' secara paksa 
            // karena ini simulasi dan ValueKey akan merebuild widget
            final initialStatus = (_resetCount > 0) ? 'Hadir' : student['status'];

            return StudentAttendanceRow(
              key: ValueKey('student_${index}_$_resetCount'),
              initials: student['initials'],
              name: student['name'],
              nis: student['nis'],
              initialStatus: widget.isReadOnly ? student['status'] : initialStatus,
              isReadOnly: widget.isReadOnly,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(top: BorderSide(color: AppColors.borderLight)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: OutlinedButton(
                onPressed: _resetAbsensi,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: AppColors.primaryBlue),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: Text(
                  'Reset',
                  style: AppTextStyles.cardTitle.copyWith(color: AppColors.primaryBlue),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _simpanAbsensi,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: AppColors.secondaryOrange,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: Text(
                  'Simpan Absensi',
                  style: AppTextStyles.cardTitle.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
