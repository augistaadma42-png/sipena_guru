import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';

class FloatingAddTugasButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FloatingAddTugasButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      margin: const EdgeInsets.only(bottom: 20),
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: AppColors.secondaryOrange,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
