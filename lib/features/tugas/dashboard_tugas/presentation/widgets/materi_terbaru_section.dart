import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';
import '../../domain/entities/materi_entity.dart';
import 'materi_card.dart';

class MateriTerbaruSection extends StatelessWidget {
  final List<MateriEntity> materiList;

  const MateriTerbaruSection({super.key, required this.materiList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Materi Terbaru',
                style: AppTextStyles.sectionTitle.copyWith(fontSize: 20),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Lihat Semua',
                  style: AppTextStyles.labelStyle.copyWith(
                    color: AppColors.secondaryOrange,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 110,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: materiList.length,
            itemBuilder: (context, index) {
              return MateriCard(materi: materiList[index]);
            },
          ),
        ),
      ],
    );
  }
}
