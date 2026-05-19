import 'package:equatable/equatable.dart';

abstract class DaftarKelasEvent extends Equatable {
  const DaftarKelasEvent();

  @override
  List<Object> get props => [];
}

class LoadDaftarKelasEvent extends DaftarKelasEvent {}
