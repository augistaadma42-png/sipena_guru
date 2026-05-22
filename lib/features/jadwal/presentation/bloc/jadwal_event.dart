import 'package:equatable/equatable.dart';

abstract class JadwalEvent extends Equatable {
  const JadwalEvent();

  @override
  List<Object?> get props => [];
}

class LoadJadwalEvent extends JadwalEvent {}
