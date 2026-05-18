import 'package:flutter/material.dart';

/// Avatar lingkaran dengan inisial siswa
class StudentAvatarBadge extends StatelessWidget {
  final String initials;
  final Color? backgroundColor;
  final double size;

  const StudentAvatarBadge({
    super.key,
    required this.initials,
    this.backgroundColor,
    this.size = 36,
  });

  /// Generate warna avatar unik dari inisial
  static Color _colorFromInitials(String initials) {
    const colors = [
      Color(0xFF1B3C73),
      Color(0xFF0D9488),
      Color(0xFF7C3AED),
      Color(0xFFB45309),
      Color(0xFF0369A1),
      Color(0xFF15803D),
    ];
    final index = initials.codeUnitAt(0) % colors.length;
    return colors[index];
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? _colorFromInitials(initials);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: size * 0.35,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
