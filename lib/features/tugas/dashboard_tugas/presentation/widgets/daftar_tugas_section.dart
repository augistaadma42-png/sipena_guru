import 'package:flutter/material.dart';
import '../../../../../../core/constants/text_styles.dart';
import '../../domain/entities/tugas_entity.dart';
import 'tugas_card.dart';

class DaftarTugasSection extends StatelessWidget {
  final List<TugasEntity> tugasList;

  const DaftarTugasSection({super.key, required this.tugasList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            'Daftar Tugas',
            style: AppTextStyles.sectionTitle.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tugasList.length,
            itemBuilder: (context, index) {
              return TugasCard(tugas: tugasList[index]);
            },
          ),
          const SizedBox(height: 80), // Space for FAB
        ],
      ),
    );
  }
}
