import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';

class LoadingDetailPenilaianWidget extends StatefulWidget {
  const LoadingDetailPenilaianWidget({super.key});

  @override
  State<LoadingDetailPenilaianWidget> createState() =>
      _LoadingDetailPenilaianWidgetState();
}

class _LoadingDetailPenilaianWidgetState
    extends State<LoadingDetailPenilaianWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1200))..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Opacity(
        opacity: _anim.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              _skeleton(160), const SizedBox(height: 16),
              _skeleton(220), const SizedBox(height: 16),
              _skeleton(100), const SizedBox(height: 16),
              _skeleton(140),
            ],
          ),
        ),
      ),
    );
  }

  Widget _skeleton(double height) => Container(
    height: height, width: double.infinity,
    decoration: BoxDecoration(
      color: AppColors.borderLight,
      borderRadius: BorderRadius.circular(20)));
}