import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class PanduanJurnalCard extends StatelessWidget {
  const PanduanJurnalCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF002369),
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF002369),
            Color(0xFF1B3C73),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lightbulb_outline,
                  color: AppColors.secondaryOrange,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Panduan Jurnal',
                style: AppTextStyles.cardTitle.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Jurnal yang lengkap membantu dalam pelaporan portofolio guru dan pemantauan perkembangan siswa secara berkelanjutan.',
            style: AppTextStyles.cardSubtitle.copyWith(
              color: Colors.white.withOpacity(0.8),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          _buildBulletPoint('Spesifik dalam topik bahasan'),
          const SizedBox(height: 8),
          _buildBulletPoint('Sertakan hambatan siswa'),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_outline,
          color: Colors.white.withOpacity(0.8),
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: AppTextStyles.labelStyle.copyWith(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
