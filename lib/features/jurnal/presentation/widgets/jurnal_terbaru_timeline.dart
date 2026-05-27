import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../domain/entities/jurnal_entity.dart';

class JurnalTerbaruTimeline extends StatefulWidget {
  final List<JurnalEntity> jurnalList;
  final VoidCallback onLihatRekapTap;
  final Function(JurnalEntity)? onEditTap;

  const JurnalTerbaruTimeline({
    Key? key,
    required this.jurnalList,
    required this.onLihatRekapTap,
    this.onEditTap,
  }) : super(key: key);

  @override
  State<JurnalTerbaruTimeline> createState() => _JurnalTerbaruTimelineState();
}

class _JurnalTerbaruTimelineState extends State<JurnalTerbaruTimeline> {
  final ScrollController _scrollController = ScrollController();
  int _activeIndex = 0;
  final double _itemHeight = 150.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      int newIndex = (_scrollController.offset / _itemHeight).round();
      if (newIndex < 0) newIndex = 0;
      if (newIndex >= widget.jurnalList.length) {
        newIndex = widget.jurnalList.length - 1;
      }
      if (_activeIndex != newIndex) {
        setState(() {
          _activeIndex = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jurnal Terbaru',
            style: AppTextStyles.sectionTitle.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(right: 16),
              itemCount: widget.jurnalList.length,
              itemBuilder: (context, index) {
                final jurnal = widget.jurnalList[index];
                return _buildTimelineItem(
                  jurnal: jurnal,
                  isLast: index == widget.jurnalList.length - 1,
                  isActive: index == _activeIndex,
                  onEdit: () {
                    if (widget.onEditTap != null) {
                      widget.onEditTap!(jurnal);
                    }
                  },
                );
              },
            ),
          ),
          CustomPaint(
            size: const Size(double.infinity, 1),
            painter: _DashedLinePainter(),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: widget.onLihatRekapTap,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                backgroundColor: AppColors.secondaryOrange,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Lihat Rekap Jurnal',
                    style:
                        AppTextStyles.cardTitle.copyWith(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward,
                      size: 16, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required JurnalEntity jurnal,
    required bool isLast,
    required bool isActive,
    VoidCallback? onEdit,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot + line
          SizedBox(
            width: 24,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isActive ? 20 : 16,
                  height: isActive ? 20 : 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive
                          ? AppColors.primaryBlue
                          : Colors.grey[350]!,
                      width: 4,
                    ),
                    color: Colors.white,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: AppColors.borderLight,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Content card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row: jam + kelas
                  Row(
                    children: [
                      Text(
                        jurnal.time,
                        style: AppTextStyles.labelStyle.copyWith(
                          color: isActive
                              ? AppColors.primaryBlue
                              : AppColors.textSecondary,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primaryBlue.withOpacity(0.1)
                              : AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          jurnal.className,
                          style: AppTextStyles.labelStyle.copyWith(
                            color: isActive
                                ? AppColors.primaryBlue
                                : AppColors.textSecondary,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Mapel badge (NEW)
                  if (jurnal.mapel.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryOrange.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.menu_book_outlined,
                            size: 11,
                            color: AppColors.secondaryOrange,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            jurnal.mapel,
                            style: AppTextStyles.labelStyle.copyWith(
                              color: AppColors.secondaryOrange,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Judul
                  Text(
                    jurnal.title,
                    style: AppTextStyles.cardTitle.copyWith(
                      fontSize: 14,
                      color: isActive
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Deskripsi
                  Text(
                    jurnal.description,
                    style: AppTextStyles.cardSubtitle
                        .copyWith(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Tombol Edit
                  InkWell(
                    onTap: onEdit,
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.edit_outlined,
                              size: 16, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            'Edit',
                            style: AppTextStyles.labelStyle.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 4, dashSpace = 4, startX = 0;
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(
          Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
