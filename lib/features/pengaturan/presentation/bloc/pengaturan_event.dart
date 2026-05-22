import 'package:equatable/equatable.dart';

abstract class PengaturanEvent extends Equatable {
  const PengaturanEvent();
  @override
  List<Object?> get props => [];
}

class LoadProfileEvent extends PengaturanEvent {}

class UbahPasswordEvent extends PengaturanEvent {
  final String passwordLama;
  final String passwordBaru;
  final String konfirmasi;

  const UbahPasswordEvent({
    required this.passwordLama,
    required this.passwordBaru,
    required this.konfirmasi,
  });

  @override
  List<Object?> get props => [passwordLama, passwordBaru, konfirmasi];
}
