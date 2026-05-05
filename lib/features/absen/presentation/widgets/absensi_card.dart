import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../pages/detail_absensi_page.dart';

enum AbsensiStatus { berlangsung, mendatang, selesai }

class AbsensiCard extends StatefulWidget {
  final AbsensiStatus initialStatus;
  final String className;
  final String subject;
  final String time;
  final String jamKe;

  const AbsensiCard({
    Key? key,
    required this.initialStatus,
    required this.className,
    required this.subject,
    required this.time,
    required this.jamKe,
  }) : super(key: key);

  @override
  State<AbsensiCard> createState() => _AbsensiCardState();
}

class _AbsensiCardState extends State<AbsensiCard> {
  late AbsensiStatus _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.initialStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: _currentStatus == AbsensiStatus.berlangsung ? AppColors.secondaryOrange : AppColors.primaryBlue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBadge(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.time,
                              style: AppTextStyles.cardTitle.copyWith(fontSize: 12),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                if (_currentStatus == AbsensiStatus.selesai) ...[
                                  const Icon(Icons.check_circle, size: 12, color: AppColors.primaryBlue),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Tersimpan',
                                    style: AppTextStyles.labelStyle.copyWith(color: AppColors.primaryBlue, fontSize: 10),
                                  ),
                                ] else ...[
                                  Text(
                                    widget.jamKe,
                                    style: AppTextStyles.cardSubtitle.copyWith(fontSize: 10),
                                  ),
                                ]
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.className,
                      style: AppTextStyles.sectionTitle.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subject,
                      style: AppTextStyles.cardSubtitle,
                    ),
                    const SizedBox(height: 16),
                    _buildActionButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge() {
    Color bgColor;
    Color textColor;
    String text;

    switch (_currentStatus) {
      case AbsensiStatus.berlangsung:
        bgColor = AppColors.secondaryOrange.withOpacity(0.15);
        textColor = AppColors.secondaryOrange;
        text = 'SEDANG BERLANGSUNG';
        break;
      case AbsensiStatus.mendatang:
        bgColor = AppColors.primaryBlue.withOpacity(0.1);
        textColor = AppColors.primaryBlue;
        text = 'MENDATANG';
        break;
      case AbsensiStatus.selesai:
        bgColor = AppColors.successGreen.withOpacity(0.15);
        textColor = AppColors.successGreen;
        text = 'SELESAI';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: AppTextStyles.labelStyle.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 9,
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    if (_currentStatus == AbsensiStatus.berlangsung) {
      return SizedBox(
        width: double.infinity,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            _navigateToDetail(isReadOnly: false);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryOrange,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Input Absensi', style: AppTextStyles.cardTitle.copyWith(color: Colors.white)),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
            ],
          ),
        ),
      );
    } else if (_currentStatus == AbsensiStatus.mendatang) {
      return SizedBox(
        width: double.infinity,
        height: 40,
        child: OutlinedButton(
          onPressed: () {
            // Simulasi Buka Sesi
            setState(() {
              _currentStatus = AbsensiStatus.berlangsung;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Sesi Absensi Berhasil Dibuka! (Simulasi)'),
                backgroundColor: AppColors.successGreen,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primaryBlue),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Buka Sesi', style: AppTextStyles.cardTitle.copyWith(color: AppColors.primaryBlue)),
              const SizedBox(width: 8),
              const Icon(Icons.lock_outline, size: 18, color: AppColors.primaryBlue),
            ],
          ),
        ),
      );
    } else {
      // Selesai
      return SizedBox(
        width: double.infinity,
        height: 40,
        child: OutlinedButton(
          onPressed: () {
            _navigateToDetail(isReadOnly: true);
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primaryBlue),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Lihat', style: AppTextStyles.cardTitle.copyWith(color: AppColors.primaryBlue)),
              const SizedBox(width: 8),
              const Icon(Icons.visibility_outlined, size: 18, color: AppColors.primaryBlue),
            ],
          ),
        ),
      );
    }
  }

  void _navigateToDetail({required bool isReadOnly}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailAbsensiPage(
          className: widget.className,
          subject: widget.subject,
          time: widget.time,
          jamKe: widget.jamKe,
          isReadOnly: isReadOnly,
        ),
      ),
    );
  }
}
