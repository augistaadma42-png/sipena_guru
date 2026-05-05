import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class JurnalTerbaruTimeline extends StatefulWidget {
  final VoidCallback onLihatRekapTap;
  final Function(Map<String, String>)? onEditTap;

  const JurnalTerbaruTimeline({
    Key? key,
    required this.onLihatRekapTap,
    this.onEditTap,
  }) : super(key: key);

  @override
  State<JurnalTerbaruTimeline> createState() => _JurnalTerbaruTimelineState();
}

class _JurnalTerbaruTimelineState extends State<JurnalTerbaruTimeline> {
  final ScrollController _scrollController = ScrollController();
  int _activeIndex = 0;
  final double _itemHeight = 130.0;

  final List<Map<String, String>> _jurnals = [
    {
      'time': '13:00 - 14:30',
      'className': 'XI-MP 4',
      'title': 'PPT Drama',
      'description': 'Presentasi PPT mengenai materi drama pada...',
    },
    {
      'time': '10:00 - 11:30',
      'className': 'X-RPL 1',
      'title': 'Latihan Soal Cerpen',
      'description': 'Mengoreksi Bersama Latihan soal cerpen...',
    },
    {
      'time': '08:00 - 09:30',
      'className': 'XI-RPL 1',
      'title': 'Praktik Drama',
      'description': 'Diskusi kelompok mengenai penampilan praktik drama...',
    },
    {
      'time': '07:00 - 08:00',
      'className': 'X-TKJ 2',
      'title': 'Pengantar Jaringan',
      'description': 'Pengenalan dasar-dasar topologi jaringan komputer...',
    },
    {
      'time': '06:30 - 07:00',
      'className': 'Apel Pagi',
      'title': 'Upacara Bendera',
      'description': 'Mengikuti upacara bendera bersama seluruh siswa...',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Menghitung indeks mana yang sedang berada di atas berdasarkan scroll
      int newIndex = (_scrollController.offset / _itemHeight).round();
      if (newIndex < 0) newIndex = 0;
      if (newIndex >= _jurnals.length) newIndex = _jurnals.length - 1;

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
        color: const Color(0xFFF4F6F9), // Warna sangat terang persis seperti desain
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
            height: 280, // Membatasi tinggi agar bisa di-scroll
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(right: 16),
              itemCount: _jurnals.length,
              itemBuilder: (context, index) {
                final jurnal = _jurnals[index];
                return _buildTimelineItem(
                  time: jurnal['time']!,
                  className: jurnal['className']!,
                  title: jurnal['title']!,
                  description: jurnal['description']!,
                  isLast: index == _jurnals.length - 1,
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
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
                    style: AppTextStyles.cardTitle.copyWith(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String className,
    required String title,
    required String description,
    required bool isLast,
    required bool isActive,
    VoidCallback? onEdit,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24, // Fixed width for the column to center the dots
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isActive ? 20 : 16,
                  height: isActive ? 20 : 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive ? AppColors.primaryBlue : Colors.grey[350]!,
                      width: isActive ? 4 : 4,
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$time • $className',
                    style: AppTextStyles.labelStyle.copyWith(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTextStyles.cardSubtitle.copyWith(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      InkWell(
                        onTap: onEdit ?? () {
                          print('Edit Jurnal: $title');
                        },
                        borderRadius: BorderRadius.circular(4),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(Icons.edit_outlined, size: 16, color: Colors.grey[700]),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Hapus Jurnal', style: AppTextStyles.sectionTitle),
                              content: Text(
                                'Apakah Anda yakin ingin menghapus jurnal "$title"? Tindakan ini tidak dapat dibatalkan.',
                                style: AppTextStyles.cardSubtitle,
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Batal', style: AppTextStyles.cardTitle.copyWith(color: AppColors.textSecondary)),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Tutup dialog
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Jurnal berhasil dihapus'),
                                        backgroundColor: AppColors.primaryBlue,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.withOpacity(0.9),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: const Text('Hapus', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(4),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(Icons.delete_outline, size: 16, color: Colors.red.withOpacity(0.8)),
                        ),
                      ),
                    ],
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
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
