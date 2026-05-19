import 'package:equatable/equatable.dart';
import '../../domain/entities/kelas_diampu_entity.dart';

abstract class DaftarKelasState extends Equatable {
  const DaftarKelasState();
  
  @override
  List<Object> get props => [];
}

class DaftarKelasInitial extends DaftarKelasState {}

class DaftarKelasLoading extends DaftarKelasState {}

class DaftarKelasLoaded extends DaftarKelasState {
  final List<KelasDiampuEntity> kelasList;

  const DaftarKelasLoaded({required this.kelasList});

  @override
  List<Object> get props => [kelasList];
}

class DaftarKelasError extends DaftarKelasState {
  final String message;

  const DaftarKelasError({required this.message});

  @override
  List<Object> get props => [message];
}
