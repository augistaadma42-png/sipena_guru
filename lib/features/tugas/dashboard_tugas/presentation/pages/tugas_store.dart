import 'package:flutter/material.dart';
import '../../../buat_tugas/domain/entities/tugas.dart';

/// Global in-memory store untuk tugas (frontend only, no DB)
class TugasStore extends InheritedNotifier<ValueNotifier<List<Tugas>>> {
  const TugasStore({
    super.key,
    required super.notifier,
    required super.child,
  });

  static ValueNotifier<List<Tugas>> of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<TugasStore>();
    assert(result != null, 'TugasStore tidak ditemukan di widget tree');
    return result!.notifier!;
  }

  static void tambah(BuildContext context, Tugas tugas) {
    final notifier = of(context);
    notifier.value = [...notifier.value, tugas];
  }
}
