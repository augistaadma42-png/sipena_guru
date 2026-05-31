import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';
import 'custom_feedback_field.dart';

class FeedbackInputCard extends StatelessWidget {
  final String currentFeedback;
  final ValueChanged<String> onFeedbackChanged;
  final bool readOnly;

  const FeedbackInputCard({
    super.key,
    required this.currentFeedback,
    required this.onFeedbackChanged,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0D000000), blurRadius: 16, offset: Offset(0, 4))
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                readOnly ? 'Feedback' : 'Beri Feedback',
                style: AppTextStyles.sectionTitle,
              ),
              if (readOnly) ...[
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.successGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Sudah diberikan',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.successGreen,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          CustomFeedbackField(
            initialValue: currentFeedback,
            onChanged: onFeedbackChanged,
            readOnly: readOnly,
          ),
        ],
      ),
    );
  }
}