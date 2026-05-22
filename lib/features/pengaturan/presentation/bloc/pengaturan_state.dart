import 'package:equatable/equatable.dart';
import '../../domain/entities/pengaturan_profile_entity.dart';

abstract class PengaturanState extends Equatable {
  const PengaturanState();
  @override
  List<Object?> get props => [];
}

class PengaturanInitial extends PengaturanState {}

class PengaturanLoading extends PengaturanState {}

class ProfileLoaded extends PengaturanState {
  final PengaturanProfileEntity profile;
  const ProfileLoaded({required this.profile});
  @override
  List<Object?> get props => [profile];
}

class PasswordSaving extends PengaturanState {
  final PengaturanProfileEntity profile;
  const PasswordSaving({required this.profile});
  @override
  List<Object?> get props => [profile];
}

class PasswordChanged extends PengaturanState {
  final PengaturanProfileEntity profile;
  const PasswordChanged({required this.profile});
  @override
  List<Object?> get props => [profile];
}

class PengaturanError extends PengaturanState {
  final String message;
  final PengaturanProfileEntity? profile;
  const PengaturanError({required this.message, this.profile});
  @override
  List<Object?> get props => [message, profile];
}
