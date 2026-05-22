import 'package:equatable/equatable.dart';
import '../../domain/entities/jadwal_slot_entity.dart';
import '../../domain/entities/jam_slot_entity.dart';

abstract class JadwalState extends Equatable {
  const JadwalState();

  @override
  List<Object?> get props => [];
}

class JadwalInitial extends JadwalState {}

class JadwalLoading extends JadwalState {}

class JadwalLoaded extends JadwalState {
  final List<JamSlotEntity> slots;
  final List<JadwalSlotEntity> jadwalData;

  const JadwalLoaded({
    required this.slots,
    required this.jadwalData,
  });

  @override
  List<Object?> get props => [slots, jadwalData];
}

class JadwalError extends JadwalState {
  final String message;

  const JadwalError({required this.message});

  @override
  List<Object?> get props => [message];
}
