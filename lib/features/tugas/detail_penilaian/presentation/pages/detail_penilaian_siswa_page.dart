import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fitur_guru/core/constants/colors.dart';
import '../../data/datasources/detail_penilaian_local_datasource.dart';
import '../../data/repositories/detail_penilaian_repository_impl.dart';
import '../../domain/usecase/get_detail_penilaian_usecase.dart';
import '../../domain/usecase/submit_penilaian_usecase.dart';
import '../bloc/detail_penilaian_bloc.dart';
import '../widgets/detail_penilaian_app_bar.dart';
import '../widgets/empty_detail_widgets.dart';
import '../widgets/feedback_input_card.dart';
import '../widgets/lampiran_tugas_card.dart';
import '../widgets/loading_detail_penilaian_widgets.dart';
import '../widgets/nilai_input_card.dart';
import '../widgets/simpan_penilaian_button.dart';
import '../widgets/siswa_profile_card.dart';

// ── Navigation Arguments ─────────────────────────────────────────
class DetailPenilaianArgs {
  final String siswaId;
  final String tugasId;
  const DetailPenilaianArgs({required this.siswaId, required this.tugasId});
}

// ── Entry Point Page ─────────────────────────────────────────────
class DetailPenilaianSiswaPage extends StatelessWidget {
  final DetailPenilaianArgs args;
  const DetailPenilaianSiswaPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    // DI manual — swap dengan GetIt/injectable saat production
    final datasource = DetailPenilaianLocalDatasourceImpl();
    final repository = DetailPenilaianRepositoryImpl(datasource);
    return BlocProvider(
      create: (_) => DetailPenilaianBloc(
        getDetailPenilaian: GetDetailPenilaianUsecase(repository),
        submitPenilaian:    SubmitPenilaianUsecase(repository),
      )..add(LoadDetailPenilaianEvent(
          siswaId: args.siswaId, tugasId: args.tugasId)),
      child: const _DetailPenilaianView(),
    );
  }
}

// ── View dengan BlocConsumer ─────────────────────────────────────
class _DetailPenilaianView extends StatelessWidget {
  const _DetailPenilaianView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const DetailPenilaianAppBar(notifCount: 3),
      body: BlocConsumer<DetailPenilaianBloc, DetailPenilaianState>(
        listener: (context, state) {
          if (state is DetailPenilaianSubmitSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Row(children: const [
                  Icon(Icons.check_circle_rounded, color: Colors.white),
                  SizedBox(width: 10),
                  Text('Penilaian berhasil disimpan!'),
                ]),
                backgroundColor: AppColors.successGreen,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 2),
              ));
          }
          if (state is DetailPenilaianError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('Gagal: ${state.message}'),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
              ));
          }
        },
        builder: (context, state) {
          if (state is DetailPenilaianLoading) {
            return const LoadingDetailPenilaianWidget();
          }
          if (state is DetailPenilaianError) {
            return EmptyDetailWidget(message: state.message);
          }
          if (state is DetailPenilaianLoaded) {
            return _DetailPenilaianBody(loaded: state, isSubmitting: false);
          }
          if (state is DetailPenilaianSubmitting) {
            // Ambil state loaded terakhir dari context
            final bloc = context.read<DetailPenilaianBloc>();
            final prev = bloc.state;
            if (prev is DetailPenilaianLoaded) {
              return _DetailPenilaianBody(loaded: prev, isSubmitting: true);
            }
          }
          return const LoadingDetailPenilaianWidget();
        },
      ),
    );
  }
}

// ── Body — susunan semua card ────────────────────────────────────
class _DetailPenilaianBody extends StatelessWidget {
  final DetailPenilaianLoaded loaded;
  final bool isSubmitting;
  const _DetailPenilaianBody({required this.loaded, required this.isSubmitting});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DetailPenilaianBloc>();
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SiswaProfileCard(entity: loaded.entity),
            const SizedBox(height: 16),
            LampiranTugasCard(
              fileName: loaded.entity.attachmentFileName,
              previewUrl: loaded.entity.attachmentPreviewUrl,
              onDownload: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Mengunduh file lampiran...'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            NilaiInputCard(
              currentNilai: loaded.currentNilai,
              onNilaiChanged: (v) => bloc.add(UpdateNilaiEvent(v)),
            ),
            const SizedBox(height: 16),
            FeedbackInputCard(
              currentFeedback: loaded.currentFeedback,
              onFeedbackChanged: (v) => bloc.add(UpdateFeedbackEvent(v)),
            ),
            const SizedBox(height: 28),
            SimpanPenilaianButton(
              isLoading: isSubmitting,
              onPressed: () => bloc.add(const SubmitPenilaianEvent()),
            ),
          ],
        ),
      ),
    );
  }
}