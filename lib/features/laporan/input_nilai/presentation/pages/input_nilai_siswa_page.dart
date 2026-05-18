import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fitur_guru/core/constants/colors.dart';
import 'package:fitur_guru/features/laporan/input_nilai/presentation/bloc/input_nilai_bloc.dart';
import 'package:fitur_guru/features/laporan/input_nilai/presentation/bloc/input_nilai_event.dart';
import 'package:fitur_guru/features/laporan/input_nilai/presentation/bloc/input_nilai_state.dart';
import 'package:fitur_guru/features/laporan/input_nilai/presentation/widgets/empty_nilai_widget.dart';
import 'package:fitur_guru/features/laporan/input_nilai/presentation/widgets/export_pdf_button.dart';
import 'package:fitur_guru/features/laporan/input_nilai/presentation/widgets/input_nilai_app_bar.dart';
import 'package:fitur_guru/features/laporan/input_nilai/presentation/widgets/ranking_siswa_card.dart';
import 'package:fitur_guru/features/laporan/input_nilai/presentation/widgets/statistik_utama_card.dart';

class InputNilaiSiswaPage extends StatefulWidget {
  const InputNilaiSiswaPage({super.key});

  @override
  State<InputNilaiSiswaPage> createState() => _InputNilaiSiswaPageState();
}

class _InputNilaiSiswaPageState extends State<InputNilaiSiswaPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final bloc = context.read<InputNilaiBloc>();
      if (bloc.state is InputNilaiInitial) {
        bloc.add(const LoadRankingEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.paddingOf(context).bottom + 16,
        ),
        child: InputNilaiExportPdfButton(
          onPressed: () {
            context.read<InputNilaiBloc>().add(const ExportPdfEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('PDF akan disimpan (dummy).'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const InputNilaiAppBar(),
          Expanded(
            child: BlocBuilder<InputNilaiBloc, InputNilaiState>(
              builder: (context, state) {
                if (state is InputNilaiLoading || state is InputNilaiInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is InputNilaiEmpty) {
                  return const EmptyNilaiWidget();
                }
                if (state is InputNilaiError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 16),
                          FilledButton(
                            onPressed: () => context.read<InputNilaiBloc>().add(
                                  const LoadRankingEvent(),
                                ),
                            child: const Text('Coba lagi'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state is InputNilaiLoaded) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 88),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 16),
                              StatistikUtamaCard(statistics: state.statistics),
                              const SizedBox(height: 16),
                              RankingSiswaCard(
                                rankings: state.rankings,
                                showAll: state.showAll,
                                onToggleShowAll: () => context
                                    .read<InputNilaiBloc>()
                                    .add(const ToggleShowAllEvent()),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
