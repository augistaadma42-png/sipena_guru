import 'package:flutter/material.dart';
import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/core/constants/text_styles.dart';

/// Dummy preview dokumen — swap dengan PDF renderer saat integrasi nyata
class PreviewFileWidget extends StatelessWidget {
  final String previewUrl;
  const PreviewFileWidget({super.key, required this.previewUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 200, width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            _DummyDocBackground(),
            Positioned(
              bottom: 8, right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('Preview',
                  style: AppTextStyles.labelStyle.copyWith(
                    color: Colors.white, fontSize: 10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DummyDocBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 8)]),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DLine(width: 120, height: 10, color: const Color(0xFFCBD5E1)),
            const SizedBox(height: 8),
            _DLine(width: double.infinity, height: 6),
            const SizedBox(height: 5),
            _DLine(width: double.infinity, height: 6),
            const SizedBox(height: 5),
            _DLine(width: 160, height: 6),
            const SizedBox(height: 14),
            // Tabel dummy 3 baris
            ...List.generate(3, (i) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(children: [
                Expanded(flex: 2, child: _DLine(
                  width: double.infinity, height: 8,
                  color: i == 0
                      ? const Color(0xFFFF7B3A).withOpacity(0.3)
                      : const Color(0xFFE2E8F0))),
                const SizedBox(width: 4),
                Expanded(flex: 3, child: _DLine(
                  width: double.infinity, height: 8,
                  color: i == 0
                      ? const Color(0xFFFF7B3A).withOpacity(0.3)
                      : const Color(0xFFE2E8F0))),
              ]),
            )),
            const Spacer(),
            _DLine(width: 200, height: 6),
          ],
        ),
      ),
    );
  }
}

class _DLine extends StatelessWidget {
  final double width, height;
  final Color color;
  const _DLine({required this.width, required this.height,
      this.color = const Color(0xFFE2E8F0)});

  @override
  Widget build(BuildContext context) => Container(
    width: width, height: height,
    decoration: BoxDecoration(
      color: color, borderRadius: BorderRadius.circular(3)));
}