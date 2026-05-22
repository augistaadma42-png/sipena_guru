import 'package:flutter/material.dart';

class AktivitasEntity {
  final String tanggal;
  final String jam;
  final String deskripsi;
  final String jenis;
  final IconData icon;

  const AktivitasEntity({
    required this.tanggal,
    required this.jam,
    required this.deskripsi,
    required this.jenis,
    required this.icon,
  });
}
