import 'dart:ui';

import 'package:flutter/material.dart';

/// Dekorasi chart abstrak semi-transparan di sisi kanan kartu statistik.
class StatistikChartPlaceholder extends StatelessWidget {
  const StatistikChartPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: CustomPaint(
            painter: _BarChartPainter(),
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.22)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final bars = [0.45, 0.72, 0.55, 0.88, 0.62];
    final gap = w * 0.08;
    final barW = (w - gap * (bars.length + 1)) / bars.length;
    var x = gap;
    for (final t in bars) {
      final bh = h * 0.65 * t;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, h * 0.85 - bh, barW, bh),
          const Radius.circular(4),
        ),
        paint,
      );
      x += barW + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
