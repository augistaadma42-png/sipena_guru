import 'package:equatable/equatable.dart';
import '../../domain/entities/notifikasi_entity.dart';

abstract class NotifikasiState extends Equatable {
  const NotifikasiState();

  @override
  List<Object> get props => [];
}

class NotifikasiInitial extends NotifikasiState {}

class NotifikasiLoading extends NotifikasiState {}

class NotifikasiLoaded extends NotifikasiState {
  final List<NotifikasiEntity> notifikasiList;

  const NotifikasiLoaded({required this.notifikasiList});

  @override
  List<Object> get props => [notifikasiList];
}

class NotifikasiError extends NotifikasiState {
  final String message;

  const NotifikasiError({required this.message});

  @override
  List<Object> get props => [message];
}
