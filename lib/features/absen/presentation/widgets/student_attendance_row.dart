import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class StudentAttendanceRow extends StatefulWidget {
  final String initials;
  final String name;
  final String nis;
  final String initialStatus; // 'Hadir', 'Izin', 'Sakit', 'Alpha'
  final bool isReadOnly;

  const StudentAttendanceRow({
    Key? key,
    required this.initials,
    required this.name,
    required this.nis,
    this.initialStatus = 'Hadir',
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  State<StudentAttendanceRow> createState() => _StudentAttendanceRowState();
}

class _StudentAttendanceRowState extends State<StudentAttendanceRow> {
  late String _status;

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus;
  }

  // Method called from parent (DetailAbsensiPage) to reset status
  void resetStatus() {
    if (!widget.isReadOnly) {
      setState(() {
        _status = 'Hadir'; // Default reset
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderLight)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
            child: Text(
              widget.initials,
              style: AppTextStyles.cardTitle.copyWith(color: AppColors.primaryBlue, fontSize: 14),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                ),
                Text(
                  'NIS: ${widget.nis}',
                  style: AppTextStyles.cardSubtitle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          _buildStatusDropdown(),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown() {
    Color bgColor;
    Color textColor;

    switch (_status) {
      case 'Hadir':
        bgColor = const Color(0xFFE8F5E9); // Light green
        textColor = const Color(0xFF2E7D32); // Green
        break;
      case 'Izin':
        bgColor = const Color(0xFFFFF9C4); // Light yellow
        textColor = const Color(0xFFF57F17); // Dark yellow/orange
        break;
      case 'Sakit':
        bgColor = const Color(0xFFFFF9C4); // Light yellow
        textColor = const Color(0xFFF57F17); // Dark yellow/orange
        break;
      case 'Alpha':
        bgColor = const Color(0xFFFFEBEE); // Light red
        textColor = const Color(0xFFC62828); // Red
        break;
      default:
        bgColor = Colors.grey[200]!;
        textColor = Colors.grey[800]!;
    }

    Widget pillContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _status,
          style: AppTextStyles.labelStyle.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (!widget.isReadOnly) ...[
          const SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down, size: 16, color: textColor),
        ],
      ],
    );

    final container = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: pillContent,
    );

    if (widget.isReadOnly) {
      return container;
    }

    return PopupMenuButton<String>(
      initialValue: _status,
      onSelected: (String newValue) {
        setState(() {
          _status = newValue;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(value: 'Hadir', child: Text('Hadir')),
        const PopupMenuItem<String>(value: 'Izin', child: Text('Izin')),
        const PopupMenuItem<String>(value: 'Sakit', child: Text('Sakit')),
        const PopupMenuItem<String>(value: 'Alpha', child: Text('Alpha')),
      ],
      child: container,
    );
  }
}
