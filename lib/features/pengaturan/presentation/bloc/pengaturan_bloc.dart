import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/ubah_password_usecase.dart';
import 'pengaturan_event.dart';
import 'pengaturan_state.dart';

class PengaturanBloc extends Bloc<PengaturanEvent, PengaturanState> {
  final GetProfileUsecase getProfileUsecase;
  final UbahPasswordUsecase ubahPasswordUsecase;

  PengaturanBloc({
    required this.getProfileUsecase,
    required this.ubahPasswordUsecase,
  }) : super(PengaturanInitial()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<UbahPasswordEvent>(_onUbahPassword);
  }

  Future<void> _onLoadProfile(
    LoadProfileEvent event,
    Emitter<PengaturanState> emit,
  ) async {
    emit(PengaturanLoading());
    try {
      final profile = await getProfileUsecase();
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(PengaturanError(message: e.toString()));
    }
  }

  Future<void> _onUbahPassword(
    UbahPasswordEvent event,
    Emitter<PengaturanState> emit,
  ) async {
    // Ambil profile saat ini untuk dipertahankan di state
    final currentProfile = state is ProfileLoaded
        ? (state as ProfileLoaded).profile
        : state is PengaturanError
            ? (state as PengaturanError).profile
            : null;

    if (currentProfile == null) return;

    // Validasi di BLoC sebelum panggil usecase
    if (event.passwordLama.isEmpty) {
      emit(PengaturanError(
          message: 'lama:Password lama tidak boleh kosong',
          profile: currentProfile));
      return;
    }
    if (event.passwordBaru.isEmpty) {
      emit(PengaturanError(
          message: 'baru:Password baru tidak boleh kosong',
          profile: currentProfile));
      return;
    }
    if (event.passwordBaru.length < 8) {
      emit(PengaturanError(
          message: 'baru:Password baru minimal 8 karakter',
          profile: currentProfile));
      return;
    }
    if (event.konfirmasi.isEmpty) {
      emit(PengaturanError(
          message: 'konfirmasi:Konfirmasi password tidak boleh kosong',
          profile: currentProfile));
      return;
    }
    if (event.passwordBaru != event.konfirmasi) {
      emit(PengaturanError(
          message: 'konfirmasi:Konfirmasi password tidak cocok',
          profile: currentProfile));
      return;
    }

    emit(PasswordSaving(profile: currentProfile));
    try {
      await ubahPasswordUsecase(
        passwordLama: event.passwordLama,
        passwordBaru: event.passwordBaru,
      );
      emit(PasswordChanged(profile: currentProfile));
    } on Exception catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '');
      emit(PengaturanError(
          message: 'lama:$msg',
          profile: currentProfile));
    }
  }
}
