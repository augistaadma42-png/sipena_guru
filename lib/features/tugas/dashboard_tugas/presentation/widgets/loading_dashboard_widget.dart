import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';

class LoadingDashboardWidget extends StatelessWidget {
  const LoadingDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _skeleton(width: 150, height: 20),
          const SizedBox(height: 12),
          _skeleton(width: 250, height: 35),
          const SizedBox(height: 40),
          _skeleton(width: 180, height: 25),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: _skeleton(width: 280, height: 110, radius: 20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          _skeleton(width: 180, height: 25),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: _skeleton(width: double.infinity, height: 180, radius: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skeleton({
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.borderLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
