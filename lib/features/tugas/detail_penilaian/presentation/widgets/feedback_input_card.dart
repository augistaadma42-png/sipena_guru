import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';
import 'custom_feedback_field.dart';

class FeedbackInputCard extends StatelessWidget {
  final String currentFeedback;
  final ValueChanged<String> onFeedbackChanged;
  const FeedbackInputCard({super.key, required this.currentFeedback,
      required this.onFeedbackChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(
          color: Color(0x0D000000), blurRadius: 16, offset: Offset(0, 4))],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Beri Feedback', style: AppTextStyles.sectionTitle),
          const SizedBox(height: 14),
          CustomFeedbackField(
            initialValue: currentFeedback, onChanged: onFeedbackChanged),
        ],
      ),
    );
  }
}