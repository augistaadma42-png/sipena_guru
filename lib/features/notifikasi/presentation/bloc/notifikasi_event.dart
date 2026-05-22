import 'package:equatable/equatable.dart';

abstract class NotifikasiEvent extends Equatable {
  const NotifikasiEvent();

  @override
  List<Object> get props => [];
}

class LoadNotifikasiEvent extends NotifikasiEvent {}

class MarkAsReadEvent extends NotifikasiEvent {
  final String id;

  const MarkAsReadEvent(this.id);

  @override
  List<Object> get props => [id];
}

class MarkAllAsReadEvent extends NotifikasiEvent {}
